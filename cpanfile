requires 'MooseX::Getopt';
requires 'DBIx::Class::DeploymentHandler';
requires 'GraphViz';
requires 'DBIx::Class::Schema::Loader';

on develop => sub {
  requires 'DBD::mysql';
  requires 'Carp::Always';
};
