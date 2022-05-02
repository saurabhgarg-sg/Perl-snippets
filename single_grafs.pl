#!/usr/bin/perl
use GD::Graph::linespoints;

use strict;
use warnings;

#============= main =====================#
my $x_axis = [];
my $y1     = [];

my $index = 0;

if ( scalar(@ARGV) != 1 ) {
    print qq# \n\nUsage: perl grafs.pl <input file>\n#;
}
else {
    open( INPUT, qq/ $ARGV[0] / ) or die qq/ Cannot open the input file, \n $!/;

    while (<INPUT>) {
        $$x_axis[$index] = $index;
        $$y1[$index]     = (split)[6];
        $index++;
    }
}

$index--;

plotter( $x_axis, $y1, $index, "Memory Usage" );

#============= main ends =====================#

sub plotter {
    my ( $ref1, $ref2, $size, $type ) = @_;
    my @data    = ( $ref1, $ref2 );
    my @legends = $type;
    my $graph   = GD::Graph::lines->new( 841, 491 );
    $graph->set_text_clr("black");
    $graph->set_legend(@legends);

    $graph->set(
        x_label          => 'Time --->',
        y_label          => $type,
        title            => $type . " Graph",
        transparent      => 0,
        x_ticks          => 0,
        x_min_value      => 'auto',
        x_max_value      => $size,
        line_width       => 2,
        y_tick_number    => 'auto',
        x_tick_number    => $size,
        x_label_skip     => $size,
        dclrs            => [qw/ dblue /],
        box_axis         => 0,
        legend_placement => 'RC'

    ) or die $graph->error;

    my $gd = $graph->plot( \@data ) or die $graph->error;

    open( IMG, '>file.png' ) or die $!;
    binmode IMG;
    print IMG $gd->png;
    close IMG;
}
