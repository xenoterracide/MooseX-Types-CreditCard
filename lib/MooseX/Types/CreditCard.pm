package MooseX::Types::CreditCard;
use 5.008;
use strict;
use warnings;

# VERSION

use MooseX::Types -declare => [ qw( CreditCard ) ];
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

1;

# ABSTRACT: Moose Credit Card type

=head1 SYNOPSIS

	{
		package My::Object;
		use Moose;
		use MooseX::Types::CreditCard qw( CreditCard );

		has credit_card => (
			coerce => 1,
			is     => 'ro',
			isa    => CreditCard,
		);

		__PACKAGE__->meta->make_immutable;
	}

	my $obj = My::Object->new({ credit_card => '4111111111111111' });

=head1 DESCRIPTION

This module provide a Credit Card type based on Int. It will validate that the
number passed to it appears to be a valid credit card number. Please note that
this does not mean that the Credit Card is actually valid, only that it
appears to be by algorithms defined in L<Business::CreditCard>.

The only type provided is C<CreditCard>.

Enabling coerce will strip out any non C<0-9> characters from a string
allowing for numbers like "4111-1111-1111-1111" to be passed.

=head1 SEE ALSO

=over

=item * L<Business::CreditCard>

=back

=cut
