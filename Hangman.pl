#!/usr/local/bin/perl
use strict;

sub getrandom_word {
    my $arr = @_[0];
    my $sz = @_[1];
    
    my $val = int(rand($sz-1));
    return @$arr[$val];
}


my $filename = ($ARGV[0]);
open(my $fh, "<", $filename) 
    or die "Can't Open File : $filename";
my @data;
while(my $line = <$fh>) {
    push(@data, $line);
}

my $temp = join( "",@data);
$temp =~ s/[^\p{PosixAlnum}|]//g;
@data = split /[|]/, $temp;

close $fh or die "Couldn't Close File : $filename";

my $size = @data;
my $word = getrandom_word(\@data, $size);

my $remain = 6;
my $guess;
print "Welcome player this is a Hangman Game.\n";
while($remain) {
    print "\nHere is your word : ";
    foreach my $char (split //, $word) {
        print "_ ";
    }
    print "\nGuesses so far : \n";
    print "Make a Guess : ";
    $guess = <STDIN>;
    print "You have $remain body parts left\n";
}
