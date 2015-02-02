#! usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

use Triangle;

my $tri = Triangle->new(3,4,5);

my $space = $tri->space;
	
print "sides are ",join(",",$tri->getSides),"\n";
print $space."\n";

$tri->setSides(4,5,3);
print join(",",$tri->getSides)."\n";