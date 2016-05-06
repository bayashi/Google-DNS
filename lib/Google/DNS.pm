package Google::DNS;
use strict;
use warnings;
use Carp qw/croak/;
use URI;
use Furl;
use JSON qw/decode_json/;
use Class::Accessor::Lite (
    rw => [qw/
        cd
        type
        endpoint
        ua
    /],
);

our $VERSION = '0.01';

sub new {
    my $class = shift;
    my %args  = @_;

    bless {
        cd       => ($args{cd} || $args{dnssec}) ? 1 : 0,
        type     => $args{type}     || '',
        endpoint => $args{endpoint} || 'https://dns.google.com/resolve',
        ua       => $args{ua}       || Furl->new,
    }, $class;
}

sub resolve {
    my ($self, $domain, $raw) = @_;

    croak "require domain" unless $domain;

    my $uri = URI->new($self->endpoint);
    $uri->query_form(name => $domain);
    if ($self->cd) {
        $uri->query_form(cd => $self->cd);
    }
    if ($self->type) {
        $uri->query_form(type => $self->type);
    }
    my $res = $self->ua->get($uri);
    croak "wrong response:". $res->status_line unless $res->is_success;
    my $json = $res->content;
    return $json if $raw;
    return decode_json($json);
}

sub data {
    my ($self, $domain, $delimi) = @_;

    unless (defined $delimi) {
        $delimi = "\n";
    }

    my $hash = $self->resolve($domain);

    return join($delimi, map { $_->{data} } @{$hash->{Answer}});
}

1;

__END__

=encoding UTF-8

=head1 NAME

Google::DNS - resolve domain name by Google Public DNS


=head1 SYNOPSIS

    use Google::DNS;

    my $resolver = Google::DNS->new;

    # all response
    my $hash = $resolver->resolve('google.com');

    # only data in Answer section
    my $data = $resolver->data('google.com');


=head1 DESCRIPTION

Google::DNS is the DNS resolver by Google Public DNS.

NOTE that Google says Public DNS Query UI is Beta, so this module is Beta also.


=head1 METHODS

=head2 new(%options)

=head2 resolve($domain)

=head2 data($domain)


=head1 CLI

see L<digoogle>


=head1 REPOSITORY

=begin html

<a href="http://travis-ci.org/bayashi/Google-DNS"><img src="https://secure.travis-ci.org/bayashi/Google-DNS.png"/></a> <a href="https://coveralls.io/r/bayashi/Google-DNS"><img src="https://coveralls.io/repos/bayashi/Google-DNS/badge.png?branch=master"/></a>

=end html

Google::DNS is hosted on github: L<http://github.com/bayashi/Google-DNS>

I appreciate any feedback :D


=head1 AUTHOR

Dai Okabayashi E<lt>bayashi@cpan.orgE<gt>


=head1 SEE ALSO

L<digoogle>


=head1 LICENSE

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.

=cut
