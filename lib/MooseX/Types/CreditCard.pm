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
	message { $_ . ' is not a valid credit card number' }
	;

coerce CreditCard,
	from Str,
	via { my $int = $_ =~ /([[:digit:]])/gxms }
	;

1;

# ABSTRACT: MooseX::Types::CreditCard
