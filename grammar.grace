import "parsers2" as parsers
inherits parsers.exports 

//////////////////////////////////////////////////
// Grace Grammar

class exports {
  //BEGINGRAMMAR
  // top level
  def program = rule {codeSequence ~ rep(ws) ~ end}
  def codeSequence = rule { repdel((declaration | statement | empty), semicolon) }
  def innerCodeSequence = rule { repdel((innerDeclaration | statement | empty), semicolon) }

  def moduleHeader = rule { rep(hashLine) ~ rep(importStatement | reuseClause) } 
  def hashLine = rule { (symbol "#") ~ rep(anyChar | space) ~ (newLine | end) }
  def importStatement = rule { importId ~ stringLiteral ~ asId ~ identifier ~ semicolon } 
 
  // def comment = 

  // declarations

  def declaration = rule { varDeclaration | defDeclaration | classOrTraitDeclaration | typeDeclaration | methodDeclaration }

  def innerDeclaration = rule { varDeclaration | defDeclaration | classOrTraitDeclaration | typeDeclaration }

  def varDeclaration = rule { varId ~ identifier ~  opt(colon ~ typeExpression) ~ opt(assign ~ expression) }

  def defDeclaration = rule { defId ~ identifier ~  opt(colon ~ typeExpression) ~ equals ~ expression }

  def methodDeclaration = rule { methodId ~ methodHeader ~ methodReturnType ~ whereClause ~ lBrace ~ innerCodeSequence ~ rBrace }

  def classOrTraitDeclaration = rule { (classId | traitId) ~ classHeader ~ methodReturnType ~ whereClause ~ lBrace ~ rep(reuseClause) ~ codeSequence ~ rBrace }

  //def oldClassDeclaration = rule { classId ~ identifier ~ lBrace ~ 
  //                             opt(genericParams ~ blockParams ~ arrow) ~ codeSequence ~ rBrace }


  //warning: order here is significant!
  def methodHeader = rule {  assignmentMethodHeader | methodWithArgsHeader | unaryMethodHeader | operatorMethodHeader | prefixMethodHeader  } 

  def classHeader = methodHeader    // rule { methodWithArgsHeader | unaryMethodHeader }
  def reuseClause = rule { (inheritId | useId) ~ expression ~ semicolon ~ rep(reuseModifiers) }  
  def reuseModifiers = rule { excludeClause | aliasClause } 
  def excludeClause = rule { excludeId ~ methodHeader ~ semicolon }
  def aliasClause = rule { aliasId ~ methodHeader ~ equals ~ methodHeader ~ semicolon }

  def unaryMethodHeader = rule { identifier ~ genericParams } 
  def methodWithArgsHeader = rule { firstArgumentHeader ~ repsep(argumentHeader,opt(ws)) }
  def firstArgumentHeader = rule { identifier ~ genericParams ~ methodParams }
  def argumentHeader = rule { identifier ~ methodParams }
  def operatorMethodHeader = rule { otherOp ~ genericParams ~ oneMethodParam } 
  def prefixMethodHeader = rule { opt(ws) ~ token("prefix") ~ otherOp ~ genericParams }
  def assignmentMethodHeader = rule { identifier ~ assign ~ genericParams ~ oneMethodParam }

  def methodReturnType = rule { opt(arrow ~ nonEmptyTypeExpression )  } 

  def methodParams = rule { lParen ~ rep1sep( identifier ~ opt(colon ~ opt(ws) ~ typeExpression), comma) ~ rParen} 

  def oneMethodParam = rule { lParen ~ identifier ~ opt(colon ~ typeExpression) ~ rParen}
  def blockParams = rule { repsep( identifier ~ opt(colon ~ typeExpression), comma) }

  def matchBinding = rule { (stringLiteral | numberLiteral | (lParen ~ identifier ~ rParen)) ~ opt(colon ~ nonEmptyTypeExpression) }


  def matchBindingOLD = rule{ (literal | parenExpression | identifier)
                               ~ opt(colon ~ nonEmptyTypeExpression ~ opt(matchingBlockTail)) }

  def matchingBlockTail = rule { lParen ~ rep1sep(matchBinding, comma)  ~ rParen }

  def typeDeclaration = rule { typeId ~ identifier ~ genericParams ~ equals ~ nonEmptyTypeExpression ~ (semicolon | whereClause)}

  //these are the things that work - 24 July with EELCO
  def typeExpression = rule { (opt(ws) ~ typeOpExpression ~ opt(ws)) | opt(ws) }
  def nonEmptyTypeExpression = rule { opt(ws) ~ typeOpExpression ~ opt(ws) }

  //these definitely don't - 24 July with EELCO
  // def typeExpression = rule { (opt(ws) ~ expression ~ opt(ws)) | opt(ws) }
  //def nonEmptyTypeExpression = rule { opt(ws) ~ expression ~ opt(ws) }

