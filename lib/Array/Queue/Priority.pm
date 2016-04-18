package Array::Queue::Priority;

use Moose;

extends 'Array::Queue';

use namespace::autoclean;


=head1 NAME

Array::Queue::Priority - An custom sorted queue

=head1 SYNOPSIS

    my $queue = Array::Queue::Priority->new( limit => 12 );
    $ar->add( 20 );
    $ar->add( 18 );
    $ar->add( 22 );

=cut


sub push {
    my ($self, $node) = @_;

    if ($self->size == 0) {
        $self->_insert(0, $node);
    }
    else {
        my $sort_cb = $self->sort_cb;

        my $found = 0;

        my $idx;
        for ($idx = 0; $idx < $self->size; $idx++) {

            my $sort_it = $sort_cb->($node, $self->get($idx));

            if ($sort_it == -1) {
                $self->_insert($idx, $node);
                $found = 1;
                last;
            }

        }

        unless ($found) {
            $self->_insert($idx, $node);
        }

    }

    $node;
}


has sort_cb => (
	is => 'rw',
	isa => 'CodeRef',
	default => sub { sub { $_[0] <=> $_[1] } },
	);


__PACKAGE__->meta->make_immutable;

1;

