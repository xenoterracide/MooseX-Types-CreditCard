#!/usr/bin/perl
use strict;
use warnings;
use Test::More;

{
	package Credit;
	use Moose;
	use MooseX::Types::CreditCard qw( CreditCard );

	has card => (
		is     => 'ro',
		isa    => CreditCard,
		coerce => 1,
	);

	__PACKAGE__->meta->make_immutable;
}

my $c2 = Credit->new({ card => '4111-1111-1111-1111' });

is( $c2->card, '4111111111111111', 'check card number returns' );

done_testing;
