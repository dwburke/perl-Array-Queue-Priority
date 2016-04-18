
use Test::Spec; # automatically turns on strict and warnings
use FindBin;
use lib "$FindBin::Bin/../lib";

use Array::Queue;

describe "Array::Queue" => sub {

    describe "adds an element" => sub {
        my $ar;

        before each => sub {
            $ar = Array::Queue->new;
            $ar->push( 5 );
        };

        it "size is 1" => sub {
            is( $ar->size, 1 );
        };

        it "first elem is 5" => sub {
            is( $ar->first, 5 );
        };

    };

    describe "adds multiple elements" => sub {
        my $ar;

        before each => sub {
            $ar = Array::Queue->new;
            $ar->push( 9 );
            $ar->push( 6 );
            $ar->push( 3 );
            $ar->push( 10 );
            $ar->push( 7 );
        };

        it "size is 5" => sub {
            is( $ar->size, 5 );
        };

        it "first is 9" => sub {
            is( $ar->first, 9 );
        };

        it "second is 6" => sub {
            $ar->pop;
            is( $ar->first, 6 );
        };

        it "third is 3" => sub {
            $ar->pop;
            $ar->pop;
            is( $ar->first, 3 );
        };

        it "fourth is 10" => sub {
            $ar->pop;
            $ar->pop;
            $ar->pop;
            is( $ar->first, 10 );
        };

        it "fifth is 7" => sub {
            $ar->pop;
            $ar->pop;
            $ar->pop;
            $ar->pop;
            is( $ar->first, 7 );
        };

    };

    describe "adds multiple non-dumeric" => sub {
        my $ar;

        before each => sub {
            $ar = Array::Queue->new(
                sort_cb => sub {
                    $_[0]->{l_name} cmp $_[1]->{l_name}
                });
            $ar->push({ l_name => 'Hess' });
            $ar->push({ l_name => 'Wilco' });
            $ar->push({ l_name => 'Burke' });
            $ar->push({ l_name => 'Robinson' });
            $ar->push({ l_name => 'Wall' });
            $ar->push({ l_name => 'Bates' });
        };

        it "size is 6" => sub {
            is( $ar->size, 6 );
        };

        it "first is Bates" => sub {
            is( $ar->first->{l_name}, 'Hess' );
        };

        it "second is Burke" => sub {
            $ar->pop;
            is( $ar->first->{l_name}, 'Wilco' );
        };

        it "third is Hess" => sub {
            $ar->pop;
            $ar->pop;
            is( $ar->first->{l_name}, 'Burke' );
        };

        it "fourth is Robinson" => sub {
            $ar->pop;
            $ar->pop;
            $ar->pop;
            is( $ar->first->{l_name}, 'Robinson' );
        };

        it "fifth is Wall" => sub {
            $ar->pop;
            $ar->pop;
            $ar->pop;
            $ar->pop;
            is( $ar->first->{l_name}, 'Wall' );
        };


        it "sixth is Wilco" => sub {
            $ar->pop;
            $ar->pop;
            $ar->pop;
            $ar->pop;
            $ar->pop;
            is( $ar->first->{l_name}, 'Bates' );
        };

    };


};

runtests unless caller;

