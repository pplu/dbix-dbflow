# this cpanfile has the requisites for the developer-mode package
# the runtime package has requisites declared in dist.ini-runtime
requires 'MooseX::Getopt';
requires 'DBIx::Class::DeploymentHandler';
requires 'GraphViz';
requires 'DBIx::Class::Schema::Loader';

on develop => sub {
  requires 'DBD::mysql';
  requires 'Carp::Always';
};
