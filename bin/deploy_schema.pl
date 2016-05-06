#!/usr/bin/env perl
# ABSTRACT: Given a devel environment, this script deploys the ENZiME db schema
# in an empty db with the help of DBIx::Class::DeploymentHandler
use strict;
use warnings;
use feature qw/say/;

use DBIx::Class::DeploymentHandler;
use Getopt::Long;
use FindBin;
use lib "$FindBin::Bin/../../lib", "$FindBin::Bin/../../../lib";
use Quoting;


my $force_overwrite = 0;
unless ( GetOptions( 'force_overwrite!' => \$force_overwrite ) ) {
    die "Invalid options";
}

my $schema = Quoting->connect("DBI:mysql:mysql_read_default_file=$ENV{HOME}/.dbadmin.cnf;mysql_read_default_group=quoting", undef, undef);

my $dh = DBIx::Class::DeploymentHandler->new({
        schema              => $schema,
        script_directory    => "$FindBin::Bin/../../database",
        databases           => 'MySQL',
        sql_translator_args => { add_drop_table => 0 },
        force_overwrite     => $force_overwrite,
});
$dh->deploy;
