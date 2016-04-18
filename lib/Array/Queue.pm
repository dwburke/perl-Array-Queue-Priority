package Array::Queue;

use Moose;

use namespace::autoclean;


=head1 NAME

Array::Priority - An custom sorted queue

=head1 SYNOPSIS

    my $queue = Array::Priority->new( limit => 12 );
    $ar->add( 20 );
    $ar->add( 18 );
    $ar->add( 22 );

    say $ar->average;

=cut

sub first {
	my ($self) = @_;
	$self->get(0);
}


has queue => (
    is => 'rw',
    isa => 'ArrayRef[Item]', 
    traits => [ 'Array' ],
    default => sub { [ ] },
    handles => {
        push => 'push',
        pop => 'shift',
        size => 'count',
        get => 'get',
        empty => 'is_empty',
        _insert => 'insert',
    },
    );



__PACKAGE__->meta->make_immutable;

1;