  def typeOp = rule { opsymbol("|") | opsymbol("&") | opsymbol("+") } 

  // def typeOpExpression = rule { rep1sep(basicTypeExpression, typeOp) }

  // this complex rule ensures two different typeOps have no precedence
  def typeOpExpression = rule {  
    var otherOperator 
    basicTypeExpression ~ opt(ws) ~
      opt( guard(typeOp, { s -> otherOperator:= s;
                                true })
            ~ rep1sep(basicTypeExpression ~ opt(ws),
               guard(typeOp, { s -> s == otherOperator })
          )
      )
    } 

  def basicTypeExpression = rule { nakedTypeLiteral | literal | pathTypeExpression | parenTypeExpression }  
     // if we keep this, note that in a typeExpression context { a; } is  interpreted as type { a; }
     // otherwise as the block { a; }

  def pathTypeExpression = rule { opt(listOfOuters ~ dot) ~ rep1sep((identifier ~ genericActuals),dot) }

  def parenTypeExpression = rule { lParen ~ typeExpression ~ rParen } 



  // statements

  def statement = rule { returnStatement | (expression ~ opt(assignmentTail))  } 
      // do we need constraints here on which expressions can have an assignmentTail
      // could try to rewrite as options including (expression ~ arrayAccess ~ assignmentTail)
      // expression ~ dot ~ identifier ~ assignmentTail 

  def returnStatement = rule { returnId ~ opt(expression) }  //doesn't need parens
  def assignmentTail = rule { assign ~ expression }

  // expressions

  def expression = rule { opExpression } 

  //def opExpression = rule { rep1sep(addExpression, otherOp)}

  // this complex rule ensures two different otherOps have no precedence
  def opExpression = rule { 
    var otherOperator 
    addExpression ~ opt(ws) ~
      opt( guard(otherOp, { s -> otherOperator:= s;
                                 true }) ~ rep1sep(addExpression ~ opt(ws),
             guard(otherOp, { s -> s == otherOperator })
          )
      )
    } 

  def addExpression = rule { rep1sep(multExpression, addOp) }
  def multExpression = rule { rep1sep(prefixExpression, multOp) }
  def prefixExpression = rule { (opt(otherOp) ~ selectorExpression) | (otherOp ~ listOfOuters) } 
        // we can have !outer or !outer.outer

  def selectorExpression = rule { primaryExpression ~ rep(selector) }

  def selector = rule { (dot ~ unaryRequest) | (dot ~ requestWithArgs) }

  def operatorChar = characterSetParser("!?@#$%^&|~=+-*/><:.") // had to be moved up

  //special symbol for operators: cannot be followed by another operatorChar
  method opsymbol(s : String) {trim(token(s) ~ not(operatorChar))}

  def multOp = opsymbol "*" | opsymbol "/" 
  def addOp = opsymbol "+" | opsymbol "-" 
  def otherOp = rule { guard(trim(rep1(operatorChar)), { s -> ! parse(s) with( reservedOp ~ end ) })} 
      // encompasses multOp and addOp
  def operator = rule { otherOp | reservedOp }  

  def unaryRequest = rule { trim(identifier) ~ genericActuals ~ not(delimitedArgument) } 
  def requestWithArgs = rule { firstRequestArgumentClause ~ repsep(requestArgumentClause,opt(ws)) }
  def firstRequestArgumentClause = rule { identifier ~ genericActuals ~ opt(ws) ~ delimitedArgument }
  def requestArgumentClause = rule { identifier ~ opt(ws) ~ delimitedArgument }
  def delimitedArgument = rule { argumentsInParens | blockLiteral | stringLiteral }
  def argumentsInParens = rule { lParen ~ rep1sep(drop(opt(ws)) ~ expression, comma) ~ rParen  }  

  def implicitSelfRequest = rule { requestWithArgs |  rep1sep(unaryRequest,dot) }

  def primaryExpression = rule { literal | listOfOuters | implicitSelfRequest | parenExpression }  

  def parenExpression = rule { lParen ~ rep1sep(drop(opt(ws)) ~ expression, semicolon) ~ rParen } 

  // def nonNakedSuper = rule { superId ~ not(not( operator | lBrack )) }
  def listOfOuters = rule { rep1sep(outerId, dot) }

  // "generics" 
  def genericActuals = rule { opt(lGeneric ~ opt(ws) ~ rep1sep(opt(ws) ~ typeExpression ~ opt(ws), opt(ws) ~ comma ~ opt(ws)) ~ opt(ws) ~ rGeneric) }

  def genericParams = rule {  opt(lGeneric ~ rep1sep(identifier, comma) ~ rGeneric) }

