#!/usr/bin/env perl
# ABSTRACT: Script to install DH for the first time (creates 'database' directory, etc)
# Very likely, this is NOT the script you are looking for.
use strict;
use warnings;
use feature qw/say/;

use DBIx::Class::DeploymentHandler;
use Getopt::Long;
use FindBin;
use lib "$FindBin::Bin/../../lib", "$FindBin::Bin/../../../lib";
use Quoting;

`echo "DROP DATABASE IF EXISTS quoting; CREATE DATABASE quoting DEFAULT CHARACTER SET utf8;" | mysql -u root`;

#my $force_overwrite = 0;
#unless ( GetOptions( 'force_overwrite!' => \$force_overwrite ) ) {
#    die "Invalid options";
#}

my $schema = Quoting->connect("DBI:mysql:mysql_read_default_file=$ENV{HOME}/.dbadmin.cnf;mysql_read_default_group=quoting", undef, undef);
my $dh = DBIx::Class::DeploymentHandler->new({
        schema              => $schema,
        script_directory    => "$FindBin::Bin/../../database",
        databases           => 'MySQL',
        sql_translator_args => { add_drop_table => 0 },
        force_overwrite     => 1,
});
$dh->prepare_install;

unlink 'lib/Quoting/Result/DbixClassDeploymenthandlerVersion.pm';

$dh->install;

`mysqldump -u root quoting > quoting-20151201.sql`
