#!/usr/bin/perl
use strict;
use warnings;
use feature qw(say);
use Data::Dumper;


# データ入力
my $PEOPLES = <DATA>;
my $COMPANY_NUM = <DATA>;
chomp ($PEOPLES,$COMPANY_NUM);
my @COMPANIES;
while (<DATA>){
    chomp;
    my ($n,$c) = split(/\s/);
    my $e = int $c / $n;
    push(@COMPANIES,[$n,$c,$e]);
}

{ 
    my $sum_people = 0;
    my $sum_cost = 0;
    for (sort {$b->[2] <=> $a->[2]} @COMPANIES){
        
        $sum_people += $_->[0];
        $sum_cost += $_->[1];
        last if $sum_people >= $PEOPLES;
        say $_->[0]," ",$_->[1]," ",$_->[2];
    }
    say "";
    say $sum_cost;
}

#print Dumper $COMPANIES[0]->[0];

exit


__DATA__
250
5
35 3640
33 2706
98 9810
57 5472
95 7790 
