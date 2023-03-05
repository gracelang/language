#pragma ExtendedLineups
import "unicode" as u

print "starting $Id: combinator.grace 2564 2016-05-10 21:24:26Z black $"

////////////////////////////////////////////////////////////
// input stream type 
////////////////////////////////////////////////////////////

type InputStream = {
    brand -> String
    position -> Number
    take (n:Number) -> String
    rest (n:Number) -> InputStream
    atEnd -> Boolean
}

////////////////////////////////////////////////////////////
// string input stream 
////////////////////////////////////////////////////////////

class stringInputStream (string:String, position':Number) {
    inherits abstractParser
    def brand = "stringInputStream"
    def position:Number is readable = position'

    // functional!
    method take (n:Number) -> String {
        // print "take {n} at {position}" // DEBUG

        var result := ""
        var endPosition := position + n - 1
        if (endPosition > string.size) then {endPosition := string.size}

        for (position..endPosition) do { i:Number ->
            result := result ++ string.at (i)
        }
        // print "take returning <{result}>"
        return result
    }

    method rest (n:Number)  {
        if ((n + position) <= (string.size + 1)) then {
            return stringInputStream (string, position+n)
        } else {
            return print ("FATAL ERROR END OF INPUT {position+n}")
        }
    }

    method atEnd  {return position > string.size}

}

////////////////////////////////////////////////////////////
// parse results 
////////////////////////////////////////////////////////////

type ParseResult = {
    brand -> String
    next -> InputStream
    output -> String
    succeeded -> Boolean
    outputIfFailed (b:Block1) -> Sequence
}

class parseSuccess (next', items:Sequence) {
    def brand = "parseSuccess"
    def next is readable = next'
    method succeeded { true }
    method output { items }
    method outputIfFailed (failBlock:Block1) { items }
}

class parseFailure (message') {
    def brand = "parseFailure"
    def message is public = message'
    method succeeded { false }
    method next { 
        NoSuchObject.raise "no next because parser failed {message}"
    }
    method output { 
        NoSuchObject.raise "no output because parser failed {message}" 
    }
    method outputIfFailed (failBlock:Block1) { failBlock.apply (self) }
}

 
////////////////////////////////////////////////////////////
// parsers 
////////////////////////////////////////////////////////////

type Parser = {
    parse (s:InputStream) -> ParseResult
    ~ (p:Parser) -> Parser
    | (p:Parser) -> Parser
    option -> Parser
    prefix ? -> Parser
    not -> Parser
    many -> Parser
    prefix * -> Parser
    many1 -> Parser
    prefix + -> Parser
    drop -> Parser
    trim -> Parser
    manySepBy (sep:Parser) -> Parser
    many1SepBy (sep:Parser) -> Parser
    manySepOrTermBy (sep:Parser) -> Parser
    onlyIf (b:Block) -> Parser
    => (a:Block1) -> Parser
}

class abstractParser {
    // the root of the inheritance hierarchy

    def brand = "abstractParser"
    method parse (in) { abstract }
    method asString { "{articleFor(brand)} {brand}" }
    method ~ (other) { sequentialParser (self, other) }
    method | (other) { alternativeParser (self, other) }
    method option { optionalParser (self) }
    method prefix ? { optionalParser (self) }
    method not { notParser(self) }
    method many { repetitionParser (self, 0) }
    method prefix * { repetitionParser (self, 0) }
    method many1 { repetitionParser (self, 1) }
    method prefix + { repetitionParser (self, 1) }
    method drop { dropParser (self) }
    method trim { (ws.option ~ self ~ ws.option) *=> { _, o, _ -> o } }
    method manySepBy (q:Parser) { self.many1SepBy(q).option }
    method many1SepBy (q:Parser) { 
        (self ~ (q ~ self).many) => { out ->
                sequence [out.first] ++ flattenSeq(out.second) }
    }
    method manySepOrTermBy (q:Parser)  { 
        (manySepBy(q) ~ q.option) *=> { seq, term -> seq ++ term }
    }
    method onlyIf (b:Block)  { guardParser (self, b) }
    method => (a:Block1) { andThen (self, a) }
    method *=> (a:Block1) { andThenStar (self, a) }
}

