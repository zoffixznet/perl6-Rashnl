use lib <lib>;
use Testo;
use Rashnl;

plan 1;

my $r := Rashnl.new: 0, 1;
is $r, Rashnl:D, 'can create a new Rashnl';
