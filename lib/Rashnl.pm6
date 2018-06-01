unit class Rashnl does Real;

has Int $.nu;
has Int $.de;
has int $.fat;

my constant FAT_LIMIT = 2⁶⁴;

sub REDUCE (\n, \d) {
  when not d { Rashnl.bless: :nu(n > 0 ?? 1 !! n ?? -1 !! 0), :0de }

  my \gcd  := nu gcd de;
  my $nu := nu div gcd;
  my $de := de div gcd;
  if $de < 0 { $nu := -$nu; $de := -$de; }
  Rashnl.bless: :$nu, :$de, :fat($de ≥ FAT_LIMIT)
}

method new (Int \nu, Int \de --> ::?CLASS:D) { REDUCE nu, de }

method ceiling { $de == 1 ?? $!nu !! 1 + ($nu div $!de) }
method floor   { $!nu div $!de }
method nude    { $!nu, $!de }

multi method Num (::?CLASS:U:) { Num }
multi method Int (::?CLASS:U:) { Int }
multi method Num (::?CLASS:D:) { Num($!nu / $!de) }
multi method Int (::?CLASS:D:) { self.truncate }
