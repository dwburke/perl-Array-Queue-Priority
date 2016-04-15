package Array::Priority;

use Moose;
use List::Util qw(sum0);

use namespace::autoclean;


sub first {
	my ($self) = @_;
	$self->get(0);
}


sub push {
    my ($self, $node) = @_;

    if ($self->size == 0) {
        $self->_add( $node );
    }
    else {
        my $sort_cb = $self->sort_cb;

        my $found = 0;

        for (my $idx = 0; $idx < $self->size; $idx++) {

            my $sort_it = $sort_cb->($node, $self->get($idx));

            if ($sort_it == -1) {
                $self->_insert($idx, $node);
                $found = 1;
                last;
            }

        }

        unless ($found) {
            $self->_add($node);
        }

    }

    $node;
}


has sort_cb => (
	is => 'rw',
	isa => 'CodeRef',
	default => sub { sub { $_[0] <=> $_[1] } },
	);


has queue => (
    is => 'rw',
    isa => 'ArrayRef[Item]', 
    traits => [ 'Array' ],
    default => sub { [ ] },
    handles => {
        _add => 'push',
        pop => 'shift',
        _insert => 'insert',
        _remove => 'shift',
        size => 'count',
        get => 'get',
	empty => 'is_empty',
    },
    );



__PACKAGE__->meta->make_immutable;

1;

