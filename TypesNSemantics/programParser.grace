dialect "combinators"
import "gUnit" as gU

def sequence = _prelude.sequence

////////////////////////////////////////////////////////////
// Grace Parser
////////////////////////////////////////////////////////////

def ws = whiteSpaceParser
def end = atEndParser

// top level
def program = rule {codeSequence ~ ws.many ~ end}
def codeSequence = rule { (declaration | statement).manySepOrTermBy(semicolon) }
def innerCodeSequence = 
    rule { (innerDeclaration | statement).manySepOrTermBy(semicolon) }


// declarations

def declaration =      rule { varDeclaration | defDeclaration | classDeclaration | typeDeclaration | methodDeclaration }
def innerDeclaration = rule { varDeclaration | defDeclaration | classDeclaration | typeDeclaration }

def varDeclaration = rule { varId ~ identifier ~ ?(colon ~ typeExpression) ~ ?(assign ~ expression) }
def defDeclaration = rule { defId ~ identifier ~ (colon ~ typeExpression).option ~ equals ~ expression }
def methodDeclaration = rule { methodId ~ methodHeader ~ methodReturnType ~ whereClause ~ lBrace ~ innerCodeSequence ~ rBrace }
def classDeclaration = rule { classId ~ identifier ~ dot ~ classHeader ~ methodReturnType ~ whereClause ~ lBrace ~ codeSequence ~ rBrace }

def methodHeader = rule {       //warning: order is significant!
         accessingAssignmentMethodHeader | accessingMethodHeader | assignmentMethodHeader | 
             methodWithArgsHeader | unaryMethodHeader | operatorMethodHeader | prefixMethodHeader
}

def classHeader = rule { methodWithArgsHeader | unaryMethodHeader }

def unaryMethodHeader = rule { identifier ~ typeParameters } 
def methodWithArgsHeader = rule { firstArgumentHeader ~  (argumentHeader).many1SepBy(ws.option) }
def firstArgumentHeader = rule { identifier ~ typeParameters ~ parameters }
def argumentHeader = rule { identifier ~ parameters }
def operatorMethodHeader = rule { otherOp ~ oneParameter } 
def prefixMethodHeader = rule { ws.option ~ token ("prefix") ~ otherOp }  // forbid space after prefix?
def assignmentMethodHeader = rule { identifier ~ assign ~ oneParameter }
def accessingMethodHeader = rule { lrBrack ~ typeParameters ~ parameters }
def accessingAssignmentMethodHeader = rule { lrBrack ~ assign ~ typeParameters ~ parameters }

def methodReturnType = rule { (arrow ~ nonEmptyTypeExpression ).option  } 

def parameters = rule { (lParen ~ (identifier ~ colon ~ typeExpression).many1SepBy(comma) ~ rParen).option }
def oneParameter = rule { lParen ~ identifier ~ (colon ~ typeExpression).option ~ rParen}
def blockParameters = rule { (identifier ~ (colon ~ typeExpression).option).many1SepBy(comma) }

def matchBinding = rule{ (identifier | literal | parenExpression) ~ (colon ~ nonEmptyTypeExpression ~ matchingBlockTail.option).option }
def matchingBlockTail = rule { lParen ~ matchBinding.many1SepBy(comma)  ~ rParen }

def typeDeclaration = rule { typeId ~ identifier ~ typeParameters ~ equals ~ typeExpression ~ semicolon ~ whereClause}

def typeExpression = rule { (ws.option ~ typeOpExpression ~ ws.option) | ws.option }
def nonEmptyTypeExpression = rule { ws.option ~ typeOpExpression ~ ws.option }

def typeOp = rule { opsymbol ("|") | opsymbol ("&") | opsymbol ("+") } 

// def typeOpExpression = rule { basicTypeExpression.many1SepBy(typeOp) }

def typeOpExpression = rule {    // this complex rule ensures two different typeOps have no precedence
     var otherOperator 
     basicTypeExpression ~ ws.option ~
         ( typeOp.onlyIf { s -> otherOperator:= s; true } ~
             basicTypeExpression ~ ws.option.many1SepBy(
                typeOp.onlyIf { s -> s == otherOperator }
             )
         ).option
     } 

def basicTypeExpression = rule { nakedTypeLiteral | literal | pathTypeExpression | parenTypeExpression }  
        // if we keep this, note it is formally ambiguous: in a typeExpression context { a; } is  interpreted as 
        // type { a; } otherwise as the block { a; }

def pathTypeExpression = rule { (superId ~ dot).option ~ (identifier ~ typeArguments).many1SepBy(dot) }

def parenTypeExpression = rule { lParen ~ typeExpression ~ rParen } 



// statements

def statement = rule { returnStatement | (expression ~ assignmentTail.option) } 
         // need constraints here on which expressions can have an assignmentTail
         // could try to rewrite as options including (expression ~ arrayAccess ~ assignmentTail)
         // expression ~ dot ~ identifier ~ assignmentTail 
          
def returnStatement = rule { symbol ("return") ~ ws.option ~ expression.option }  //doesn't need parens
def assignmentTail = rule { assign ~ expression }

// expressions

def expression = rule { opExpression } 

//def opExpression = rule { addExpression.many1SepBy(otherOp)}

def opExpression = rule {    // this complex rule ensures two different otherOps have no precedence
     var otherOperator 
     addExpression ~ ws.option ~
         ( otherOp.onlyIf { s -> otherOperator:= s; true } ~
             addExpression ~ ws.option.many1SepBy(
                otherOp.onlyIf { s -> s == otherOperator }
             )
         ).option
     } 

def addExpression = rule { multExpression.many1SepBy(addOp) }
def multExpression = rule { prefixExpression.many1SepBy(multOp) }
def prefixExpression = rule { (*otherOp ~ selectorExpression) | (+otherOp ~ superId) }  // can have !super
def selectorExpression = rule { primaryExpression ~ *selector }

def selector = rule { (dot ~ unaryRequest) | 
                           (dot ~ requestWithArgs) |
                           (lBrack ~ expression.many1SepBy(comma) ~ rBrack)  
                         }

def operatorChar = characterSetParser "!?@#$%^&|~=+-*/><:." // had to be moved up

// special parser for operator symbols: cannot be followed by another operatorChar
method opsymbol (s:String) { 
    ((token (s) ~ operatorChar.not).trim) => { os -> sequence.with(os) }
}

def multOp = opsymbol "*" | opsymbol "/" 
def addOp = opsymbol "+" | opsymbol "-" 
def otherOp = rule { (operatorChar.many1.onlyIf { s ->
        ! parse (flattenStr(s)) with (reservedOp ~ end) }) 
    }  // encompasses multOp and addOp

def operator = rule { otherOp | reservedOp }
def unaryRequest = rule { identifier.trim ~ typeArguments ~ delimitedArgument.not }
def requestWithArgs = rule { firstRequestArgumentPart ~ (requestArgumentPart).manySepBy(ws.option) }
def firstRequestArgumentPart = rule { identifier ~ typeArguments ~ ws.option ~ delimitedArgument }
def requestArgumentPart = rule { identifier ~ ws.option ~ delimitedArgument }
def delimitedArgument = rule { argumentsInParens | blockLiteral | stringLiteral }
def argumentsInParens = rule { lParen ~ expression.many1SepBy(comma) ~ rParen  }

