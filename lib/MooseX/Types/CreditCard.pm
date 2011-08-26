package MooseX::Types::CreditCard;
use 5.008;
use strict;
use warnings;

# VERSION

use MooseX::Types -declare => [ qw( CreditCard CardSecurityCode ) ];
use MooseX::Types::Moose qw( Str Int );
use namespace::autoclean;

use Business::CreditCard;

subtype CreditCard,
	as Int,
	where { length($_) <= 20 && validate($_)  },
	message {'"'. $_ . '" is not a valid credit card number' }
	;

coerce CreditCard,
	from Str,
	via {
		my $int = $_;
		$int =~ tr/0-9//cd;
		return $int;
	}
	;

subtype CardSecurityCode,
	as Int,
	where { length $_ >= 3 && length $_ <= 4 },
	message { '"'
		. $_
		. '" is not a valid credit card security code. Must be 3 or 4 digits'
	}
	;

1;

# ABSTRACT: Moose Types related to Credit Cards

=head1 SYNOPSIS

	{
		package My::Object;
		use Moose;
		use MooseX::Types::CreditCard qw( CreditCard CardSecurityCode );

		has credit_card => (
			coerce => 1,
			is     => 'ro',
			isa    => CreditCard,
		);

		has cvv2 => (
			is  => 'ro',
			isa => CreditCardSecurityCode,
		);

		__PACKAGE__->meta->make_immutable;
	}

	my $obj = My::Object->new({
		credit_card => '4111111111111111',
		cvv2        => '123',
	});

=head1 DESCRIPTION

This module provides types related to Credit Cards for weak validation.

=head1 TYPES

=over

=item * C<CreditCard>

Base Type: C<Int>

It will validate that the number passed to it appears to be a
valid credit card number. Please note that this does not mean that the
Credit Card is actually valid, only that it appears to be by algorithms
defined in L<Business::CreditCard>.



Enabling coerce will strip out any non C<0-9> characters from a string
allowing for numbers like "4111-1111-1111-1111" to be passed.

=item * C<CardSecurityCode>

Base Type: C<Int>

A Credit L<Card Security Code|http://wikipedia.org/wiki/Card_security_code> is
a 3 or 4 digit number. This is also called CSC, CVV, CVC, and CID, depending
on the issuing vendor.

=back

=head1 SEE ALSO

=over

=item * L<Business::CreditCard>

=back

=cut
