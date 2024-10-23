package Mojolicious::Plugin::Listen;
use Mojo::Base 'Mojolicious::Plugin', -signatures;

use Mojo::Util qw(getopt);
sub register ($self, $app, $conf) {
  $app->hook(before_server_start => sub ($server, $app) {
    return if $ENV{MOJO_LISTEN};
    getopt \@ARGV, ['pass_through'],
      'l|listen=s' => \my $listen;
    return if $listen;
    $listen = $app->config->{listen};
    $server->listen($listen) if $listen;
  });
}

1;