#!/usr/local/bin/perl
use strict;

my @guess_arr;

sub getrandom_word {
    my $arr = @_[0];
    my $sz = @_[1];
    
    my $val = int(rand($sz-1));
    return @$arr[$val];
}

sub prnt {
    my $wrd = $_[0];
    foreach my $char (split //, $wrd) {
        # print "_ ";
        print uc $char;
    }
}

sub check {
    my $wrd = $_[0];
    my $guess = $_[1];
    print (ord(uc $guess) - 65),"\n";
    # @guess_arr[] 
    foreach my $char (split //, $wrd) {
        if($char eq $guess) {
            return 1;
        }
    }
    return 0;
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
my $guess=='';

for(my $i = 0; $i < 25; $i++) {
    @guess_arr[$i] = 0;
}

print "Welcome player this is a Hangman Game.\n";
while($remain) {
    print "\nHere is your word : ";
    prnt($word);
    print "\nGuesses so far : \n";
    print "Make a Guess : ";
    $guess = <STDIN>;
    chop($guess);
    push(@guess_arr, $guess);
    # $hs{$guess} = 1;
    if(check($word, $guess)) {
        print "Present\n";
    }
    else {
        print "Not present\n";
        $remain--;
    }
    print "You have $remain body parts left\n";
}