def implicitSelfRequest = rule { requestWithArgs |  unaryRequest.many1SepBy(dot) }

def primaryExpression = rule { literal | nonNakedSuper | implicitSelfRequest | parenExpression }  

def parenExpression = rule { lParen ~ expression.many1SepBy(semicolon) ~ rParen }
    // TODO: should parenExpression be around a codeSequence?

def nonNakedSuper = rule { superId ~ (operator|lBrack).not.not }

// "generics" 
def typeArguments = rule { (lGeneric ~ typeExpression.many1SepBy(comma) ~ rGeneric).option }
def typeParameters = rule { (lGeneric ~ identifier.many1SepBy(comma) ~ rGeneric).option }

def whereClause = rule { (whereId ~ typePredicate).manySepOrTermBy(semicolon) }
def typePredicate = rule { expression }

// TODO - wherever typeParameters appear, there should be a whereClause nearby.


// literals

def literal = rule { stringLiteral | selfLiteral | blockLiteral | numberLiteral | objectLiteral | tupleLiteral | typeLiteral } 
def stringLiteral = rule { ws.option ~ doubleQuote ~ stringChar.many ~ doubleQuote ~ ws.option } *=>
    { _, _, xs, _, _ ->  flattenStr(xs) }
def stringChar = rule { (backslash.drop ~ escapeChar) | both (anyChar, doubleQuote.not) }
def blockLiteral = rule { lBrace ~ ((matchBinding | blockParameters) ~ arrow).option ~ innerCodeSequence ~ rBrace }
def selfLiteral = symbol "self" 
def numberLiteral = digitStringParser.trim => { ds -> sequence.with(ds) }
def objectLiteral = rule { objectId ~ lBrace ~ codeSequence ~ rBrace }
def tupleLiteral = rule { lBrack ~ (expression).manySepBy(comma) ~ rBrack }

def typeLiteral = rule { typeId ~ ws.option ~ nakedTypeLiteral }
def nakedTypeLiteral = rule { lBrace ~ ws.option ~
    (methodHeader ~ methodReturnType).manySepOrTermBy(semicolon | whereClause) ~
        ws.option ~ rBrace
}

// terminals

def backslash = symbol "\\"    // doesn't belong here, doesn't work if left below!
def doubleQuote = symbol "\""
def space = symbol " "
def semicolon = rule { (symbol ";" ~ (newLine.trim)).option }
def colon = rule { both (symbol ":", assign.not) }
def newLine = symbol "\n" 
def lParen = symbol "("
def rParen = symbol ")" 
def lBrace = symbol "\{"
def rBrace = symbol "\}"
def lBrack = symbol "["
def rBrack = symbol "]"
def lrBrack = symbol "[]"
def arrow = symbol "->"
def dot = symbol "."
def assign = symbol ":="
def equals = symbol "="

def lGeneric = ws.option.drop ~ symbol "<"   // no white space after
def rGeneric = symbol ">" ~ ws.option.drop   // no white space before

def comma = rule { symbol "," }
def escapeChar = characterSetParser "\\\"'\{\}bnrtlfe "
def anyChar = anyCharParser
def identifierToken = identifierParser.trim
def identifier = rule { (identifierToken.onlyIf { s ->
    ! parse (s) with (reservedIdentifier ~ end) }) =>
        { id -> sequence.with(id) }
    // probably works but runs out of stack
}


def superId = symbol "super" 
def extendsId = symbol "extends"
def classId = symbol "class" 
def objectId = symbol "object" 
def typeId = symbol "type" 
def whereId = symbol "where" 
def defId = symbol "def" 
def varId = symbol "var" 
def methodId = symbol "method" 
def prefixId = symbol "prefix" 
def interfaceId = symbol "interface"

def reservedIdentifier = rule {
         selfLiteral | superId | extendsId | classId | objectId | typeId | whereId |
               defId | varId | methodId | prefixId | interfaceId
} // more to come

def reservedOp = rule {assign | equals | dot | arrow | colon | semicolon}  // this is not quite right


//////////////////////////////////////////////////
// Grace Parser Tests
//////////////////////////////////////////////////

method test (block:Block) expecting (result:Object) comment (comment:String) {
    def rv = block.apply
    if (rv == result)
        then { print "------: {comment}" }
        else { print "FAILED: ‹{rv}› should be ‹{result}›. {comment}" }
}

method test (parser:Parser) on (s:String) correctly (comment:String) {
    def res = parser.parse (stringInputStream (s,1))
    def output = res.outputIfFailed {
        print "FAILED: {comment} on {s}"
        return
    }
    print "------: {comment} ‹{s}› => ‹{output}›"
}

method test (parser:Parser) on (s:String) wrongly (comment:String) {
    def success = parser.parse (stringInputStream (s,1)).succeeded
    if  (success.not) then {
        print  ("------: " ++ comment ++ " " ++  s)
    } else {
        print  ("FAILED: " ++ comment ++ " " ++  s)
    } 
}

method testProgram (s:String) correctly (comment:String) {
     test (program) on (s) correctly (comment)
}

method testProgram (s:String) wrongly (comment:String) {
     test (program) on (s) wrongly (comment)
}

print "------: starting parser tests defs"

def t001 = stringInputStream ("print (\"Hello, world.\")",1)
def t001s = stringInputStream ("print (\"Hello, world.\")",7)
def t001c = stringInputStream ("print (\"Hello, world.\")",8)
def t001ss = stringInputStream ("print \"Hello, world.\"",1)
def t001b = stringInputStream ("print \{ foo; bar; \}",1)

def t002 = stringInputStream ("hello",1)
def t003 = stringInputStream ("print (\"Hello, world.\") print (\"Hello, world.\")" ,1)
def t003a = stringInputStream ("print (\"Hello, world.\")print (\"Hello, world.\")" ,1)


class grammarTest.forMethod(m) {
    inherits gU.testCaseNamed(m)

    def t001 = stringInputStream ("print (\"Hello, world.\")",1)
    def t001s = stringInputStream ("print (\"Hello, world.\")",7)
    def t001c = stringInputStream ("print (\"Hello, world.\")",8)
    def t001ss = stringInputStream ("print \"Hello, world.\"",1)
    def t001b = stringInputStream ("print \{ foo; bar; \}",1)

    def t002 = stringInputStream ("hello",1)
    def t003 = stringInputStream ("print (\"Hello, world.\") print (\"Hello, world.\")" ,1)
    def t003a = stringInputStream ("print (\"Hello, world.\")print (\"Hello, world.\")" ,1)

    method check (p:Parser) on (in:String) at(pos) output (out:String) position (n:Number) {
        def result = p.parse (stringInputStream (in,pos))
        if  (result.succeeded) then {
            assert (result.outputIfFailed {}) shouldBe (out)
            assert (result.next.position) shouldBe (n)
        } else {
            failBecause (result.message)
        }
    }
    
