#!/usr/bin/perl
use Text::Wrap qw($columns &wrap);
$columns = 500;

#read a grammar 
$grammar="graceGrammar.txt";

$/ = "\r";

$rule = "NORULE";

$wrapped = wrap("", "    ", "$1 ::= $3\n");

unless (open (G, "<$grammar")) {
        die "Couldn't read $grammar\n"; }


while (<G>) {
    if (/^\s*(\w+)\s*::=\s*(.*)/) {
	$rule = $1;
	$body = $2;
	$rules{$rule} = "$rule ::= $body\n";
    } else {
	die "Can'r continue rule $rule" if ($rule eq "NORULE");
	$rules{$rule} .= "$_\n";
    }
}

close G;

$/ = "\n";

while (<>) {
    if (/^RULE\s+(\w+)/) {
	$rule = $1;
	die "No such rule $1\n" unless defined $rules{$rule};
	print wrap("","          ",$rules{$rule});
    } elsif (/^GRAMMAR/) {
	foreach $k (sort keys %rules) {
	    print wrap("","          ",$rules{$k});
	    print "\n";
	}
    } else {
	print;
    }
}