method articleFor(noun) is confidential {
    if ("aeio".contains(noun.at 1)) then { "an" } else { "a" }
}

method flattenSeq(xs) {
    // flattens a sequence of sequences into a sequence

    if (Sequence.match(xs)) then {
        xs.fold { accum, each -> accum ++ each } startingWith (emptySequence)
    } else {
        sequence [xs]
    }
}

method parse(s:String) with (p:Parser) {
    def in = stringInputStream(s, 1)
    p.parse(in).succeeded
}
method flattenStr(xs) {
    xs.fold { acc, each -> acc ++ each } startingWith ""
}


def es = emptySequence

class symbol (sym:String) {
    // parse just a symbol - basically a string, matching exactly

    inherits abstractParser
    def brand = "symbolParser"
    method parse (in) {
        def size = sym.size
        if (in.take (size) == sym) then {
            return parseSuccess (in.rest (size), sym)
        } else {
            return parseFailure
                "expected ‹{sym}›, got ‹{in.take (size)}› at {in.position}"
        }
    }
}

class whiteSpaceParser {
    // parse at least one space

    inherits abstractParser
    def brand = "whiteSpaceParser"
    method parse (in) {
        var remainder := in
        while {remainder.take 1 == " "}
            do {remainder := remainder.rest 1}
        if (remainder != in) then {
            return parseSuccess (remainder, " ")
        } else {
            return parseFailure
                "expected whitespace, got ‹{in.take 5}…› at {in.position}"
        }
    }
}

class anyCharParser {
    // parses one character.  Always succeeds unless at end of input
    
    inherits abstractParser
    def brand = "anyCharParser"
    method parse (in) {
        if (in.atEnd) then { 
            return parseFailure "expected anyChar at end of input"
        }
        def current = in.take 1
        parseSuccess (in.rest 1, current)
    }
}

class characterSetParser (charSet:String) {
    // parses a single character from charSet, the
    // set of acceptable characters, given as a string
    
    inherits abstractParser
    def brand = "characterSetParser"
    method parse (in) {
        def current = in.take 1
        for (charSet) do { c ->
            if (c == current) then {
                return parseSuccess (in.rest 1, current)
            }
        }
        parseFailure "expected one of \"{charSet}\", got ‹{current}› at {in.position}"
    }
}

method isIdentifierStart (ch) is confidential {
    if ( u.isLetter (ch) ) then { true } 
        elseif { ch == "_" } then { true }
        else { false }
}

method isIdentifierContinuation (ch) is confidential {
    if ( u.isLetter (ch) ) then { true } 
        elseif { u.isNumber (ch) } then { true }
        elseif { ch == "_" } then { true }
        elseif { ch == "'" } then { true }
        else { false }
}

class identifierParser {
    // does *not* eat whitespace!

    inherits abstractParser
    def brand = "identifierParser"
    method parse (in) {
        var char := in.take 1
        if (! isIdentifierStart (char)) then {
            return parseFailure
                "expected identifier, got ‹{in.take 5}…› at {in.position}"
        }
        var remainder := in.rest 1
        var id := char
        while {
            char := remainder.take 1
            isIdentifierContinuation (char)
        } do {
            id := id ++ char
            remainder := remainder.rest 1
        }
        parseSuccess (remainder, id)
    }
}

class digitStringParser {
    inherits abstractParser
    def brand = "digitStringParser"
    method parse (in) {
        var remainder := in
        var char := remainder.take 1
        var digits := ""

        if (char == "-") then {
            digits := "-"
            remainder := in.rest 1
            char := remainder.take 1     
        }

        if (! u.isNumber (char)) then {
            return parseFailure
                 "expected DigitString, got ‹{in.take 5}…› at {in.position}"
        }
        while { u.isNumber (char) } do {
             digits := digits ++ char
             remainder := remainder.rest 1
             char := remainder.take 1
        }
        parseSuccess (remainder, digits)
    }
}
method sequentialParser (*p:Parser) {
    sequentialParserFromAll(p)
}