    method check (p:Parser) on (in:String) output (out:String) position (n:Number) {
        check (p) on (in) at 1 output (out) position (n)
    }

    
    method fail (p:Parser) on (in:String) {
        def result = p.parse (stringInputStream (in,1))
        def output = result.outputIfFailed { assert (true) ; return }
        failBecause "parser succeded with {output} when it should have failed"

    }

    method testSymbolPrint {
        check (symbol "print") on ‹print ("Hello, world.")›
            output "print" position 6
        fail (symbol "print") on ‹pront ("Hello, world.")›
    }
    
    method testNewlineFail {
        fail (newLine) on ‹print ("Hello, world.")›
    }
    
    method testNewlineOK {
        check (newLine) on "return\n    " at 7 output "\n" position 8
    }
    
    method testStringLiteralOK {
        def i = "print (\"Hello, world.\")"
        check (stringLiteral) on (i) at 8 output "Hello, world." position (i.size)
        // should leave stream at the right paren
    }
}

def grammarTests = gU.testSuite.fromTestMethodsIn(grammarTest)
grammarTests.runAndPrintResults


print "------:  manual parser tests"


test (requestWithArgs ~ end) on ("print (\"Hello World\")") correctly ("001-RWA")
test (requestWithArgs ~ end) on ("print \"Hello World\"") correctly ("001-RWA-noparens")
test (implicitSelfRequest ~ end) on ("print (\"Hello World\")") correctly ("001-ISR")
test (implicitSelfRequest ~ end) on ("print \"Hello World\"") correctly ("001-ISR-noparens")
test (expression ~ end) on ("print (\"Hello World\")") correctly ("001-Exp")
test (expression ~ end) on ("print \"Hello World\"") correctly ("001-Exp-noparens")

test {program.parse (t002).succeeded}
          expecting (true)
          comment "002-helloUnary"
test {program.parse (t003).succeeded}
          expecting (true)
          comment "003-hello hello"
test {program.parse (t003).succeeded}
          expecting (true)
          comment "003a-hellohello"
test {program.parse (t001ss).succeeded}
          expecting (true)
          comment "001ss-stringarg"
test {program.parse (t001b).succeeded}
          expecting (true)
          comment "001b-blockarg"
testProgram ("self") correctly ("004-self")
testProgram ("(self)") correctly ("004p-self")
testProgram ("(hello)") correctly ("004p-hello")
test (expression ~ end) on ("foo") correctly ("005-foo")
test (expression ~ end) on ("(foo)") correctly ("005-foo")
test (primaryExpression ~ end) on ("(foo)") correctly ("005-pri (foo)")
test (argumentsInParens ~ end) on ("(foo)") correctly ("005-aIP (foo)")
test (requestArgumentPart ~ end) on ("print (\"Hello\")") correctly ("005-racqhello")

test (identifier ~ end) on ("foo") correctly ("006id")
test (expression ~ end) on ("foo") correctly ("006exp")
test (primaryExpression ~ end) on ("foo") correctly ("006primaryExp")
test (addOp ~ end) on ("+") correctly ("006plus is addOp")

test (expression ~ end) on ("foo+foo") correctly ("006exp")
test (expression ~ end) on ("foo + foo") correctly ("006exp")
test (addOp ~ end) on ("+") correctly ("006")
test (multExpression ~ end) on ("foo") correctly ("006mult")
test (addExpression ~ end) on ("foo + foo") correctly ("006add")
test (expression ~ end) on ("foo + foo + foo") correctly ("006expr")
test (expression ~ end) on ("foo * foo + foo") correctly ("006expr")
test (expression ~ end) on ("((foo))") correctly ("006expr")
test (parenExpression ~ end ) on ("((foo))") correctly ("006paren")
test (otherOp ~ end) on ("%%%%%") correctly ("006other")
test (opExpression ~ end) on ("foo") correctly "006OpExprFOO"
test (opExpression ~ end) on ("foo %%%%% foo") correctly ("006OpExprTWO")
test (opExpression ~ end) on ("foo %%%%% foo %%%%% foo") correctly ("006OpExpr")
test (identifier ~ otherOp ~ identifier ~ otherOp ~ identifier ~ end) on ("foo %%%%% foo %%%%% foo") correctly ("006OpExprHACK")
test (identifier ~ otherOp ~ identifier ~ otherOp ~ identifier ~ end) on ("foo%%%%%foo%%%%%foo") correctly ("006OpExprHACKnows")
test (expression ~ end) on ("foo %%%%% foo %%%%% foo") correctly ("006expr")
test (parenExpression ~ end) on ("(foo + foo)") correctly ("006parenE")
test (lParen ~ identifier ~ addOp ~ identifier ~ rParen ~ end) on ("(foo + foo)") correctly ("006hack")
test (lParen ~ primaryExpression ~ addOp ~ primaryExpression ~ rParen ~ end) on ("(foo + foo)") correctly ("006hackPrimary")
test (lParen ~ multExpression ~ addOp ~ multExpression ~ rParen ~ end) on ("(foo + foo)") correctly ("006hackMult")
test (lParen ~ multExpression.many1SepBy(addOp) ~ rParen ~ end) on ("(foo + foo)") correctly ("006hackRepSep")
test (lParen ~ multExpression.manySepBy(addOp) ~ rParen ~ end) on ("(foo+foo)") correctly ("006hackRepSep2")
test (lParen ~ multExpression ~ addOp.manySepBy(multExpression) ~ rParen ~ end) on ("(foo+foo)") wrongly ("006hackRepSep2F")
test (lParen ~ multExpression ~ (addOp).manySepBy(multExpression) ~ rParen ~ end) on ("(foo + foo)") wrongly ("006hackRepSepF")
test (expression ~ end) on ("(foo + foo)") correctly ("006")
test (expression ~ end) on ("(foo + foo) - foo") correctly ("006")
test (expression ~ end) on ("(foo + foo - foo)") correctly ("006")
test (expression ~ end) on ("(foo+foo)-foo") correctly ("006")
test (expression ~ end) on ("hello (foo+foo)") correctly ("006")

testProgram "print (1)" correctly "006z"
testProgram " print (1)" correctly "006z"
testProgram "print ( 1    )" correctly "006z"
testProgram "print (1 + 2)" correctly "006z"
testProgram "print (1+2)" correctly "006z"
testProgram "print (1     +2    )" correctly "006z"
testProgram "print (10)" correctly "006z"
testProgram "print (10)" correctly "006z"
testProgram "print (10)  print (10)" correctly "006z"
testProgram "print (10)print (10)" correctly "006z"
testProgram "print (10)print (10)" correctly "006z"
testProgram "print (1+2) print (3 * 4)" correctly "006z"
testProgram "foo (10) foo (11)" correctly "006z"
testProgram "print (foo (10) foo (11))" correctly "006z"
testProgram "print   ( foo ( 10 ) foo   ( 11 ) )" correctly "006z"
testProgram "print (foo (10) foo (11) foo (12))" correctly "006z"
testProgram "print (foo (10) foo (11)) print (3)" correctly "006z"
testProgram "3*foo" correctly "006z"
testProgram " 3 * foo" correctly "006z"
testProgram "print (3*foo)" correctly "006z"
testProgram "print (3*foo) print (5*foo)" correctly "006z"
testProgram "4;5;6" correctly "006z"
testProgram " 4 ; 5 ; 6   " correctly "006z"
testProgram "print (4,5,6)" correctly "006z"
testProgram "print ((4;5;6))" correctly "006z"
testProgram "print ( 4   , 5 , 6 ) " correctly "006z"
testProgram "print ( ( 4 ; 5 ; 6 ) ) " correctly "006z"
testProgram " foo ; bar ; baz   " correctly "006z"
testProgram "foo;bar;baz" correctly "006z"
testProgram "foo := 3" correctly "006a"
testProgram "foo:=3" correctly "006a"
testProgram " foo := 3 " correctly "006a"
testProgram " foo := (3) " correctly "006a"
testProgram "foo:=(3)" correctly "006a"
testProgram "foo := 3+4" correctly "006a"
testProgram "foo := 3*4" correctly "006a"
testProgram "foo := baz" correctly "006a"

