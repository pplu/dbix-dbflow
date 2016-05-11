#!/usr/bin/env perl
# ABSTRACT: After applying modifications to the ENZiME schema, this script generates
# the upgrade scripts (in 'database' directory) & adds a row to 'dbix_class_deploymenthandler_versions'
use strict;
use warnings;
use DBIx::Class::DeploymentHandler;
use FindBin;
use lib "$FindBin::Bin/../../lib", "$FindBin::Bin/../../../lib";
use Quoting;



my $schema = Quoting->connect("DBI:mysql:mysql_read_default_file=$ENV{HOME}/.dbadmin.cnf;mysql_read_default_group=quoting", undef, undef);
my $dh = DBIx::Class::DeploymentHandler->new({ 
     schema              => $schema,
     script_directory    => "$FindBin::Bin/../../database",
     databases           => 'MySQL',
     sql_translator_args => { add_drop_table => 0 },
});

my $sth = $schema->storage->dbh->prepare(
        'SELECT version 
         FROM dbix_class_deploymenthandler_versions 
         WHERE id IN (SELECT MAX(id) 
                      FROM dbix_class_deploymenthandler_versions
                     )');
$sth->execute;
#my $version = $sth->fetchrow_hashref->{version} or 0;
my $version = 0;
$sth->finish;

if ($version >= $Quoting::VERSION) {
   die "Can't downgrade a DB. DB Version: $version ENZiME Schema Version: $Quoting::VERSION\n";
}

$dh->prepare_deploy;
$dh->prepare_upgrade;
$dh->add_database_version({ version => $ENZiMEDB::VERSION });