class sequentialParserFromAll(ps:Enumerable<Parser>) {
    inherits abstractParser
    def brand = "sequentialParser"
    method parse (in:InputStream) {
        def output = emptyList
        var subResult
        var remainder := in
        for (ps) do { each ->
            subResult := each.parse (remainder)
            output.addLast (subResult.outputIfFailed { f -> return f } )
            remainder := subResult.next
        }
        parseSuccess (subResult.next, output.asSequence)
    }
    method ~ (p:Parser) {
        def pList = ps.asList.addLast(p)
        sequentialParserFromAll(pList)
    }
}

class optionalParser (subParser) {
    inherits abstractParser
    def brand = "optionalParser"
    method parse (in) {
        def subResult = subParser.parse (in)
        def subOutput = subResult.outputIfFailed {f ->
                    return parseSuccess (in, es)}
        subResult
        // TODO: consider whether the non-empty output should also
        // be a (unit) sequence, or the output should be a maybe
    }
}

class dropParser (subParser) {
    // parse as if subParser, but discard the result
    inherits abstractParser
    def brand = "dropParser"
    method parse (in) {
        def subResult = subParser.parse (in)
        if (subResult.succeeded) then {
            parseSuccess (subResult.next, "")
        } else {
            subResult
        }
    }
}


class alternativeParser ( left, right) { 
    inherits abstractParser
    def brand = "alternativeParser"
    method parse (in) {
         def leftResult = left.parse (in)
         if (leftResult.succeeded) then { return leftResult }
         return right.parse (in)
    }
}

class bothParser (left, right) {
    // succeeds if both left & right succeed; returns LEFT parse
    // e.g. both (operator, not (asterisk))

    inherits abstractParser
    def brand = "bothParser"
    method parse (in) {
         def leftResult = left.parse (in)
         if (!leftResult.succeeded) then {return leftResult}
         def rightResult = right.parse (in)
         if (!rightResult.succeeded) then {return rightResult}
         return leftResult
    }
}


class repetitionParser (subParser, minOccurences) {
    // zero or more repetitions of subParser.  Always succeeds.

    inherits abstractParser
    def brand = "repetitionParser"
    method parse (in) {
        var remainder := in
        var out := emptyList
        var occurences := 0
        while { true } do {
            def res = subParser.parse (remainder)
            out.addLast(res.outputIfFailed { _ ->
                if (occurences >= minOccurences) then {
                    return parseSuccess (remainder, out.asSequence)
                } else {
                    return parseFailure ("expecting {minOccurences} or more " ++
                        "repetitions, found ‹{remainder.take 5}› at {remainder.position}")
                }
            })
            occurences := occurences + 1
            remainder := res.next
        }
        ProgrammingError.raise "impossible happened"
    }
}


class rule (proxyBlock) {
    // lazy initialization of a parser

    inherits abstractParser
    def brand = "ruleParser"
    var subParser := "no parser installed"
    var needToInitialiseSubParser := true

    method parse (in) {
        if (needToInitialiseSubParser) then {
            subParser := proxyBlock.apply
            needToInitialiseSubParser := false
        }
        subParser.parse (in)
     }
}

class atEndParser {
    // does nothing, succeeds only at end of input

    inherits abstractParser
    def brand = "atEndParser"
    method parse (in) {
        if (in.atEnd) then {
            parseSuccess (in, es)
        } else {
            parseFailure "expected end, got ‹{in.take 5}…› at {in.position}"
        }
    }
}

