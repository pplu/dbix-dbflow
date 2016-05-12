#!/usr/bin/env perl

use strict;
use warnings;
use feature qw/say/;

use DBIx::Class::DeploymentHandler;

package UpgradeDBFlow::Args {
  use Moose;
  with 'MooseX::Getopt';
  use Module::Runtime qw/require_module/;

  has schema => (is => 'ro', isa => 'Str', required => 1, documentation => 'The name of the schema class to load. Must be a DBIx::Class');

  has _schema => (
    is => 'ro',
    lazy => 1,
    default => sub {
      my $self = shift;
      my $schema_name = $self->schema;
      require_module $schema_name;
      my $schema = $schema_name->admin_connection;
      return $schema;
    }
  );

  has dir => (
    is => 'ro',
    isa => 'Str',
    default => 'database',
    documentation => 'The directory to create support files in',
  );
}

my $opts = UpgradeDBFlow->new_with_options;

my $dh = DBIx::Class::DeploymentHandler->new({
   schema              => $opts->_schema,
   script_directory    => $opts->dir,
   databases           => 'MySQL',
   sql_translator_args => { add_drop_table => 0 },
});

$dh->upgrade;