testProgram "foo" correctly "007"
test (unaryRequest ~ end) on "foo" correctly "007unary"
test (unaryRequest.many1SepBy(dot) ~ end) on "foo" correctly "007many1SepBy unary"
test (implicitSelfRequest ~ end) on "foo.foo" correctly "007ISR"
test (expression ~ end) on "foo.foo" correctly "007Exp"
testProgram "foo.foo" correctly "007"
testProgram " foo . foo " correctly "007"
testProgram "foo.foo (10)" correctly "007"
testProgram "foo.foo.foo" correctly "007"

test (numberLiteral ~ multOp ~ identifier.trim ~ lParen ~ numberLiteral ~ rParen) on "3*foo (50)" correctly "007hack"
test (numberLiteral ~ multOp ~ requestWithArgs ~ end) on "3*foo (50)" correctly "007hack"
test (implicitSelfRequest ~ end) on "foo (50)" correctly "007ISR"
testProgram "3*foo (50)" correctly "007"
testProgram " 3 * foo ( 50 )" correctly "007"
testProgram "(foo (50))*3" correctly "007"
testProgram "(foo ( 50 ) * 3)" correctly "007"
testProgram "foo (50)*3" correctly "007"
testProgram "foo ( 50 ) * 3" correctly "007"
testProgram "print (3*foo (50))" correctly "007"
testProgram "print ( 3 * foo ( 50 ) )" correctly "007"
testProgram "print (foo (10) foo (11)) print (3 * foo (50))" correctly "007"
testProgram "foo.foo (40).foo" correctly "007"

print "     :woot" 

test (typeExpression) on "  " correctly "008type1"
test (typeExpression ~ end) on "   " correctly "008type1"
test (typeExpression ~ end) on "Integer" correctly "008type2"
test (typeExpression ~ end) on "  Integer  " correctly "008type3"

testProgram "b (t (r (o)), not (re))" correctly "008" 
testProgram "\{ (dot ~ unaryRequest).many1 ~ opRequestXXX.many ~ (dot ~ keywordRequest).option \}" correctly "008"
testProgram " if (endPosition > string.size) then \{endPosition := string.size\}" correctly "008"
testProgram "  if ((n + position) <= (string.size + 1)) then \{return stringInputStream (string, position+n)\}" correctly "008"
testProgram "return (((c.ord >= \"A\".ord) & (c.ord <= \"Z\".ord))          | ((c.ord >= \"a\".ord) & (c.ord <= \"z\".ord)))" correctly "008"
testProgram "\{drop (ws.option) ~ p ~ drop (ws.option)\}" correctly "008" // OK ok JS, crashes on C
testProgram "drop (ws.option) ~ doubleQuote ~ rep ( stringChar ) ~ doubleQuote " correctly "008"
testProgram "" correctly "008"

testProgram " return (subParser.parse (in))" correctly "008"
testProgram " return (subParser.parse (in) .outputIfFailed)" correctly "008"
testProgram " (subParser.parse (in) .outputIfFailed)" correctly "008"
testProgram " \{f ->  return parseSuccess (in, \"\")\}" correctly "008"
testProgram " \{ return parseSuccess (in, \"\")\}" correctly "008"
testProgram " return (subParser.parse (in) .outputIfFailed \{f ->  return parseSuccess (in, \"\")\})" correctly "008"

testProgram "a" correctly "007x"
testProgram "a b" wrongly "007x"
testProgram "a b c" wrongly "007x"
testProgram "a b c d" wrongly "007x"

test (otherOp) on ".." correctly "008"
test (operatorChar.many1.trim) on ".." correctly "008"
test (operatorChar.many1.trim) on " .. " correctly "008"
testProgram " position..endPosition" correctly "008"
testProgram " for (position..endPosition)" correctly "008"
testProgram " for (position..endPosition) do (42)" correctly "008"
testProgram " \{ i:Number -> result \}" correctly "008"
testProgram " \{ result ++ string.at (i); \}" correctly "008"
testProgram " \{ result := result \}" correctly "008"
testProgram " \{ result := result ++ string.at (i); \}" correctly "008"
testProgram " for (position..endPosition) do \{ i:Number -> result := result ++ string.at (i); \}" correctly "008"
testProgram "a * * * * * * * * * b" correctly "008"

test (typeArguments ~ end) on "" correctly "009"
test (typeArguments ~ end) on "<T>" correctly "009"
test (typeArguments ~ end) on "<T,A,B>" correctly "009"
test (typeArguments ~ end) on "<T,A<B>,T>" correctly "009"
test (typeArguments ~ end) on "<T, A<B> , T>" correctly "009"
test (typeArguments ~ end) on "<A & B>" correctly "009"
test (typeArguments ~ end) on "<A&B>" correctly "009"
test (lGeneric ~ stringLiteral ~ comma ~ stringLiteral ~ rGeneric ~ end) on 
    "< \"foo\", \"bar\" >" wrongly "009b"
test (lGeneric ~ stringLiteral ~ comma ~ stringLiteral ~ rGeneric ~ end) on 
    "<\"foo\", \"bar\">" correctly "009b"
test (lGeneric ~ stringLiteral ~ comma ~ stringLiteral ~ rGeneric ~ end) on 
    "<\"foo\" , \"bar\">" correctly "009b"
test (lGeneric ~ stringLiteral ~ comma ~ stringLiteral ~ rGeneric ~ end) on 
    "<\"foo\",\"bar\">" correctly "009b"
test (typeArguments ~ end) on "< \"foo\", \"bar\" >" wrongly "009c"
test (typeArguments ~ end) on "<\"foo\",\"bar\">" correctly "009c"
test (typeArguments ~ end) on "< A , B >" wrongly "009c"
test (typeArguments ~ end) on "<A ,B >" wrongly "009c"
test (typeArguments ~ end) on "< A, B>" wrongly "009c"

testProgram "foo (34)" correctly "009"
testProgram "foo<T>" correctly "009"
testProgram "foo<T>(34)" correctly "009"
testProgram "foo<T,A,B>(34)" correctly "009"
testProgram "foo<T>(34) barf (45)" correctly "009"
testProgram "foo<T, A, B>(34) barf (45)" correctly "009"
testProgram "foo<T>" correctly "009"
testProgram "foo<T,A,B>" correctly "009"