  def whereClause = rule { repdel(whereId ~ typePredicate, semicolon) }
  def typePredicate = rule { expression }

  //wherever genericParams appear, there should be a whereClause nearby.


  // "literals"

  def literal = rule { stringLiteral | selfLiteral | blockLiteral | numberLiteral | objectLiteral | lineupLiteral | typeLiteral } 

  def stringLiteral = rule { opt(ws) ~ doubleQuote ~ rep( stringChar ) ~ doubleQuote ~ opt(ws) } 
  def stringChar = rule { (drop(backslash) ~ escapeChar) | anyChar | space }
  def blockLiteral = rule { lBrace ~ opt(ws) ~ opt(genericParams ~ opt(matchBinding) ~ blockParams ~ opt(ws)~ arrow) ~ innerCodeSequence ~ rBrace }
  def selfLiteral = symbol "self" 
  def numberLiteral = trim(digitStringParser)
  def objectLiteral = rule { objectId ~ lBrace ~ rep(reuseClause) ~ codeSequence ~ rBrace } 

  //these are *not* in the spec - EELCO 
  def lineupLiteral = rule { lBrack ~ repsep( expression, comma ) ~ rBrack } 

  def typeLiteral = rule { typeId ~ opt(ws) ~ nakedTypeLiteral } 
  
  //kernan
  def nakedTypeLiteral = rule { lBrace ~ opt(ws) ~ repdel(methodHeader ~ methodReturnType, (semicolon | whereClause)) ~ opt(ws) ~ rBrace } 

  // terminals
  def backslash = token "\\"    // doesn't belong here, doesn't work if left below!
  def doubleQuote = token "\"" 
  def space = token " " 

  def semicolon = rule { (symbol(";") ~ opt(newLine)) | (opt(ws) ~ lineBreak("left" | "same") ~ opt(ws)) } 

  // broken
  // def semicolon = rule { (symbol(";") ~ opt(newLine)) | (opt(ws) ~ lineBreak("left" | "same") ~ opt(ws)) | end }

  def colon = rule {both(symbol ":", not(assign))} 
  def newLine = symbol "\n" 
  def lParen = symbol "(" 
  def rParen = symbol ")"  
  def lBrace = symbol "\{" 
  def rBrace = symbol "\}" 
  def lBrack = rule {both(symbol "[", not(lGeneric))} 
  def rBrack = rule {both(symbol "]", not(rGeneric))} 
  def arrow = symbol "->" 
  def dot = symbol "." 
  def assign = symbol ":=" 
  def equals = symbol "="

  def lGeneric = symbol "[["
  def rGeneric = symbol "]]"

  def comma = rule { symbol(",") }
  def escapeChar = characterSetParser("\\\"'\{\}bnrtlfe ")

  def azChars = "abcdefghijklmnopqrstuvwxyz"
  def AZChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  def otherChars = "1234567890~!@#$%^&*()_-+=[]|\\:;<,>.?/"

  def anyChar = characterSetParser(azChars ++ AZChars ++ otherChars)

  def identifierString = (graceIdentifierParser ~ drop(opt(ws)))

  // def identifier = rule { bothAll(trim(identifierString),not(reservedIdentifier))  }   
                             // bothAll ensures parses take the same length
  // def identifier = rule{ both(identifierString,not(reservedIdentifier))  }   
                            // both doesn't ensure parses take the same length
  def identifier = rule { guard(identifierString, { s -> ! parse(s) with( reservedIdentifier ~ end ) })}
                          // probably works but runs out of stack

  // anything in this list needs to be in reservedIdentifier below (or it won't do what you want)
  def aliasId = symbol "alias"
  def asId = symbol "as"
  def classId = symbol "class" 
  def defId = symbol "def" 
  def dialectId = symbol "dialect"
  def excludeId = symbol "exclude"
  def importId = symbol "import"
  def inheritId = symbol "inherit"
  def interfaceId = symbol "interface"
  def isId = symbol "is"
  def methodId = symbol "method" 
  def objectId = symbol "object" 
  def outerId = symbol "outer" 
  def prefixId = symbol "prefix" 
  def requiredId = symbol "required"
  def returnId = symbol "return"
  def traitId = symbol "trait" 
  def typeId = symbol "type" 
  def useId = symbol "use"
  def varId = symbol "var" 
  def whereId = symbol "where" 

  //kernan
  def reservedIdentifier = rule {selfLiteral | aliasId |  asId |  classId |  defId |  dialectId |  excludeId |  importId |  inheritId | isId |  methodId | objectId | outerId | prefixId |  requiredId |  returnId | traitId |  typeId |  useId |  varId |  whereId}

  //oops deleted interfaceId

  def reservedOp = rule {assign | equals | dot | arrow | colon | semicolon}  // this is not quite right

  //ENDGRAMMAR
}

