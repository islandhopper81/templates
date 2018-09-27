#!/usr/bin/env perl

#package [PACKAGE_NAME];

__PACKAGE__->run() unless caller();

# [ADD DESCRIPTION]

use strict;
use warnings;

use Getopt::Long;
use Pod::Usage;
use Carp;
use Readonly;
use version; our $VERSION = qv('0.0.1');
use Log::Log4perl qw(:easy);
use Log::Log4perl::CommandLine qw(:all);
use MyX::Generic;

# Subroutines #
sub run;
sub check_params;

# Variables #
my ($arg1, $arg2, $help, $man);

# set up the logging environment
my $logger = get_logger();

# Usage statement
Readonly my $NEW_USAGE => q{ new( {
    arg1 => ,
    arg2 => ,
})};


########
# MAIN #
########
sub run {
    # throw an error if this subroutine is called from an object.  This
    # subroutine should only be used when running as a script from the
    # command line.
    if ( caller() ) {
        $logger->fatal("Cannot call subroutine \"run\" from using an object");
    }
    
    my $options_okay = GetOptions (
        "arg1:s" => \$arg1,
        "arg2:s" => \$arg2,
        "help" => \$help,                  # flag
        "man" => \$man,                     # flag (print full man page)
    );
    
    # check for input errors
    if ( $help ) { pod2usage(2) }
    if ( $man ) { pod2usage(-verbose => 3) }
    check_params();
}


###############
# CONSTRUCTOR #
###############
sub new {
    my ($class, $arg_href) = @_; 

    # Croak if calling new on already blessed reference
    croak 'Constructor called on existing object instead of class'
        if ref $class;

    # Make sure the required parameters are defined
    if ( any {!defined $_}
            $arg_href->{arg1},
            $arg_href->{arg2}
        ) { 
        MyX::Generic::Undef::Params->throw(
            error => 'Undefined parameter value',
            usage => $NEW_USAGE,
        );  
    }   

    # Bless a scalar to instantiate an object
    my $new_obj = bless \do{my $anon_scalar}, $class;

    # Attributes

    return $new_obj;
}


###########
# Setters #
###########


###########
# Getters #
###########



########
# Subs #
########
sub check_params {
	# check for required variables
	if ( ! defined $file) { 
		pod2usage(-message => "ERROR: required --file not defined\n\n",
					-exitval => 2); 
	}
	if ( ! defined $var ) {
		pod2usage(-message => "ERROR: required --var not defined\n\n",
					-exitval => 2);
	}

	# make sure required files are non-empty
	if ( defined $file and ! -e $file ) { 
		pod2usage(-message => "ERROR: --file $file is an empty file\n\n",
					-exitval => 2);
	}

	# make sure required directories exist
	# if ( ! -d $dir ) { 
	#	pod2usage(-message => "ERROR: --dir is not a directory\n\n",
	#				-exitval => 2); 
	#}
	
	return 1;
}


__END__

# POD

=head1 NAME

[NAME].pl - [DESCRIPTION]


=head1 VERSION

This documentation refers to version 0.0.1


=head1 SYNOPSIS

    [NAME].pm
        --file my_file.txt
        --var 10
        
        [--help]
        [--man]
        [--debug]
        [--verbose]
        [--quiet]
        [--logfile logfile.log]

    --file  = Path to an input file
    --var   = Path to an input variable
    --help  = Prints USAGE statement
    --man   = Prints the man page
    --debug	= Prints Log4perl DEBUG+ messages
    --verbose	= Prints Log4perl INFO+ messages
    --quiet	= Suppress printing ERROR+ Log4perl messages
    --logfile	= File to save Log4perl messages


=head1 ARGUMENTS
    
=head2 --file

Path to an input file
    
=head2 --var

Path to an input variable   
 
=head2 [--help]
    
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
MyX::Generic


=head1 METHODS

=over

=for author to fill in:
    A list of method names in the module
    
    new

=back


=head1 METHODS DESCRIPTION

=head2 new

    Title: new
    Usage:
    Function:
    Returns:
    Args:
    Throws:
    Comments:
    See Also:


=head1 BUGS AND LIMITATIONS

=for author to fill in:
    A list of known problems with the module, together with some
    indication Whether they are likely to be fixed in an upcoming
    release. Also a list of restrictions on the features the module
    does provide: data types that cannot be handled, performance issues
    and the circumstances in which they may arise, practical
    limitations on the size of data sets, special cases that are not
    (yet) handled, etc.

No bugs have been reported.


=head1 AUTHOR

Scott Yourstone     scott.yourstone81@gmail.com
    
    
=head1 LICENCE AND COPYRIGHT

Copyright (c) 2015, Scott Yourstone
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met: 

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer. 
2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution. 

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

The views and conclusions contained in the software and documentation are those
of the authors and should not be interpreted as representing official policies, 
either expressed or implied, of the FreeBSD Project.


=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.


=cut