testProgram "1*2+3" correctly "010"
testProgram "1+2*3" correctly "010"
testProgram "1+2-3+4" correctly "010"
testProgram "5*6/7/8" correctly "010"
testProgram "1*3-3*4" correctly "010"
testProgram "!foo.bar" correctly "010"
testProgram "!foo.bar * zarp" correctly "010"
testProgram "1 %% 2 * 3 %% 4 + 5" correctly "010"
testProgram "1 %% 2 ** 3 %% 4 ++ 5" wrongly "010"
testProgram "1 ?? 2 !! 3 $$ 4" wrongly "010"

testProgram "1*2+3" correctly "010a"
testProgram "1+2*3" correctly "010a"
testProgram "1 @ 2+3" correctly "010a"
testProgram "1 + 2 @ 3" correctly "010a"
testProgram "1 @ 2*3" correctly "010a"
testProgram "1 * 2 @ 3" correctly "010a"
testProgram "1 @ 2*3 + 4" correctly "010a"
testProgram "1 * 2 @ 3 + 4" correctly "010a"


testProgram "foo[10]" correctly "010"
testProgram "foo[10,20]" correctly "010"
testProgram "foo[\"10\"]" correctly "010"
testProgram "foo[14+45]" correctly "010"
testProgram "foo[bar]" correctly "010"
testProgram "foo[bar.baz]" correctly "010"
testProgram "foo[10][20][30]" correctly "010"
testProgram "foo[bar (1) baz (2)]" correctly "010"
testProgram "foo[bar[10]]" correctly "010"
testProgram "foo[bar[10].baz[e].zapf]" correctly "010"

testProgram "super" wrongly "011"
testProgram "return super" wrongly "011"
testProgram "super.foo" correctly "011"
testProgram "super.foo.bar" correctly "011"
testProgram "super.foo (1) bar (2)" correctly "011"
testProgram "super + 3" correctly "011"
testProgram "super +&^#%$ 3" correctly "011"
testProgram "super[3]" correctly "011"
testProgram "!super" correctly "011"

testProgram "def" wrongly "012"
testProgram "def x" wrongly "012"
testProgram "def x = " wrongly "012"
testProgram "def x := " wrongly "012"
testProgram "def x:T =" wrongly "012"
testProgram "def x:T := 4" wrongly "012"

testProgram "var" wrongly "012"
testProgram "var x = " wrongly "012"
testProgram "var x := " wrongly "012"
testProgram "var x:T :=" wrongly "012"
testProgram "var x:T = 4" wrongly "012"

testProgram "def x:T = 4" correctly "012"
testProgram "var x:T := 4" correctly "012"
testProgram "def x = 4" correctly "012"
testProgram "var x := 4" correctly "012"
testProgram "var x:=4" correctly "012"
test (varId ~ identifier ~ assign ~ numberLiteral) on "var x := 4" correctly "012"
test (varId ~ identifier ~ assign ~ expression) on "var x := 4" correctly "012"
test (varId ~ identifier ~ (assign ~ expression).option) on "var x := 4" correctly "012"
test (varDeclaration) on "var xVarDec := 4" correctly "012"
test (declaration) on "var xDec := 4" correctly "012"
test (codeSequence) on "var xCodeSeq := 4" correctly "012"
test (program) on "var xParenProg := 4" correctly "012"
testProgram "var xProg := 4" correctly "012"
testProgram "var x:TTT := foobles.barbles" correctly "012"
testProgram "var x := foobles.barbles" correctly "012"

test (defId ~ identifier) on "def x" correctly "012d"
test (defId ~ identifier) on "def typeExpression" correctly "012d"
test (defId ~ identifier ~ equals) on "def typeExpression =" correctly "012d"
test (defId ~ identifier) on "def typeExpression = rule \{ identifier.trim | ws.option \}" correctly "012d1"
test (defId ~ identifier ~ equals) on "def typeExpression = rule \{ identifier.trim | ws.option \}" correctly "012d2"
test (defId ~ identifier ~ equals ~ expression) on "def typeExpression = rule \{ identifier.trim | ws.option \}" correctly "012d3"
test (defDeclaration) on "def typeExpression = rule \{ identifier.trim | ws.option \}" correctly "012d4"
test (declaration) on "def typeExpression = rule \{ identifier.trim | ws.option \}" correctly "012d5"
testProgram "def typeExpression = rule \{ identifier.trim | ws.option \}" correctly "012d6"
testProgram "rule \{ identifier.trim | ws.option \}" correctly "012d7"
testProgram "rule ( identifier.trim | ws.option )" correctly "012d8"

test (identifier) on "typeExpression" correctly "012d9"
test (identifier) on "superThing" correctly "012d9"
test (identifierToken) on "typeExpression" correctly "012d10"
test (identifierToken) on "superThing" correctly "012d10"

testProgram "var x := 4; foo; def b = 4; bar; baz" correctly "013a"
test (objectLiteral) on "object \{ \}" correctly "013a"
test (objectLiteral) on "object \{ var x := 4; foo; def b = 4; bar; baz \}" correctly "013a"
test (codeSequence) on "var x := 4; foo; def b = 4; bar; baz" correctly "013a"
test (codeSequence) on "var x := 4; foo; 3+4; def b = 4; bar; 1+2; baz;" correctly "013a"
testProgram "method foo \{a; b; c\}" correctly "013b"
testProgram "method foo \{a; b; c; \}" correctly "013b"
testProgram "method foo -> \{a; b; c\}" wrongly "013b2"
testProgram "method foo -> T \{a; b; c\}" correctly "013b3"
testProgram "method foo<T> \{a; b; c\}" correctly "013b4"
testProgram "method foo<T,V> \{a; b; c; \}" correctly "013b5"
testProgram "method foo<T> -> \{a; b; c\}" wrongly "013b6"
testProgram "method foo<T,V> -> T \{a; b; c\}" correctly "013b7"

test (methodHeader ~ end) on "foo" correctly "013c1"
test (firstArgumentHeader ~ end) on "foo (a)" correctly "013c11"
test (methodWithArgsHeader ~ end) on "foo (a)" correctly "013c11"
test (methodHeader ~ end) on "foo (a)" correctly "013c11"
test (firstArgumentHeader ~ end) on "foo (a,b)" correctly "013c12"
test (methodWithArgsHeader ~ end) on "foo (a,b)" correctly "013c12"
test (methodHeader ~ end) on "foo (a,b)" correctly "013c12"
test (methodWithArgsHeader ~ end) on "foo (a,b) foo (c,d)" correctly "013c13"
test (methodHeader ~ end) on "foo (a,b) foo (c,d)" correctly "013c13"
test (methodHeader ~ end) on "foo (a,b) foo " wrongly "013c14"

