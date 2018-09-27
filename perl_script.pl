#!/usr/bin/env perl

# [DESCRIPTION]

use strict;
use warnings;

use Getopt::Long;
use Pod::Usage;
use Carp;
use Readonly;
use version; our $VERSION = qv('0.0.1');
use Log::Log4perl qw(:easy);
use Log::Log4perl::CommandLine qw(:all);
use UtilSY qw(:all);

# Subroutines #
sub check_params;

# Variables #
my ($var, $file, $help, $man);

my $options_okay = GetOptions (
    "var|v:s" => \$var,
    "file|f:s" => \$file,
    "help|h" => \$help,                  # flag
    "man" => \$man,                     # flag (print full man page)
);

# set up the logging environment
my $logger = get_logger();

# check for input errors
if ( $help ) { pod2usage(-verbose => 0) }
if ( $man ) { pod2usage(-verbose => 3) }
check_params();


########
# MAIN #
########



########
# Subs #
########
sub check_params {
	# check required files
	_check_rqrd_file_param($file, $name);

	# check required input directories
	_check_rqrd_dir_param($dir, $name);

	# check other params that are not files or dirs
	_check_rqrd_param($val, $name);

	return 1;
}

sub _check_rqrd_param {
	my ($val, $name) = @_;

	if ( ! defined $val ) {
		pod2usage(-message => "ERROR: required --$name not defined\n\n",
					-exitval => 2);
	}

	return 1;
}

sub _check_rqrd_file_param {
	my ($file, $name) = @_;
	
	# make sure the file is defined on the command line
	_check_rqrd_param($file, $name);

	# make sure the file is not empty
	if ( ! -e $file ) {
		pod2usage(-message => "ERROR: --$name $file is an empty file\n\n",
					-exitval => 2);
	}

	return 1;
}

sub _check_rqrd_dir_param {
	my ($dir, $name) = @_;

	_check_rqrd_param($file, $name);
	
	if ( ! -d $dir ) { 
		pod2usage(-message => "ERROR: --$name $dir is not a directory\n\n",
					-exitval => 2); 
	}

	return 1;
}


__END__

# POD

=head1 NAME

[NAME].pl - [DESCRIPTION]


=head1 VERSION

This documentation refers to version 0.0.1


=head1 SYNOPSIS

    [NAME].pl
        -f my_file.txt
        -v 10
        
        [--help]
        [--man]
        [--debug]
        [--verbose]
        [--quiet]
        [--logfile logfile.log]

    --file | -f     Path to an input file
    --var | -v      Path to an input variable
    --help | -h     Prints USAGE statement
    --man           Prints the man page
    --debug	        Prints Log4perl DEBUG+ messages
    --verbose       Prints Log4perl INFO+ messages
    --quiet	        Suppress printing ERROR+ Log4perl messages
    --logfile       File to save Log4perl messages


=head1 ARGUMENTS
    
=head2 --file | -f

Path to an input file
    
=head2 --var | -v

Path to an input variable   
 
=head2 [--help | -h]
    
An optional parameter to print a usage statement.

=head2 [--man]

An optional parameter to print he entire man page (i.e. all documentation)

=head2 [--debug]

Prints Log4perl DEBUG+ messages.  The plus here means it prints DEBUG
level and greater messages.

=head2 [--verbose]

Prints Log4perl INFO+ messages.  The plus here means it prints INFO level
and greater messages.

=head2 [--quiet]

Suppresses print ERROR+ Log4perl messages.  The plus here means it suppresses
ERROR level and greater messages that are automatically printed.

=head2 [--logfile]

File to save Log4perl messages.  Note that messages will also be printed to
STDERR.
    

=head1 DESCRIPTION

[FULL DESCRIPTION]

=head1 CONFIGURATION AND ENVIRONMENT
    
No special configurations or environment variables needed
    
    
=head1 DEPENDANCIES

version
Getopt::Long
Pod::Usage
Carp
Readonly
version
Log::Log4perl qw(:easy)
Log::Log4perl::CommandLine qw(:all)
UtilSY qw(:all)

=head1 AUTHOR

Scott Yourstone     scott.yourstone@q2labsolutions.com
    
=cut
