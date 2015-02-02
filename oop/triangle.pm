package Triangle;
use Carp qw(croak);

my $space = sub{
	my($a,$b,$c) = @_;
	my $s = ($a + $b + $c)/2;
	my $inroot = $s*($s-$a)*($s-$b)*($s-$c);

	if($inroot >= 0){
		return sqrt($inroot);
	}
	else{
		croak "you cannot construct the triangle with the side $a,$b,$c";
	}
};

sub new{
	my ($class,$a,$b,$c) = @_;
	bless { a => $a,b => $b,c => $c,s => $space->($a,$b,$c)};
}

sub space{
	my $self = shift;
	warn "You are about to calculate the space of ",ref($self),"!!! \n";
	return $self->{s};
}

sub getSides{
	my $self = shift;
	return ($self->{a},$self->{b},$self->{c});
}

sub setSides{
    my ($self,$a,$b,$c) = @_;
    $self->{a} = $a;
    $self->{b} = $b;
    $self->{c} = $c;
    $self->{s} = $space->($a,$b,$c);
}


1;