testProgram "method foo (a) \{a; b; c\}" correctly "013c"
testProgram "method foo (a, b, c) \{a; b; c\}" correctly "013c2"
testProgram "method foo (a:T) \{a; b; c\}" correctly "013c3"
testProgram "method foo (a:T, b:T, c:T) -> T \{a; b; c\}" correctly "013c4"
testProgram "method foo (a, b, c) -> T \{a; b; c\} " correctly "013c5"
testProgram "method foo (a:T, b:T, c:T) -> T \{a; b; c\}" correctly "013c6"
testProgram "method foo (a:T, b:T, c:T) foo (a:T, b:T, c:T) -> T \{a; b; c\}" correctly "013c6"
testProgram "method foo (a, b, c) \{a; b; c\}" correctly "013c7"
testProgram "method foo (a, b, c) bar (d,e)\{a; b; c\}" correctly "013c7"
testProgram "method foo (a:T, b:T, c:T) -> T \{a; b; c\}" correctly "013c8"
testProgram "method foo (a, b:T, c) -> F \{a; b; c\}" correctly "013c9"
testProgram "method foo<T>(a) \{a; b; c\}" correctly "013c"
testProgram "method foo<TER,MIN,US>(a, b, c) \{a; b; c\}" correctly "013c2"
testProgram "method foo<TXE>(a:T) \{a; b; c\}" correctly "013c3"
testProgram "method foo<T,U,V>(a:T, b:T, c:T) -> T \{a; b; c\}" correctly "013c4"
testProgram "method foo<T,U>(a:T, b:T, c:T) foo (a:T, b:T, c:T) -> T \{a; b; c\}" correctly "013c6"
testProgram "method foo (a:T, b:T, c:T) foo<T,U>(a:T, b:T, c:T) -> T \{a; b; c\}" wrongly "013c6"
testProgram "method foo<>(a:T, b:T, c:T) foo<T,U>(a:T, b:T, c:T) -> T \{a; b; c\}" wrongly "013c6"
testProgram "method foo<>(a:T, b:T, c:T)  \{a; b; c\}" wrongly "013c6"
testProgram "method foo<> \{a; b; c\}" wrongly "013c6"

testProgram "method +(x) \{a; b; c\}" correctly "013d1"
testProgram "method ==(x) \{a; b; c\}" correctly "013d1"
testProgram "method =(x) \{a; b; c\}" wrongly "013d1"
testProgram "method :=(x) \{a; b; c\}" wrongly "013d1"
testProgram "method ++***&%&(x) \{a; b; c\}" correctly "013d1"
testProgram "method +(x: T) \{a; b; c\}" correctly "013d2"
testProgram "method +(x) -> T \{a; b; c\}" correctly "013d3"
testProgram "method +(x:T) -> T \{a; b; c\}" correctly "013d3"
test (methodHeader) on "+ -> T" wrongly "013d5a"
testProgram "method + -> T \{a; b; c\}" wrongly "013d5"
testProgram "method +(x,y) T \{a; b; c\}" wrongly "013d6"
testProgram "method +(x:T, y:T) -> T \{a; b; c\}" wrongly "013d7"
testProgram "method +(x) +(y) -> T \{a; b; c\}" wrongly "013d8"

testProgram "method prefix+ \{a; b; c\}" correctly "013e1"
testProgram "method prefix + \{a; b; c\}" correctly "013e1"
testProgram "method prefix++***&%& \{a; b; c\}" correctly "013e1"
testProgram "method prefix ! \{a; b; c\}" correctly "013e1"
testProgram "method prefix+ -> \{a; b; c\}" wrongly "013e2"
testProgram "method prefix+(x) -> T \{a; b; c\}" wrongly "013e3"
testProgram "method prefix+(x:T) -> T \{a; b; c\}" wrongly "013e3"
testProgram "method prefix+ -> T \{a; b; c\}" correctly "013e5"
testProgram "method prefix+(x,y) T \{a; b; c\}" wrongly "013e6"
testProgram "method prefix+(x:T, y:T) -> T \{a; b; c\}" wrongly "013e7"
testProgram "method prefix+(x) +(y) -> T \{a; b; c\}" wrongly "013e8"
testProgram "method prefix (x) -> T \{a; b; c\}" wrongly "013e9"
testProgram "method prefix:= \{a; b; c\}" wrongly "013e1"
testProgram "method prefix := \{a; b; c\}" wrongly "013e1"
testProgram "method prefix[] \{a; b; c\}" wrongly "013e1"

//what should the *grammar* say about assignment op return values
test (assignmentMethodHeader) on "foo:=(a)" correctly "013a1"
test (assignmentMethodHeader) on "foo := ( a:T )" correctly "013a1"
test (assignmentMethodHeader) on "foo" wrongly "013a1"
test (assignmentMethodHeader) on "foobar:=" wrongly "013a1"
testProgram "method foo:=(a) \{a; b; c\}" correctly "013f"
testProgram "method bar :=(a) \{a; b; c\}" correctly "013f2"
testProgram "method foo:=(a:T) \{a; b; c\}" correctly "013f3"
testProgram "method foo :=(a:T) -> T \{a; b; c\}" correctly "013f4"
testProgram "method foo:=(a) -> T \{a; b; c\} " correctly "013f5"
testProgram "method foo:=(a:T, b:T, c:T) -> T \{a; b; c\}" wrongly "013f6"
testProgram "method foo:=(a:T, b:T, c:T) foo (a:T, b:T, c:T) -> T \{a; b; c\}" wrongly "013f6"
testProgram "method foo:=(a, b, c) \{a; b; c\}" wrongly "013f7"
testProgram "method foo:=(a, b, c) bar (d,e)\{a; b; c\}" wrongly "013f7"
testProgram "method foo:=(a:T, b:T, c:T) -> T \{a; b; c\}" wrongly "013f8"
testProgram "method foo:=(a, b:T, c) -> F \{a; b; c\}" wrongly "013f9"


testProgram "method [](x) \{a; b; c\}" correctly "013d1"
testProgram "method [](x, y, z) \{a; b; c\}" correctly "013d1"
testProgram "method []=(x) \{a; b; c\}" wrongly "013d1"
testProgram "method [=](x) \{a; b; c\}" wrongly "013d1"
testProgram "method []foo (x) \{a; b; c\}" wrongly "013d1"
testProgram "method foo[](x) \{a; b; c\}" wrongly "013d1"
testProgram "method [][]***&%&(x) \{a; b; c\}" wrongly "013d1"
testProgram "method [](x: T) \{a; b; c\}" correctly "013d2"
testProgram "method [](x) -> T \{a; b; c\}" correctly "013d3"
testProgram "method [](x:T) -> T \{a; b; c\}" correctly "013d3"
testProgram "method [] -> T \{a; b; c\}" wrongly "013d5"
testProgram "method [](x,y) T \{a; b; c\}" wrongly "013d6"
testProgram "method [](x:T, y:T) -> T \{a; b; c\}" correctly "013d7"
testProgram "method [](x) [](y) -> T \{a; b; c\}" wrongly "013d8"


