#!/usr/bin/perl

use strict;
use MIME::Base32::Readable;

my $data = <<PERLHEREDOC;
Peter Piper picked a peck of pickled pepper;
A peck of pickled pepper Peter Piper picked;
If Peter Piper picked a peck of pickled pepper,
Where's the peck of pickled pepper Peter Piper picked?
PERLHEREDOC

my $enc = MIME::Base32::Readable::encode ($data);
print "Encoded:\n", $enc, "\n\n";

my $dec = MIME::Base32::Readable::decode ($enc);
print "Decoded:\n", $dec, "\n";

print "Is same ? ", $data eq $dec ? 'yes' : 'no', "\n";
