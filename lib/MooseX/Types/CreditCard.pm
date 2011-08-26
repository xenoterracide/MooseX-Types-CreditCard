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
	where { validate($_) },
	message {'"'. $_ . '" is not a valid credit card number' }
	;

coerce CreditCard,
	from Str,
	via {
		my $cc_regex
			=
'^
([[:digit:]]{4})
[ -]?
([[:digit:]]{4})
[ -]?
([[:digit:]]{4})
[ -]?
([[:digit:]]{4})
$'
			; # extract numbers from patterns like 4111-1111-1111-1111
		my ( $int1, $int2, $int3, $int4 ) = $_ =~ /$cc_regex/gxms;
		return $int1 . $int2 . $int3 . $int4;
	}
	;

1;

# ABSTRACT: MooseX::Types::CreditCard
