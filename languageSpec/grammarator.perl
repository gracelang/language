#!/usr/bin/perl
use Text::Wrap qw($columns &wrap);
$columns = 79;

#read a grammar 
$grammar="grammar.grace";

unless (open (G, "<$grammar")) {
        die "Couldn't read $grammar\n"; }
while (<G>) {
    next unless /^\s*def\s*(\w+)\s*=\s*(rule)\s*{\s*(.*)\s*}\s*$/;
    $wrapped = wrap("", "    ", "$1 ::= $3\n");
    #print ($wrapped);
    $rules{$1} = $wrapped;
}

close G;

while (<>) {
    if (/^RULE\s+(\w+)/) {
	print "$rules{$1}";
    } elsif (/^GRAMMAR/) {
	foreach $k (sort keys %rules) {
	    print "$rules{$k}";
	}
    } else {
	print;
    }
}
