#!/usr/bin/perl
use Text::Wrap qw($columns &wrap);
$columns = 90;

#read a grammar 
$grammar="graceGrammar.txt";

unless (open (G, "tr \\\\r \\\\n <$grammar |")) {
        die "Couldn't read $grammar\n"; }

while (<>) {
    if (/^GRAMMAR/) {
	while (<G>) {
	    chomp;
	    print wrap("","          ","$_\n");
	}
     } else {
	print;
    }
}
