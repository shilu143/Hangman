#!/usr/local/bin/perl

use strict;
use warnings;

my @guess_arr;
my @word_data;
my $size;
my $word;
my $remain = 6;
my $guess;
my @alpha_hash;
my $isgameover = 0;

# FILE INPUT FOR WORD
my $filename = ($ARGV[0]);
open(my $fh, "<", $filename) 
    or die "Can't Open File : $filename";
while(my $line = <$fh>) {
    push(@word_data, $line);
}

my $temp = join("", @word_data);
$temp =~ s/[^\p{PosixAlnum}|]//g;
@word_data = split /[|]/, $temp;

close $fh or die "Couldn't Close File : $filename";
# FILE INPUT FOR WORD

for(my $i = 0; $i < 26; $i++) {
    $alpha_hash[$i] = 0;           # initializing all values of hash to 0  
}

sub body { 
    (my $cnt) = $_[0];
    if ($cnt==0)
   { print "This is the setup, guess the correct letters:)\n";
    print " ____\n|    |\n|\n|\n|\n __\n";
   }
   elsif($cnt==1)
   {
       print "__\n|    |\n|    O\n|\n|\n__\n";
   }
    elsif($cnt==2)
   {
       print "__\n|    |\n|    O\n|    |\n|    |\n|\n__\n";
   }
    elsif($cnt==3)
   {
       print "__\n|    |\n|    O\n|   \\|\n|    |\n|\n__\n";
   }
    elsif($cnt==4)
   {
       print "__\n|    |\n|    O\n|   \\|\/\n|    |\n|\n__\n";
   }
    elsif($cnt==5)
   {
       print "__\n|    |\n|    O\n|   \\|\/\n|    \/|\n__\n";
   }
    elsif($cnt==6)
   {
       print "__\n|    |\n|    O\n|   \\|\/\n|    |\n|   \/|\\\n__\n";
   }
}


sub getrandom_word {
    my $val = int(rand($size-1));
    return @word_data[$val];
}

sub display {
    foreach my $char (split //, $word) {
        if(@alpha_hash[ord(uc $char)-65] == 0)  { 
            print "_ ";
        }
        else {
            print uc $char," ";
        }
    }
}

sub check {
    # my $wrd = $_[0];
    # my $guess = $_[1];
    # print (ord(uc $guess) - 65),"\n";
    # @guess_arr[] 
    foreach my $a (@guess_arr) {
        if((uc $guess) eq (uc $a)) {
            print "Please change your guess you have used it once\n";
            return;
        }
    }
    push(@guess_arr, $guess);

    if( (length($guess) != length($word)) && length($guess)!= 1) {
        print "Bad guess ! ";
        $remain--;
        return;
    }
    if( (length($guess) == length($word))) {
        if($guess eq $word) {
            print "Congratulation you won \n";
            $isgameover = 1;
            return;
        }
        # print "Bad guess ! ";
        # $remain--;
        # return;
    }
    @alpha_hash[ord(uc $guess)-65] = 1;
    foreach my $char (split //, $word) {
        if((uc $char) eq (uc $guess)) {
            print "Good guess ! ";
            return;
        }
    }
    print "Bad guess ! ";
    $remain--;
}

$size = @word_data;
$word = getrandom_word();
$guess;

print "Welcome player this is a Hangman Game.\n";
# print $word;


while($remain && !$isgameover) {
    body(6 - $remain);
    print "\nHere is your word : ";
    display();
    print "\nGuesses so far : ";
    print join(', ', @guess_arr), "\n";
    print "Make a Guess : ";
    $guess = <STDIN>;
    chop($guess);
    check();
    print "You have $remain body parts left\n";
}

