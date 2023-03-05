import "combinator" as c
import "unicode" as u
import "gUnit" as gU

type Parser = c.Parser
type InputStream = c.InputStream

////////////////////////////////////////////////////////////
// data
////////////////////////////////////////////////////////////

def ws = c.whiteSpaceParser
def end = c.atEndParser
def es = emptySequence


def strm   = c.stringInputStream ("Hello World",1)
def strm2  = c.stringInputStream ("   Hello World",1)
def strmus = c.stringInputStream ("_",1)
def strmab  = c.stringInputStream ("abc4de'a123",1)
def strmas  = c.stringInputStream ("a bcb", 1)
def strmnn  = c.stringInputStream ("1234  ",1)
def strmnx  = c.stringInputStream ("1234",1)
def strmxx  = c.stringInputStream ("xxxxx",1)
def strmxc  = c.stringInputStream ("xcxcxf",1)
def strmcx  = c.stringInputStream ("xcxcf",1)
def strmx  = c.stringInputStream ("xf",1)
def strmxcx  = c.stringInputStream ("xcxf",1)

def hello = c.symbol ("Hello")
def dsp   = c.digitStringParser
def ini   = c.identifierParser ~ ws ~ c.identifierParser
def alt   = c.alternativeParser (hello,dsp)
def alt2  = hello|dsp
def rpx   = c.repetitionParser(c.symbol "x", 0)
def rpx2  = (c.symbol "x").many
def rpx1  = (c.symbol "x").many1
def rs    = (c.symbol "x").manySepBy (c.symbol "c")
def r1s   = (c.symbol "x").many1SepBy (c.symbol "c")
def rd    = (c.symbol "x").manySepOrTermBy (c.symbol "c")

//////////////////////////////////////////////////
// tests!
//////////////////////////////////////////////////


class combinatorTest.forMethod(m) {
    inherits gU.testCaseNamed(m)
    
    method check (p:Parser) on (in:String) output (out:Sequence) position (n:Number) {
        def result = p.parse (c.stringInputStream (in,1))
        if  (result.succeeded) then {
            assert (result.outputIfFailed {}) shouldBe (out)
            assert (result.next.position) shouldBe (n)
        } else {
            failBecause (result.message)
        }
    }

    method fail (p:Parser) on (in:String) {
        def result = p.parse (c.stringInputStream (in,1))
        def output = result.outputIfFailed { assert (true) ; return }
        deny (result.succeeded) description "parser succeded with {output} when it should have failed"
    }


