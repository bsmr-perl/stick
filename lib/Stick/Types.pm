package Stick::Types;
{
  $Stick::Types::VERSION = '0.302';
}
# ABSTRACT: type constraints for Stick

use MooseX::Types -declare => [ qw(
  StickBool
  Factory
  PositiveInt
) ];

use MooseX::Types::Moose qw(Bool Int Object Str);

use Stick::Entity::Bool;

subtype StickBool,
  as Object,
  where { $_->isa('Stick::Entity::Bool') };

coerce StickBool,
  from Bool,
  via { my $method = $_ ? 'true' : 'false'; Stick::Entity::Bool->$method };

subtype Factory, as Str | Object;

subtype PositiveInt, as Int, where { $_ > 0 };

1;

__END__
=pod

=head1 NAME

Stick::Types - type constraints for Stick

=head1 VERSION

version 0.302

=head1 AUTHOR

Ricardo Signes <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Ricardo Signes.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

