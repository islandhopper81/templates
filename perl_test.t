use strict;
use warnings;

use Test::More tests => 1;
use Test::Exception;
use Test::Warn;
use Log::Log4perl qw(:easy);
use Log::Log4perl::CommandLine qw(:all);
my $logger = get_logger();

# others to include
use File::Temp qw/ tempfile tempdir /;

# helper subroutines



### Begin Testing ###
BEGIN { use_ok( '<PACKAGE>' ); }

# test constructor
my $obj = undef;
{
    # test for errors with bad parameters
    throws_ok( sub { <PACKAGE>->new({}) },
              'MyX::Generic::Undef::Param', "new() - caught" );
    
    # test with correct parameters
    lives_ok( sub { $obj = BioUtils::FileReformat::GffToFas->new({
                                gff_file => $gff_filename,
                                genome_file => $genome_filename,
                                fas_file => $fas_filename,
                                save_feature => "CDS"}) },
             "expected to live" );
}

# Test the simple getter methods
{
    lives_ok( sub { $obj->get_gff_file() }, "expected to live" );
    is ($obj->get_gff_file(), $gff_filename, "get_gff_file()" );
}

# Test the simple setter methods
{
    throws_ok( sub { $obj->set_gff_file() },
              'MyX::Generic::Undef::Param', "set_gff_file() - caught" );
    throws_ok( sub { $obj->set_gff_file("blah.gff") },
              'MyX::Generic::DoesNotExist::File', "set_gff_file(blah.txt) - caught" );
    throws_ok( sub { $obj->set_gff_file($empty_filename) },
              'MyX::Generic::File::Empty', "set_gff_file(empty) - caught" );
    lives_ok( sub { $obj->set_gff_file($gff_filename) },
            "expected to live" );
    is( $obj->get_gff_file(), $gff_filename, "set_gff_file()" );
}

