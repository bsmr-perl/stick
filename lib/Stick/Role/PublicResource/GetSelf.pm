package Stick::Role::PublicResource::GetSelf;
{
  $Stick::Role::PublicResource::GetSelf::VERSION = '0.302';
}
use Moose::Role;

use Stick::Error;

with(
  'Stick::Role::PublicResource',
);

use namespace::autoclean;

sub resource_get { return $_[0] }

1;

__END__
=pod

=head1 NAME

Stick::Role::PublicResource::GetSelf

=head1 VERSION

version 0.302

=head1 AUTHOR

Ricardo Signes <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Ricardo Signes.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