    method testStrm_take_5 {
        assert (strm.take 5) shouldBe "Hello"
    }
    method testStrm_rest_6_take_5 {
        assert (strm.rest 6.take 5) shouldBe "World"
    }
    method test_symbolOK {
        check (c.symbol "Hello") on "Hello World"
            output "Hello" position 6
    }
    method test_symbolFail {
        fail (c.symbol ("Hellx")) on "Hello"
    }
    method test_whiteSpaceParserFail {
        fail (ws) on "Hello World"
    }
    method test_whiteSpaceParserOK {
        check (ws) on "   Hello World" output " " position 4
    }
    method testIsLetter_A {
        assert (u.isLetter "A") shouldBe (true)
    }
    method testIsLetter_F {
        assert (u.isLetter "F") shouldBe (true)
    }
    method testIsLetter_Z {
        assert (u.isLetter "Z") shouldBe (true)
    }
    method testIsLetter_a {
        assert (u.isLetter "a") shouldBe (true)
    }
    method testIsLetter_f {
        assert (u.isLetter "f") shouldBe (true)
    }
    method testIsLetter_z {
        assert (u.isLetter "z") shouldBe (true)
    }
    method testIsLetter_dollar {
        assert (u.isLetter "$") shouldBe (false)
    }
    method testIsLetter_0 {
        assert (u.isLetter "0") shouldBe (false)
    }
    method testIsLetter_1 {
        assert (u.isLetter "1") shouldBe (false)
    }
    method testIsLetter_9 {
        assert (u.isLetter "9") shouldBe (false)
    }
    method testIsNumber_A {
        assert (u.isNumber "A") shouldBe (false)
    }
    method testIsNumber_F {
        assert (u.isNumber "F") shouldBe (false)
    }
    method testIsNumber_Z {
        assert (u.isNumber "Z") shouldBe (false)
    }
    method testIsNumber_a {
        assert (u.isNumber "a") shouldBe (false)
    }
    method testIsNumber_f {
        assert (u.isNumber "f") shouldBe (false)
    }
    method testIsNumber_z {
        assert (u.isNumber "z") shouldBe (false)
    }
    method testIsNumber_dollar {
        assert (u.isNumber "$") shouldBe (false)
    }
    method testIsNumber_0 {
        assert (u.isNumber "0") shouldBe (true)
    }
    method testIsNumber_1 {
        assert (u.isNumber "1") shouldBe (true)
    }
    method testIsNumber_9 {
        assert (u.isNumber "9") shouldBe (true)
    }
    method test_identifierParser_asString {
        assert (c.identifierParser.asString) shouldBe "an identifierParser"
    }
    method test_whiteSpaceParser_asString {
        assert (ws.asString) shouldBe "a whiteSpaceParser"
    }
    method test_identifierParser_eating_2 {
        assert (c.identifierParser.parse (strmus).next.position) shouldBe (2)
    }
    method test_identifierParser_us_OK {
        assert (c.identifierParser.parse (strmus).succeeded) shouldBe (true)
    }
    method test_id_wildcard {
        def o = "_"
        check (c.identifierParser) on (o) output(o) position (o.size+1)
    }
    method test_identifierParser_ab12  {
        check (c.identifierParser) on "abc4de'a123" 
            output "abc4de'a123" position 12
    }
    method test_strmab {
        def o = "abc4de'a123"
        check (c.identifierParser) on "abc4de'a123" output(o) position (o.size+1)
    }
    method test_identifierParser {
        check (c.identifierParser) on "a bcb" output "a" position 2
    }
    method test_many_ids {
        def o = "a bcb w "
        check (c.identifierParser.many)  on (o) output ["a"] position 2
    }
    method test_identifierParser_nn_eats_0 {
        assert (c.identifierParser.parse (strmnn).succeeded) shouldBe (false)
    }
    method test_digitStringParserSpaces {
        def o = "1234"
        check (c.digitStringParser) on "1234  " output(o) position (o.size+1)
    }
    method test_digitStringParser {
        def o = "1234"
        check (c.digitStringParser) on (o) output(o) position (o.size+1)
    }
    method test_strmnx {
        def o = "1234"
        check (c.digitStringParser) on (o) output(o) position (o.size+1)
    }
    method test_spaces_Hello {
        def o = "   Hello World"
        check (ws ~ hello) on (o) output [" ", "Hello"] position 9
    }
    method testSequenceFails {
        fail (ws ~ hello) on ("Hello World")
    }
    method test_sequentialParser_ws_hello_ab {
        fail (c.sequentialParser (ws, hello)) on "abc4de'a123"
    }
    method test_2_ids {
        def o = "a bcb"
        check (ini) on "a bcb" output ["a", " ", "bcb"] position (o.size+1)
    }
    method test_sequentialParser_ws_hello_Hello {
        def i = "   Hello World"
        check (c.sequentialParser (ws,hello)) on (i)
            output [" ", "Hello"] position 9
    }    
    method test_tilde_strm2 {
        def i = "   Hello World"
        check (ws ~ hello) on (i) output [" ", "Hello"] position 9
    }
    method test_hello_option {
        check (hello.option) on "abc4de'a123" output (es) position 1
    }
    method test_alt_hello {
        check (alt) on "Hello World" output "Hello" position 6
    }    
    method test_alt_nn {
        check (alt) on "1234  " output "1234" position 5
    }    
    method test_alt2_Hello {
        check (alt2) on "Hello World" output "Hello" position 6
    }    
    method test_alt2_nn {
        check (alt2) on "1234  " output "1234" position 5
    }
    method test_rpx_Hello {
        check (rpx) on "Hello World" output(es) position 1
    }    
    method test_rpx_xx {
        def o = "xx"
        check (rpx) on (o) output ["x", "x"] position (o.size+1)
    }    
    method test_xxxx {
        def i = "xxxx"
        def o = sequence ["x", "x", "x", "x"]
        check (rpx)  on (i) output(o) position (i.size+1)
    }
    method test_rpx2_Hello {
        check (rpx2) on "Hello World" output (es) position 1
    }    
    method test_rpx2_xxxx {
        check (rpx2) on "xxxx" output ["x", "x", "x", "x"] position 5
    }    
    method test_x_star_on_xxxxx {
        def o = "xxxxx"
        check (* c.symbol "x") on (o) 
            output ["x", "x", "x", "x", "x"] position (o.size+1)
    }   
    method test_x_star_on_empty {
        check (* c.symbol "x") on "" output(es) position (1)
    }
    method test_xxxxx_many1 {
        fail (rpx1) on "Hello World"
    } 
    method test_xxxxx_plus {
        fail (+ c.symbol "x") on "Hello World"
    }
    method test_rpx1_xx {
        def o = "xxxxx"
        check (rpx1) on (o) output ["x", "x", "x", "x", "x"] position (o.size+1)
    } 
    method test_rpx1_xx_on_empty {
        fail (rpx1) on ""
    }
    method test_xxxxxxxxxx {
        def i = "xxxxxxxxxx"
        var o := emptyList
        for (i) do { each -> o.addLast(each) }      // TODO: add map on strings!
        check (rpx1) on (i) output(o.asSequence) position (i.size+1)
    }
    method test_rpx1_atEnd_OK {
        assert (rpx1.parse (strmxx).next.atEnd)
            description "didn't consume the whole stream"
    }
    method test_hello_drop_strm {
        def o = "Hello World"
        check (hello.drop) on "Hello World" output "" position (6)
    }
    method test_drop_symbol_fail {
        fail (c.dropParser (c.symbol "Hellx")) on "Hello World"
    }
    method test_hello_trim {
        check (hello.trim) on "   Hello World" output "Hello" position 10
    }
    method test_rs_xc {
        check (rs) on "xcxcxf" output ["x", "c", "x", "c", "x"] position 6
    }
    method test_rs_dd {
        check (rs) on "1234  " output (es) position 1
    }
    method test_dsp {
        check (dsp) on "1234  " output "1234" position 5
    }
    method test_r1s_xf {
        check (r1s) on "xf" output ["x"] position 2
    }
    method test_r1s_xc {
        check (r1s) on "xcxcxf" output ["x", "c", "x", "c", "x"] position 6
    }
    method test_r1s_xcxf {
        check (r1s) on "xcxf" output ["x", "c", "x"] position 4
    }
    method test_r1s_nn {
        fail (r1s) on "1234  "
    }
    method test_rd_xc {
        check (rd) on "xcxcxf" output ["x", "c", "x", "c", "x"] position 6
    }
    method test_rd_nn {
        check (rd) on "1234  " output (es) position 1
    }
    method test_rd_cx {
        check (rd) on "xcxcf" output ["x", "c", "x", "c"] position 5
    }
    method test_rs_cx {
        check (rs) on "xcxcf" output ["x", "c", "x"] position 4
    }
    method test_rule_symbol_Hello {
        check (c.rule {c.symbol "Hello"}) on "Hello World" 
            output "Hello" position 6
    }
    method test_rule_symbol_Hellx {
        fail (c.rule {c.symbol "Hellx"}) on "Hello World"
    }
    method test_atEnd {
        check (c.atEndParser) on "" output (es) position 1
    }    
    method test_not_atEnd {
        fail (c.atEndParser) on "xxxxx"
    }    
    method test_CSP_OK {
        def o = "Helllo World "
        check (c.characterSetParser "Hello Wrd") on (o) output "H" position 2
    }   
    method test_CSP_star {
        def o = "Helllo World "
        check (*c.characterSetParser "HelloWrd") on (o)
            output ["H", "e", "l", "l", "l", "o"] position 7
    }
    method test_anyChar {
        def o = "abc4de'a123"
        check (c.anyCharParser)  on (o) output "a" position 2
    }
    method test_hello_not_negative {
        fail (hello.not) on "Hello"
    }
    method test_hello_not {
        check (hello.not)  on "Bood" output(es) position 1
    }
    method test_hello_not_not_Hello {
        check (hello.not.not) on "Hello" output(es) position 1
    }
    method test_both1 {
        fail (c.both (hello, dsp)) on "Hello"
    }
    method test_both2 {
        check (c.both (hello, hello)) on "Hello" output "Hello" position 6
    }
    method test_both3 {
        check (c.both (hello, dsp.not))  on "Hello" output "Hello" position 6
    }
    method test_empty1 {
        check (c.empty)  on "Hello" output(es) position 1
    }
    method test_empty2 {
        check (c.empty) on "12345" output(es) position 1
    }
    method test_empty3 {
        check (c.empty)  on "" output(es) position 1
    }
    method test_e_h {
        check (c.empty ~ hello)  on "Hello" output [es, "Hello"] position 6
    }
    method test_h_e {
        check (hello ~ c.empty)  on "Hello" output ["Hello", es] position 6
    }
    method test_h_or_e {
        check (hello | c.empty)  on "Hello" output "Hello" position 6
    }
    method test_e_or_h {
        check (c.empty | hello)  on "Hello" output(es) position 1
    }
    method test_h_or_e_ws {
        check (hello | c.empty)  on "  " output(es) position 1
    }
    method test_e_or_h_ws {
        check (c.empty | hello)  on "  " output(es) position 1
    }
    method test_guard_t {
        check (dsp.onlyIf {s -> true})  on "1234" output "1234" position 5
    }
    method test_guard_f {
        fail (dsp.onlyIf {s -> false}) on "1234"
    }
    method test_guard_1234 {
        check (dsp.onlyIf {s -> s == "1234"}) on "1234"
            output "1234" position 5
    }
    method test_guard_fun_fail {
        fail (dsp.onlyIf {s -> s == "wombat"}) on "1235"
    }
    method test_explode_0 {
        check (c.empty *=> { "ok" }) on "" output "ok" position 1
    }
    method test_explode_1 {
        check ((c.tag "a") *=> { a -> "ok{a}"}) on "" output "oka" position 1
    }
    method test_explode_2 {
        check ((c.tag "a" ~ c.tag "b") *=> { a, b -> 
            "ok{a}{b}"}) on "" output "okab" position 1
    }
    method test_explode_3 {
        check ((c.tag "a" ~ c.tag "b" ~ c.tag "c") *=> { a, b, c' ->
            "ok{a}{b}{c'}"}) on "" output "okabc" position 1
    }
    method test_explode_4 {
        check ((c.tag "a" ~ c.tag "b" ~ c.tag "c" ~ c.tag "d") *=> { a, b, c', d ->
            "ok{a}{b}{c'}{d}"}) on "" output "okabcd" position 1
    }
    method test_explode_5 {
        check ((* c.symbol "a") *=> { a, b, c', d, e ->
            "ok{a}{b}{c'}{d}{e}"}) on "aaaaa" output "okaaaaa" position 6
    }
    method test_explode_6 {
        check ((* c.characterSetParser "abcdefg") *=> { a, b, c', d, e, f ->
            "ok{a}{b}{c'}{d}{e}{f}"}) on "abcdef" output "okabcdef" position 7
    }
    method test_explode_7 {
        check ((* c.characterSetParser "abcdefg") *=> { a, b, c', d, e, f, g ->
            "ok{a}{b}{c'}{d}{e}{f}{g}"}) on "abcdefg" output "okabcdefg" position 8
    }
    method test_explode_8 {
        assert {((* c.symbol "a") *=> { a, b, c', d, e, f, g, h ->
            "ok{a}{b}{c'}{d}{e}"}).parse(c.StringInputStream("aaaaaaaa",1))} 
                shouldRaise (ProgrammingError)
    }
}

def combinatorTests = gU.testSuite.fromTestMethodsIn(combinatorTest)
combinatorTests.runAndPrintResults


