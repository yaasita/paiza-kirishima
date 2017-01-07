#!/usr/bin/perl
# vim: fdm=marker
use strict;
use warnings;
use feature qw(say);
use Test::More;

my ($PEOPLES,$COMPANY_NUM,@COMPANIES);

subtest 'pattern_plus1' => sub { #{{{
    $COMPANY_NUM=5;
    my @one = &pattern_plus1(1);
    #diag explain @one;
    is_deeply $one[0],[1,2];
    is_deeply $one[1],[1,3];
    is_deeply $one[2],[1,4];
    is_deeply $one[3],[1,5];
    ok(!defined $one[4]);
    my @two = &pattern_plus1(1,3);
    #diag explain @two;
    is_deeply $two[0], [1,3,4];
    is_deeply $two[1], [1,3,5];
}; #}}}
subtest 'pattern_search' => sub { #{{{
    $COMPANY_NUM=5;
    my @p = &pattern_search(2);
    is_deeply $p[0],[1,2];
    is_deeply $p[1],[1,3];
    is_deeply $p[2],[1,4];
    is_deeply $p[3],[1,5];
    is_deeply $p[4],[2,3];
    is_deeply $p[5],[2,4];
    is_deeply $p[6],[2,5];
    is @p+0,10;
    $COMPANY_NUM = 10;
    is &pattern_search(3)+0,10*9*8/1/2/3;
    $COMPANY_NUM = 50;
    is &pattern_search(2)+0,50*49/1/2;
    is &pattern_search(3)+0,50*49*48/1/2/3;
    is &pattern_search(4)+0,50*49*48*47/1/2/3/4;
}; #}}}
subtest 'cost_sum' => sub { #{{{
    @COMPANIES = (
          [ 35, 3640 ]
        , [ 33, 2706 ]
        , [ 98, 9810 ]
        , [ 57, 5472 ]
        , [ 95, 7790 ]
    );
    $COMPANY_NUM=@COMPANIES;
    $PEOPLES = 10;
    is cost_sum([1,2]),6346;
    is cost_sum([1,2,4]),11818;
    is cost_sum([1,2,3]),16156;
    is cost_sum([1,5]),11430;
    is cost_sum([5,1]),11430;
    is cost_sum([1,2,3,4,5]),29418;
    $PEOPLES = 100;
    is cost_sum([1,2]),undef;
    is cost_sum([1,5]),11430;
    is cost_sum([3]),undef;
}; #}}}
subtest 'min_cost ex1' => sub { #{{{
    @COMPANIES = (
          [ 40, 4300 ]
        , [ 30, 2300 ]
        , [ 20, 2400 ]
    );
    $PEOPLES = 60;
    $COMPANY_NUM=@COMPANIES;
    is min_cost(1),-1;
    is min_cost(2),6600;
    is min_cost(3),9000;
}; #}}}
subtest 'min_cost ex2' => sub { #{{{
    @COMPANIES = (
          [ 35, 3640 ]
        , [ 33, 2706 ]
        , [ 98, 9810 ]
        , [ 57, 5472 ]
        , [ 95, 7790 ]
    );
    $PEOPLES = 250;
    $COMPANY_NUM=@COMPANIES;
    is min_cost(1),-1;
    is min_cost(2),-1;
    is min_cost(3),23072;
    is min_cost(3),23072;
}; #}}}
subtest 'min_cost other' => sub { #{{{
    @COMPANIES = (
          [ 10, 100 ]
        , [ 20, 200 ]
        , [ 30, 300 ]
        , [ 40, 400 ]
    );
    $PEOPLES = 100;
    $COMPANY_NUM=@COMPANIES;
    is min_cost(1),-1;
    is min_cost(2),-1;
    is min_cost(3),-1;
    is min_cost(4),1000;
}; #}}}
done_testing;

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
