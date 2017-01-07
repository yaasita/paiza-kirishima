#!/usr/bin/perl
use strict;
use warnings;
use feature qw(say);

# データ入力
my $PEOPLES = <DATA>;
my $COMPANY_NUM = <DATA>;
chomp ($PEOPLES,$COMPANY_NUM);
my @COMPANIES;
while (<DATA>){
    chomp;
    my ($n,$c) = split(/\s/);
    push(@COMPANIES,[$n,$c]);
}

{
    my $answer;
    for (1..$COMPANY_NUM){
        $answer = min_cost($_);
        last if $answer != -1;
    }
    say $answer;
}

sub min_cost {
    my $c = shift;
    my $m = 0 ^ -1;
    for (&pattern_search($c)){
        next unless my $sum = &cost_sum($_);
        $m = $sum if $m > $sum;
    }
    if ($m == (0 ^ -1)){
        return -1;
    }
    return $m;
}
sub cost_sum {
    my $cost = 0;
    my $pepo = 0;
    for (@{$_[0]}){
        $cost += $COMPANIES[$_-1]->[1];
        $pepo += $COMPANIES[$_-1]->[0];
    }
    if ($pepo < $PEOPLES){
        return;
    }
    return $cost;
}
sub pattern_search {
    my $seach = shift;
    my @ret;
    if ($seach == 1){
        push(@ret,[$_]) for 1..$COMPANY_NUM;
    }
    elsif ($seach == 2){
        push(@ret,&pattern_plus1($_)) for 1..$COMPANY_NUM;
    }
    else {
        push(@ret,&pattern_plus1(@$_)) for &pattern_search($seach-1);
    }
    return @ret;
}
sub pattern_plus1 {
    my $base = 0;
    $base < $_ and $base = $_ for @_;
    my @ret;
    for ($base+1..$COMPANY_NUM){
        push(@ret,[@_,$_]);
    }
    return @ret;
}

__DATA__
250
5
35 3640
33 2706
98 9810
57 5472
95 7790 
