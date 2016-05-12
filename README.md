# The CAPSiDE DB Flow:

## New project:

Create the database in MySQL (tables, fks, etc)

0. `dbflow_refresh_model ` 

`
dbflow_refresh_model
`

Modify the model to include:

`
our $VERSION = 1;

sub admin_connection {
  my $schema = __PACKAGE__->connect(
    "DBI:mysql:mysql_read_default_file=pathtoadmincreds.cnf;mysql_read_default_group=schema_group",
    undef,
    undef,
    {
      AutoCommit => 1,
      RaiseError => 1,
      mysql_enable_utf8 => 1,
      quote_char => '``',
      name_sep   => '.',
    },
  );
}
`

`dbflow_create --schema MySchema`

installs dhhandler tables, creates database dir, etc

## Once installed (ongoing project)

Before modifying the database, bump up it's version

Modify the database (columns, tables, indexes, etc)

1. `dbflow_refresh_model --schema X`

Execute `dbflow_refresh_model` all the times you like until
you have the model you like

2. `dbflow_make_upgrade_scripts --schema`

Create upgrade scripts for your schema:

the SQL for the last version to your version is created
automatically by comparing the schemas. You can do automated
work in:

in `database/_common/upgrade/3-4/01-upgrade_step.pl`

`
sub {
  my $model = shift;

  my $things = $model->resultset('Things')->search({ ... });
}
`

3. `db_upgrade --schema`

Test your schema update: `make obliviatedb`, and `db_upgrade --schema`

# Interesting utils:

Generate an image with the database schema

