#!/usr/bin/perl
use GD::Graph::linespoints;

#==============================================================#
#            Perl program to read a file and plot graph        #
#							       #
# file expected to have fields & values seperated by delimiter #
#         Crossed / merged graphs plotting not supported       #
#                                                              #
# WARNING: no checks on the file correctness performed         #
#                                                              #
#==============================================================#
use strict;
use warnings;

#============= main =====================#
my $x_axis = [];
my $y1     = [];

if ( ( scalar(@ARGV) < 2 ) || ( scalar(@ARGV) > 3 ) ) {
    print
qq# \n\nUsage: perl grafs.pl <input file> <output file> <optional delimiter> \n\t delimiter is optional, default is space \n\n#;
}
else {
    open( INPUT, qq/ $ARGV[0] / ) or die qq/ Cannot open the input file, \n $!/;
    open( OUTPUT, qq/> $ARGV[1] / )
      or die qq/ Cannot open the output file, \n $!/;

    my $index = 0;

    my $index = 0;

    while (<INPUT>) {

        #print "reading: " . $_;
        #$$x_axis[$index]=$index;
        ( $$x_axis[$index], $$y1[$index] ) = (split)[ 3, 6 ];
        $index++;
    }

    #for(my $i=0;$i<$index;$i++){
    #print "\nvalue is: $$y1[$i]";
    #}

}
plotter( $x_axis, $y1 );

#============= main ends =====================#

sub plotter {
    my ( $ref1, $ref2 ) = @_;
    my @data = ( $ref1, $ref2 );

    my $graph = GD::Graph::linespoints->new( 800, 600 );
    $graph->set_text_clr("black");

    $graph->set(
        x_label       => 'Time --->',
        y_label       => '    Memory Usage   ',
        title         => 'Memory Usage Graph',
        transparent   => 0,
        x_ticks       => 0,
        x_tick_offset => 0,

        #    y_min_value   => 0,
        #    y_max_value   => 8,
        #    x_min_value   => 1,
        #    x_max_value   => 8,
        markers     => [5],
        marker_size => 3,

        # line_width => 2,
        y_tick_number => 'auto',

        #        x_tick_number => 'auto',
        x_label_skip => 100,
        dclrs        => [qw/ dblue dgreen blue /],
        box_axis     => 0,

        #zero_axis     => 0
    ) or die $graph->error;

    my $gd = $graph->plot( \@data ) or die $graph->error;

    open( IMG, '>file.png' ) or die $!;
    binmode IMG;
    print IMG $gd->png;
    close IMG;
}