testProgram "method []:=(x) \{a; b; c\}" correctly "013d1"
testProgram "method []:=(x, y, z) \{a; b; c\}" correctly "013d1"
testProgram "method [] :=(x) \{a; b; c\}" correctly "013d1"
testProgram "method [] :=(x, y, z) \{a; b; c\}" correctly "013d1"
testProgram "method []:==(x) \{a; b; c\}" wrongly "013d1"
testProgram "method [=](x) \{a; b; c\}" wrongly "013d1"
testProgram "method []:=foo (x) \{a; b; c\}" wrongly "013d1"
testProgram "method foo[]:=(x) \{a; b; c\}" wrongly "013d1"
testProgram "method []:=[]:=***&%&(x) \{a; b; c\}" wrongly "013d1"
testProgram "method []:=(x: T) \{a; b; c\}" correctly "013d2"
testProgram "method []:=(x) -> T \{a; b; c\}" correctly "013d3"
testProgram "method []:=(x:T) -> T \{a; b; c\}" correctly "013d3"
testProgram "method []:= -> T \{a; b; c\}" wrongly "013d5"
testProgram "method []:=(x,y) T \{a; b; c\}" wrongly "013d6"
testProgram "method []:=(x:T, y:T) -> T \{a; b; c\}" correctly "013d7"
testProgram "method []:=(x) []:=(y) -> T \{a; b; c\}" wrongly "013d8"

testProgram "[]" correctly "014a"
testProgram "[1,2,3]" correctly "014b"
testProgram "[ \"a\", \"a\", \"a\", 1]" correctly "014c"
testProgram "[ \"a\", \"a\", \"a\", 1" wrongly "014d"
testProgram "[ \"a\" \"a\" \"a\" 1]" wrongly "014e"
testProgram "[][3][4][5]" correctly "014f"

// "new" aka "Alt" Class syntax
testProgram "class Foo.new \{ \}" correctly "015a"
testProgram "class Foo.new \{ a; b; c \}" correctly "015b"
testProgram "class Foo.new \{ method a \{\}; method b \{\}; method c \{\}\}" correctly "015b"
testProgram "class Foo.new \{ def x = 0; var x := 19; a; b; c \}" correctly "015c"
testProgram "class Foo.new (a,b) \{ a; b; c;  \}" correctly "015d"
testProgram "class Foo.new (a:A, b:B) \{ a; b; c;  \}" correctly "015e"
testProgram "class Foo.new<A>(a:A, b:B) new (a:A, b:B) \{ a; b; c;  \}" correctly "015f"
testProgram "class Foo.new<A, B>(a:A, b:B) \{ a; b; c;  \}" correctly "015g"
testProgram "class Foo " wrongly "015h"
testProgram "class Foo a; b; c" wrongly "015i"
testProgram "class Foo<A> \{ def x = 0; var x := 19; a; b; c \}" wrongly "015j"
testProgram "class Foo \{ -> a; b; c;  \}" wrongly "015k"
testProgram "class Foo \{ a:<A>, b:<B> -> a; b; c;  \}" wrongly "015l"
testProgram "class Foo \{ -> <A> a:A, b:B  a; b; c;  \}" wrongly "015m"

testProgram "3+4.i" correctly "015z"

test (typeLiteral) on "type \{ \}" correctly "016cl"
test (typeLiteral) on "type \{ foo \}" correctly "016cl1"
test (typeLiteral) on "type \{ foo; bar; baz; \}" correctly "016cl2"
test (typeLiteral) on "type \{ prefix!; +(other:SelfType); baz (a,b) baz (c,d); \}" correctly "016cl3"

test (typeExpression ~ end) on "type \{ \}" correctly "016cx1"
test (typeExpression ~ end) on "type \{ foo \}" correctly "016cx2"
test (typeExpression ~ end) on "type \{ foo; bar; baz; \}" correctly "016cx3"
test (typeExpression ~ end) on "type \{ prefix!; +(other:SelfType); baz (a,b) baz (c,d); \}" correctly "016cx4"
test (typeExpression ~ end) on "\{ \}" correctly "016cx5"
test (typeExpression ~ end) on "\{ foo \}" correctly "016cx5"
test (typeExpression ~ end) on "\{ foo; bar; baz; \}" correctly "016cx7"
test (typeExpression ~ end) on "\{ prefix!; +(other:SelfType); baz (a,b) baz (c,d); \}" correctly "016cx8"

