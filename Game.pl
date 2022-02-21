#!/usr/local/bin/perl

use strict;
use warnings;

my @alpha_hash = ();
my $isgameover;

my @word_data = (
    "computer", "radio", "calculator", "teacher", "bureau", "police", "geometry", "president", "subject", "country", 
    "enviroment", "classroom", "animals", "province", "month", "politics", "puzzle", "instrument", "kitchen", "language", 
    "vampire", "ghost", "solution", "service", "software", "virus25", "security", "phonenumber", "expert", "website", 
    "agreement", "support", "compatibility", "advanced", "search", "triathlon", "immediately", "encyclopedia", "endurance", 
    "distance", "nature", "history", "organization", "international", "championship", "government", "popularity", 
    "thousand", "feature", "wetsuit", "fitness", "legendary", "variation", "equal", "approximately", "segment", 
    "priority", "physics", "branche", "science", "mathematics", "lightning", "dispersion", "accelerator", "detector", 
    "terminology", "design", "operation", "foundation", "application", "prediction", "reference", "measurement", 
    "concept", "perspective", "overview", "position", "airplane", "symmetry", "dimension", "toxic", "algebra", "illustration", 
    "classic", "verification", "citation", "unusual", "resource", "analysis", "license", "comedy", "screenplay", 
    "production", "release", "emphasis", "director", "trademark", "vehicle", "aircraft", "experiment"
);

sub gen_random_word {
    my $size = @word_data;
    my $idx = int(rand($size - 1));
    return $word_data[$idx];
}

sub Print_word {
    my ($word, $showall) = @_;

    foreach my $x (split //, $word) {
        my $tp = (ord(uc $x) - 65);
        if($alpha_hash[$tp] == 0 && !$showall) {
            print "_ ";
        }
        else {
            print uc $x, " ";
        }
    }
    print "\n";
}

sub body {
    my ($cnt) = @_;

    print "\t   _______\n";
    print "\t  |       |\n";
    for(my $i = 0; $i < 5; $i++) {
        my $str;
        $str = (($cnt >= 1 && $i == 0)?              "\t  |       O\n":"\t  |\n");
        $str = (($cnt >= 2 && ($i == 1 || $i == 2))? "\t  |       |     \n": $str);
        $str = (($cnt >= 3 && ($i == 1))?             "\t  |      \\|   \n": $str);
        $str = (($cnt >= 4 && ($i == 1))?             "\t  |      \\|\/ \n": $str);
        $str = (($cnt >= 5 && ($i == 3))?             "\t  |      \/    \n": $str);
        $str = (($cnt >= 6 && ($i == 3))?             "\t  |      \/ \\ \n": $str);
        print $str;
    }
    print "\t__|__\n\n";
}

sub isalready_guessed {
    my ($guess_arr, $guess) = @_;

    # if(length($guess) == 0) {
    #     return 1;
    # }
    if ($guess !~ /^[a-zA-Z]+$/){
        print "Guesses only containing alphabets are acceptable\n";
        return 1;
    }

    foreach my $x (@$guess_arr) {
        if((uc $x) eq (uc $guess)) {
            print "Sorry you already guessed $guess\n";
            return 1;
        }
    }
    return 0;
}

sub update {
    my ($guess, $word, $done) = @_;

    if($guess eq $word) {
        $$done = 0;
        return;
    }
    if(length($guess) > 1) {
        return;
    }
    my $idx = (ord(uc $guess) - 65);
    my $i = 0;
    $alpha_hash[$idx] = 1;

    foreach my $x (split //, $word) {
        my $tp = (ord(uc $x) - 65);
        if($alpha_hash[$tp] == 1) {
            $i++;
        }
    }
    $$done = length($word) - $i; 
}

sub check {
    my ($guess, $word, $lft_parts, $done) = @_;

    my $i = 0;
    foreach my $x (split //, $word) {
        if( $guess eq $x) {
            $i++;
        }
    }
    print "**********************************************\n\n";
    if($done == 0) {
        print "Congratulations!!, you won the game.\n";
        body(6 - $$lft_parts);
        print "Here is the word : ";
        Print_word($word, 1);
        $isgameover = 1;
        return;
    }
    if($i == 0) {
        ($$lft_parts)--;
        if($$lft_parts == 0) {
            print "Gameover!!, you lose the game.\n";
            body(6 - $$lft_parts);
            print "The word was : ";
            Print_word($word, 1);
            $isgameover = 1;
            return;
        }
        print "Bad guess!!, you are left with ($$lft_parts) body parts\n";
    }
    else {
        print "Good guess!!, you are left with ($$lft_parts) body parts\n";
    }
}

sub Game_start {
    my ($word) = @_;

    my $lft_parts = 6;
    my ($guess, @guess_arr, $done);
    $done = length($word); 
    # my @guess_arr;
    # my $done;

    while ($lft_parts && !$isgameover) {
        body(6 - $lft_parts);
        print "Here is the word : ";
        Print_word($word, 0);
        print "\nGuesses so far : ";
        print join(', ', @guess_arr), "\n";
        print "Make a guess : ";
        $guess = <STDIN>;
        chomp($guess);
        while(isalready_guessed(\@guess_arr, $guess)) {
            print "\nMake a guess : ";
            $guess = <STDIN>;
            chomp($guess);
        }
        push(@guess_arr, $guess);
        update($guess, $word, \$done);
        check($guess, $word, \$lft_parts, $done);
    }
}

sub int_main {
    $isgameover = 0;
    
    for(my $i = 0; $i < 26; $i++) {
        $alpha_hash[$i] = 0;
    }
    my $word = gen_random_word();
    print $word, "\n";
    print "Welcome player, this is a Hangman Game\n";
    Game_start($word);
}

my $choice;
while(1) {
    print "**********************************************\n\n";
    int_main();
    print "**********************************************\n\n";
    print "Do you play again(Y/N) : ";
    $choice = <STDIN>;
    chomp($choice);
    while(($choice ne "N") && ($choice ne "n") && ($choice ne "Y") && ($choice ne "y")) {
        print "Please enter a valid choice!!\n";
        print "Do you play again(Y/N) : ";
        $choice = <STDIN>;
        chomp($choice);
    }
    if($choice eq "N" || $choice eq "n") {
        last;
    }
}