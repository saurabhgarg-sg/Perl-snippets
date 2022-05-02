#!/usr/bin/perl
use GD::Graph::linespoints;

use strict;
use warnings;

my @data = (
    [ "1st", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "9th" ],
    [ 1,     2,     5,     6,     3,     1.5,   1,     3,     4 ],
);

#============= main =====================#
my $graph = GD::Graph::linespoints->new( 800, 600 );
$graph->set_text_clr("black");

$graph->set(
    x_label       => 'Time --->',
    y_label       => '    Memory Usage   ',
    title         => 'Memory Usage Graph',
    transparent   => 0,
    y_min_value   => 0,
    y_max_value   => 8,
    x_min_value   => 0,
    x_max_value   => 8,
    y_tick_number => 8,
    y_label_skip  => 2,
    markers       => [5],
    marker_size   => 3,
    show_values   => 1,
    dclrs         => [qw/ dblue dgreen blue /],
    box_axis      => 0,
    zero_axis     => 1
) or die $graph->error;

my $gd = $graph->plot( \@data ) or die $graph->error;

open( IMG, '>file.png' ) or die $!;
binmode IMG;
print IMG $gd->png;
close IMG;

#============= main ends =====================#
