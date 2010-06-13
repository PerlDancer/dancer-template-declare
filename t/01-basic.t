use strict;
use warnings;
use Test::More import => ['!pass'];

package mytemplate;
use Template::Declare::Tags;
use base 'Template::Declare';

template hello => sub {
    my ($self, $vars) = @_;
    html {
        head {
            title {"Hello, $vars->{user}"};
        };
        body {
            h1 {"Hello, $vars->{user}"};
        };
    };
};

package main;

use Dancer::Template::Declare;

ok my $td =
  Dancer::Template::Declare->new(config => {dispatch_to => [qw/mytemplate/]}),
  'D::T::Declare object created';

ok my $result = $td->render('hello', {user => 'marc'}), 'render is ok';
like $result, qr/<title>Hello, marc<\/title>/, 'content match';

done_testing;
