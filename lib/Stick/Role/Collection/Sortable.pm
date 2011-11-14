
package Stick::Role::Collection::Sortable;
{
  $Stick::Role::Collection::Sortable::VERSION = '0.308';
}
use Carp qw(confess croak);
use MooseX::Role::Parameterized;
use MooseX::Types::Moose qw(Str);

# Method that is used to sort the collection (alphabetically)
parameter sort_attr => (
  is => 'ro',
  isa => Str,                   # actually should be a method name
  default => 'guid',
);

require Stick::Publisher;
use Stick::Publisher::Publish;

role {
  my ($p, %args) = @_;

  Stick::Publisher->import({ into => $args{operating_on}->name });
  sub publish;

  my $sort_attr    = $p->sort_attr;

  has sort_key => (
    is => 'rw',

    # I would like to use method_name_for here, to warn early if the
    # method name is invalid, but that doesn't work in roles (see
    # tinker/method-name-for). MJD 20110523
    isa => Str,
    default => $sort_attr,
   );

  publish first => { -path => 'first' } => sub {
    my ($self) = @_;
    my ($first) = $self->all_sorted;
    return $first;
  };

  publish last => { -path => 'last' } => sub {
    my ($self) = @_;
    my ($last) = reverse $self->all_sorted;
    return $last;
  };

  publish items_sorted => { } => sub {
    my ($self) = @_;
    return [ $self->all_sorted ];
  };

  publish all_sorted => { } => sub {
    my ($self) = @_;
    my $collection_name = $self->collection_name;
    my $meth = $self->sort_key
      or confess "No sort key defined for collection '$collection_name' (self=$self)";
    my @all = $self->all;
    return () unless @all;
    $all[0]->can($meth)
      or croak "Objects ($all[0]) in collection '$collection_name' don't support a '$meth' sort key";
    return sort { $a->$meth cmp $b->$meth } @all;
  };
};

1;


__END__
=pod

=head1 NAME

Stick::Role::Collection::Sortable

=head1 VERSION

version 0.308

=head1 AUTHORS

=over 4

=item *

Ricardo Signes <rjbs@cpan.org>

=item *

Mark Jason Dominus <mjd@cpan.org>

=back

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Ricardo Signes, Mark Jason Dominus.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

