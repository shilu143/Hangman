#!/usr/local/bin/perl

use strict;
use warnings;

my @alpha_hash = ();
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
    my ($word) = @_;

    foreach my $x (split //, $word) {
        my $tp = (ord(uc $x) - 65);
        if($alpha_hash[$tp] == 0) {
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

    print "   _______\n";
    print "  |       |\n";
    for(my $i = 0; $i < 5; $i++) {
        my $str;
        $str = (($cnt >= 1 && $i == 0)?              "  |       O\n":"  |\n");
        $str = (($cnt >= 2 && ($i == 1 || $i == 2))? "  |       |     \n": $str);
        $str = (($cnt >= 3 && ($i == 1))?             "  |      \\|   \n": $str);
        $str = (($cnt >= 4 && ($i == 1))?             "  |      \\|\/ \n": $str);
        $str = (($cnt >= 5 && ($i == 3))?             "  |      \/    \n": $str);
        $str = (($cnt >= 6 && ($i == 3))?             "  |      \/ \\ \n": $str);
        print $str;
    }
    print "__|__\n\n\n";
}


sub int_main {
    # print gen_random_word(), "\n";

    for(my $i = 0; $i < 26; $i++) {
        $alpha_hash[$i] = 0;
    }
    my $word = gen_random_word();
    print "Welcome player, this is a Hangman Game\n";
    print "Here is your word : ";
    Print_word($word);
    for ( my $i = 1; $i <= 6; $i++) {
        body($i);
    }
}




int_main();