class notParser (subParser) {
    // succeeds when subparser fails; never consumes input
    inherits abstractParser
    def brand = "notParser"
    method parse (in) {
        def result = subParser.parse (in)
        if (result.succeeded) then { 
            parseFailure ("notParser: {subParser} succeeded so I failed")
        } else {
            parseSuccess (in, es)
        }
    }
}

class guardParser (subParser, guardBlock) {
    inherits abstractParser
    def brand = "guardParser"
    method parse (in) {
        def result = subParser.parse (in)
        if (guardBlock.apply (result.outputIfFailed{f -> return f})) then {
            return result
        } else {
            parseFailure "Guard failure at {in.position}"
        }
    }
}

class successParser {
    // does nothing, always succeeds

    inherits abstractParser
    def brand = "successParser"
    method parse (in) { parseSuccess (in, es) }
}

class failParser {
    // does nothing, always fails

    inherits abstractParser
    def brand = "failParser"
    method parse (in) { 
        parseFailure "failParser failed at {in.position}"
    }
}

class constantParser (tagx:Object) {
    // puts tag into output; always succeeds

    inherits abstractParser
    def brand = "constantParser"
    method parse (in) { return parseSuccess (in, tagx) }
}

class andThen (subParser:Parser, function: Block1) {
    // applies function to the output of subParser

    inherits abstractParser
    def brand = "andThenParser"
    method parse (in) {
        def result = subParser.parse (in)
        def output = result.outputIfFailed { f -> return f }
        parseSuccess (result.next, function.apply(output))
    }
}

class andThenStar (subParser:Parser, function: Block1) {
    // applies function to the exploded output of subParser

    inherits abstractParser
    def brand = "andThenStarParser"
    method parse (in) {
        def result = subParser.parse (in)
        def out = result.outputIfFailed { f -> return f }
        def n = out.size
        // TODO: we need apply* !
        def newOutput =
            if (n > 3) then {
                if (n > 5) then {
                    if (n == 6) then {
                        function.apply(out[1], out[2], out[3], out[4], out[5], out[6])
                    } elseif {n == 7} then {
                        function.apply(out[1], out[2], out[3], out[4], out[5], out[6], out[7])
                    } else {
                        ProgrammingError.raise "too many inputs for *=>" 
                    }
                } else {
                    if (n == 4) then {
                        function.apply(out[1], out[2], out[3], out[4])
                    } else {
                        function.apply(out[1], out[2], out[3], out[4], out[5])
                    }
                }
            } else {    // n <= 3
                if (n > 1) then {
                    if (n == 2) then {
                        function.apply(out[1], out[2])
                    } else {
                        function.apply(out[1], out[2], out[3])
                    }
                } else {
                    if (n == 0) then {
                        function.apply
                    } else {
                        function.apply(out[1])
                    }
                }
            }
        parseSuccess (result.next, newOutput)
    }
}

class phraseParser (tagx:String, subParser) {
    // puts tagx around start and end of sub-parse

    inherits abstractParser
    def brand = "phraseParser"
    method parse (in) {
        def result = subParser.parse (in)
        def output = result.outputIfFailed { f -> return f }
        parseSuccess (result.next, "<{tagx} {output} {tagx}>")
    }
}


////////////////////////////////////////////////////////////
// "support library methods"
////////////////////////////////////////////////////////////

method assert (assertion:Block) complaint (failureDescription:String) {
    if (!assertion.apply) then { print (failureDescription) }
}

////////////////////////////////////////////////////////////
// combinator functions - many of these should be methods
// on parser but I got sick of copying everything!
////////////////////////////////////////////////////////////


def ws = whiteSpaceParser

method token (s:String) { symbol (s).trim }

def end = atEndParser
method both (p:Parser, q:Parser)  {bothParser (p,q)}
method empty  {successParser}
method tag (s:String) {constantParser (s)}
method phrase (s:String, p:Parser) { phraseParser (s, p) }

print "Done $Id: combinator.grace 2564 2016-05-10 21:24:26Z black $"

          