test ( (methodHeader ~ methodReturnType).manySepBy(semicolon)) on "foo -> T" correctly "016d1"
test ( (methodHeader ~ methodReturnType).manySepBy(semicolon)) on "foo" correctly "016d1"
test ( (methodHeader ~ methodReturnType).manySepBy(semicolon)) on "prefix!" correctly "016d1"
test ( (methodHeader ~ methodReturnType).manySepBy(semicolon)) on "+(x:T)" correctly "016d1"
test ( (methodHeader ~ methodReturnType).manySepBy(semicolon)) on "foo;" correctly "016d1"
test ( (methodHeader ~ methodReturnType).manySepBy(semicolon)) on "foo; bar;" correctly "016d1"
test ( (methodHeader ~ methodReturnType).manySepBy(semicolon)) on "foo; bar; baz" correctly "016d1"
test ( (methodHeader ~ methodReturnType).manySepBy(semicolon)) on "foo<T> -> T" correctly "016d1"
test ( (methodHeader ~ methodReturnType).manySepBy(semicolon)) on "foo<T>" correctly "016d1"
test ( (methodHeader ~ methodReturnType).manySepBy(semicolon)) on "prefix<T> !" correctly "016d1"
test ( (methodHeader ~ methodReturnType).manySepBy(semicolon)) on "+(x:T)" correctly "016d1"
test ( (methodHeader ~ methodReturnType).manySepBy(semicolon)) on "foo<T>;" correctly "016d1"
test ( (methodHeader ~ methodReturnType).manySepBy(semicolon)) on "foo<T>; bar<T>;" correctly "016d1"
test ( (methodHeader ~ methodReturnType).manySepBy(semicolon)) on "foo; bar<T>; baz<T>" correctly "016d1"
test (typeId ~ lBrace ~ (methodHeader ~ methodReturnType).manySepOrTermBy(semicolon) ~ rBrace) on "type \{ prefix!; +(other:SelfType); baz (a,b) baz (c,d); \}" correctly "016e"
test ( (methodHeader ~ methodReturnType).manySepOrTermBy(semicolon)) on "prefix!; +(other:SelfType); baz (a,b) baz (c,d)" correctly "016e"
test (typeExpression ~ end) on "T" correctly "016c"
test (lGeneric ~ typeExpression ~ rGeneric ~ end) on "<T>" correctly "016c"
test (typeExpression ~ end) on "type \{ \}" correctly "016c"
test (typeExpression ~ end) on "type \{ foo \}" correctly "016c"
test (typeExpression ~ end) on "type \{ foo; bar; baz; \}" correctly "016d"
test (typeExpression ~ end) on "type \{ prefix!; +(other:SelfType); baz (a,b) baz (c,d); \}" correctly "016e"
test (typeExpression ~ end) on "type \{ prefix!; +(other:SelfType); baz (a,b) baz (c,d); \}" correctly "016e"
test (typeExpression ~ end) on "" correctly "016a"
test (typeExpression ~ end) on "T" correctly "016a"
test (typeExpression ~ end) on "=T" wrongly "016a"
test (typeExpression ~ end) on "!T" wrongly "016a"
test (typeExpression ~ end) on "T<A,B>" correctly "016c"
test (typeExpression ~ end) on "A & B" correctly "016c"
test (typeExpression ~ end) on "A & B & C" correctly "016c"
test (typeExpression ~ end) on "A & B<X> & C" correctly "016ct"
test (typeExpression ~ end) on "A | B<X> | C" correctly "016ct"
test (expression ~ end) on "A & B (X) & C" correctly "016cx"
test (expression ~ end) on "A | B (X) | C" correctly "016cx"
test (expression ~ end) on "A & B<X> & C" correctly "016cx"
test (expression ~ end) on "A | B<X> | C" correctly "016cx"
test (typeExpression ~ end) on "A & B | C" wrongly "016c"
test (typeExpression ~ end) on "A & type \{ foo (X,T) \}" correctly "016c"
test (typeExpression ~ end) on " \"red\"" correctly "016t1"
test (typeExpression ~ end) on " \"red\" | \"blue\" | \"green\"" correctly "016t1"
test (typeExpression ~ end) on " 1 | 2 | 3 " correctly "016t1"
test (expression ~ end) on "\"red\"|\"blue\"|\"green\"" correctly "016t1"
test (expression ~ end) on " \"red\" | \"blue\" | \"green\"" correctly "016t1"
test (expression ~ end) on " 1 | 2 | 3 " correctly "016t1"
test (typeExpression ~ end) on "super.T<A,B>" correctly "016pt"
test (typeExpression ~ end) on "super.A & x.B" correctly "016pt"
test (typeExpression ~ end) on "super.A & a.B & a.C" correctly "test"
test (typeExpression ~ end) on "super.A & B<super.X> & C" correctly "016ptt"
test (typeExpression ~ end) on "A | B<X> | C" correctly "016ptt"
test (typeExpression ~ end) on "T<super.A.b.b.B.c.c.C,super.a.b.c.b.b.B>" correctly "016pt"
test (typeExpression ~ end) on "a<X,super.Y,z.Z>.a.A & b.b.B" correctly "016pt"
test (typeExpression ~ end) on "a<X,super.Y,z.Z>.a.A & b.b.B & c.c.C" correctly "016pt"
test (typeExpression ~ end) on "a<X,super.Y,z.Z>.a.A & b.b.B<X> & c.c.C" correctly "016ptt"
test (typeExpression ~ end) on "a<X,super.Y,z.Z>.a.A | b.b.B<X> | c.c.C" correctly "016ptt"
test (typeDeclaration ~ end) on "type A = B;" correctly "016td1"
test (typeDeclaration ~ end) on "type A=B;" correctly "016td2"
test (typeDeclaration ~ end) on "type A<B,C> = B & C;" correctly "016td3"
test (typeDeclaration ~ end) on "type A<B> = B | Noo | Bar;" correctly "016td4"
test (typeDeclaration ~ end) on "type Colours = \"red\" | \"green\" | \"blue\";" correctly "016td5"
test (typeDeclaration ~ end) on "type FooInterface = type \{a (A); b (B); \};" correctly "016td6"
test (typeDeclaration ~ end) on "type FooInterface = \{a (A); b (B); \};" correctly "016td7"
test (typeDeclaration ~ end) on "type PathType = super.a.b.C;" correctly "016td8"
test (typeDeclaration ~ end) on "type GenericPathType<A,X> = a.b.C<A,X>;" correctly "016td9"

test (whereClause ~ end) on "where T <: Sortable;" correctly "017a1"
test (whereClause ~ end) on "where T <: Foo<A,B>;" correctly "017a2"
test (whereClause ~ end) on "where T <: Foo<A,B>; where T <: Sortable<T>;" correctly "017a3"
testProgram "method foo<T>(a) where T < Foo; \{a; b; c\}" correctly "017c1"
testProgram "method foo<TER,MIN,US>(a, b, c) where TERM <: MIN <: US; \{a; b; c\}" correctly "017c2"
testProgram "method foo<TXE>(a:T) where TXE <: TXE; \{a; b; c\}" correctly "017c3"
testProgram "method foo<T,U,V>(a:T, b:T, c:T) -> T where T <: X<T>; \{a; b; c\}" correctly "017c4"
testProgram "method foo<T,U>(a:T, b:T, c:T) foo (a:T, b:T, c:T) -> T where T <: T; \{a; b; c\}" correctly "017c6"
testProgram "class Foo.new<A>(a:A, b:B) new (a:A, b:B) where T <: X; \{ a; b; c;  \}" correctly "017f"
testProgram "class Foo.new<A, B>(a:A, b:B) where A <: B; \{ a; b; c;  \}" correctly "017g"
testProgram "class Foo.new<A, B>(a:A, b:B) where A <: B; where A <: T<A,V,\"Foo\">; \{ a; b; c;  \}" correctly "017g"
testProgram "class Foo.new<A, B>(a:A, b:B) where A <: B; where A <: T<A,V,\"Foo\">; \{ method a where T<X; \{ \}; method b (a:Q) where T <: X; \{ \}; method c where SelfType <: Sortable<Foo>; \{ \} \}" correctly "017g"

test (matchBinding ~ end) on "a" correctly "018a1"
test (matchBinding ~ end) on "_" correctly "018a1"
test (matchBinding ~ end) on "0" correctly "018a1"
test (matchBinding ~ end) on "(a)" correctly "018a1"
test (matchBinding ~ end) on "\"Fii\"" correctly "018a1"
test (matchBinding ~ end) on "a:Foo" correctly "018a1"
test (matchBinding ~ end) on "a:Foo (bar,baz)" correctly "018a1"
test (matchBinding ~ end) on "a:Foo (_:Foo (a,b), _:Foo (c,d))" correctly "018a1"

test (blockLiteral ~ end) on "\{ _:Foo -> last \}" correctly "018b1"
test (blockLiteral ~ end) on "\{ 0 -> \"Zero\" \}" correctly "018b"
test (blockLiteral ~ end) on "\{ s:String -> print (s) \}" correctly "018b"
test (blockLiteral ~ end) on " \{ (pi) -> print (\"Pi = \" ++ pi) \}" correctly "018c"
test (blockLiteral ~ end) on " \{ _:Some (v) -> print (v) \}" correctly "018d"
test (blockLiteral ~ end) on " \{ _:Pair (v:Pair (p,q), a:Number) -> print (v) \}" correctly "018e"
test (blockLiteral ~ end) on " \{ _ -> print (\"did not match\") \}" correctly "018f"

testProgram "\{ _:Foo -> last \}" correctly "018b1"
testProgram "\{ 0 -> \"Zero\" \}" correctly "018b"
testProgram "\{ s:String -> print (s) \}" correctly "018b"
testProgram " \{ (pi) -> print (\"Pi = \" ++ pi) \}" correctly "018c"
testProgram " \{ _:Some (v) -> print (v) \}" correctly "018d"
testProgram " \{ _:Pair (v:Pair (p,q), a:Number) -> print (v) \}" correctly "018e"
testProgram " \{ _ -> print (\"did not match\") \}" correctly "018f"

testProgram "0" correctly "99z1"
testProgram "\"NOT FAILED AND DONE\"" correctly "99z2"

