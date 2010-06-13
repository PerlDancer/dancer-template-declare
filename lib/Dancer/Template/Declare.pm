package Dancer::Template::Declare;

use strict;
use warnings;

use base 'Dancer::Template::Abstract';
use Template::Declare;

my $_init;

sub init {
    my $self = shift;
    $_init = $self->{config};
}

sub view { return $_[1] }
sub layout { return $_[3] }

sub render {
    my ($self, $template, $token) = @_;
    Template::Declare->init( %{ $_init } );
    Template::Declare->show($template, $token);
}

1;
