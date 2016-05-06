package Google::DNS;
use strict;
use warnings;
use Carp qw/croak/;

our $VERSION = '0.01';

sub new {
    my $class = shift;
    my $args  = shift || +{};

    bless $args, $class;
}

1;

__END__

=encoding UTF-8

=head1 NAME

Google::DNS - one line description


=head1 SYNOPSIS

    use Google::DNS;


=head1 DESCRIPTION

Google::DNS is


=head1 REPOSITORY

=begin html

<a href="http://travis-ci.org/bayashi/Google-DNS"><img src="https://secure.travis-ci.org/bayashi/Google-DNS.png"/></a> <a href="https://coveralls.io/r/bayashi/Google-DNS"><img src="https://coveralls.io/repos/bayashi/Google-DNS/badge.png?branch=master"/></a>

=end html

Google::DNS is hosted on github: L<http://github.com/bayashi/Google-DNS>

I appreciate any feedback :D


=head1 AUTHOR

Dai Okabayashi E<lt>bayashi@cpan.orgE<gt>


=head1 SEE ALSO

L<Other::Module>


=head1 LICENSE

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.

=cut
