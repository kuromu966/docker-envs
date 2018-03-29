#!/usr/bin/env perl

use strict;
use warnings;
use Getopt::Long qw(:config posix_default no_ignore_case gnu_compat);;
Getopt::Long::Configure("pass_through");
use Pod::Usage;

my $HELP = 0;
my $VERBOSE = 0;
my $SAMPLE = "";

GetOptions('help|h'	=> \$HELP,
	   'verbose|v'	=> \$VERBOSE,
	   'sample=s'	=> \$SAMPLE,
       ) or pod2usage(verbose => 1);
pod2usage(verbose => 1) if($HELP != 0);

unless($SAMPLE){
    pod2usage(verbose=>1);
    exit(1);
}

print $SAMPLE."\n";

exit 0;



__END__

=pod

=head1 NAME

 sample.pl -- sample command

=head1 SYNOPSIS

 test-local-stat.pl --sample

=cut



