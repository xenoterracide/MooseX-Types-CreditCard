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

# ABSTRACT: MooseX::Types::CreditCard
