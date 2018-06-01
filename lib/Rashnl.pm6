unit class Rashnl does Real;

has Int $.nu;
has Int $.de;
has int $.fat;

my constant FAT_LIMIT = 2⁶⁴;

sub REDUCE (\n, \d) {
  when not d { Rashnl.bless: :nu(n > 0 ?? 1 !! n ?? -1 !! 0), :0de }

  my \gcd := n gcd d;
  my $nu  := n div gcd;
  my $de  := d div gcd;
  if $de < 0 { $nu := -$nu; $de := -$de; }
  Rashnl.bless: :$nu, :$de, :fat($de ≥ FAT_LIMIT)
}

sub  infix:<·> (Int \i, Int \f) is export { REDUCE i×$_+f, $_ with 10**f.chars }
sub prefix:<·> (        Int \f) is export { &[·](0,f) }

method new (Int \nu, Int \de --> ::?CLASS:D) { REDUCE nu, de }

method ceiling { $!de == 1 ?? $!nu !! 1 + ($!nu div $!de)   }
proto method base(|) { * }
multi method base(\b         ) { self.Rat.base: b           }
multi method base(\b, \digits) { self.Rat.base: b, digits   }
method base-repeating(\b = 10) { self.Rat.base-repeating: b }
method floor    { $!nu div $!de }
method is-prime { $!de == 1 and $!nu.is-prime }
method isNaN    { not $!nu and not $!de }
method nude     { $!nu, $!de }

multi method Bool(::?CLASS:D:) { so $!nu }
method Bridge { self.Num }

proto method FatRat (|) { * }
multi method FatRat (::?CLASS:U:) { FatRat }
multi method FatRat (::?CLASS:D:) { FatRat.new: $!nu, $!de }

proto method Int (|) { * }
multi method Int (::?CLASS:U:) { Int }
multi method Int (::?CLASS:D:) { self.truncate }

proto method Num (|) { * }
multi method Num (::?CLASS:U:) { Num }
multi method Num (::?CLASS:D:) { Num($!nu / $!de) }

proto method Rat (|) { * }
multi method Rat (::?CLASS:U:) { Rat }
multi method Rat (::?CLASS:D:) { Rat.new: $!nu, $!de }
