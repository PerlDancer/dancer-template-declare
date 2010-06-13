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

=head1 SYNOPSIS

    package myapp::templates;
    use Template::Declare::Tags;
    use base 'Template::Declare';

    template hello => sub {
        my ($self, $vars) = @_;
        html {
            head {
                title {"Hello, $vars->{user}"};
            };
            body {
                h1 {
                    "Hello, $vars->{user}";
                };
            };
        };
    };

    package myapp;
    use myapp::templates;
    use Dancer ':syntax';

    get '/' => sub {
        template 'hello', {user => 'marc'};
    };

    true;

    # in your configuration:
    template: declare
    engines:
      declare:
        dispatch_to:
          - myapp::template

