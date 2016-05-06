#!/usr/bin/env perl
# ABSTRACT: Given an environment with a ENZiME DB and its related schema classes,
# this script upgrades the schema of the DB to match the version of DBIx schema classes
# with DBIx::Class::DeploymentHandler upgrade scripts
use strict;
use warnings;
use feature qw/say/;

use DBIx::Class::DeploymentHandler;
use FindBin;
use lib "$FindBin::Bin/../../lib", "$FindBin::Bin/../../../lib";
use ENZiMEDB;


my $schema = ENZiMEDB->connect("DBI:mysql:mysql_read_default_file=$ENV{HOME}/.dbadmin.cnf;mysql_read_default_group=enzime", undef, undef);
my $dh = DBIx::Class::DeploymentHandler->new({
   schema              => $schema,
   script_directory    => "$FindBin::Bin/../../database",
   databases           => 'MySQL',
   sql_translator_args => { add_drop_table => 0 },
});
 
$dh->upgrade;
