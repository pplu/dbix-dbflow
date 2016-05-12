requires 'MooseX::Getopt';
requires 'DBIx::Class::DeploymentHandler';
requires 'GraphViz';
requires 'DBIx::Class::Schema::Loader';

on develop => sub {
  requires 'DBD::mysql';
  requires 'Carp::Always';

  requires 'Dist::Zilla';
  requires 'Dist::Zilla::Plugin::Prereqs::FromCPANfile';
  requires 'Dist::Zilla::Plugin::VersionFromModule';
  requires 'Dist::Zilla::PluginBundle::Git';
};
