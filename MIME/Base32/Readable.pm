package MIME::Base32::Readable;

use strict;
use warnings;

use vars qw( $VERSION );
$VERSION = '1.00';

sub encode {
    my $buf = join '', @_;

    $buf = unpack 'B*', $buf;
    $buf =~ s/(.....)/000$1/g;

    my $len = length $buf;
    if ($len & 7) {
        my $e = substr $buf, $len & ~7;
        $buf = substr $buf, 0, $len & ~7;
        $buf .= '000'. $e. '0' x (5 - length $e);
    }

    $buf = pack 'B*', $buf;
    $buf =~ tr/\0-\37/ABCDEFGHJKLMNPQRSTUVWXYZ23456789/;

    $buf;
}

sub decode {
    my $buf = uc join '', @_;

    $buf =~ tr/ABCDEFGHJKLMNPQRSTUVWXYZ23456789/\0-\37/;
    $buf =~ s/[\40-\255]//g;
    $buf = unpack 'B*', $buf;

    $buf =~ s/000(.....)/$1/g;

    my $len = length $buf;
    $buf = substr $buf, 0, $len & ~7 if $len & 7;
    pack 'B*', $buf;
}

1;

=head1 NAME

MIME::Base32::Readable - Safely Readable/Writable Base32 encoder/decoder

=head1 SYNOPSIS

    use MIME::Base32::Readable;

    $encoded = MIME::Base32::Readable::encode ($data);
    $encoded = lc MIME::Base32::Readable::encode ($data); # Decoder is non case-sensitive

    $data = MIME::Base32::Readable::decode ($encoded);

=head1 DESCRIPTION

Encode data similar way like MIME::Base32 does.
But the encoded sequence does not contain 'I' (9th of ABC), 'O' (15th of ABC), '0' (zero) and '1' (one),
which are troublesome in reading and writing.

=head1 EXPORT

None

=head1 AUTHOR

Hiroyuki UENISHI <pirolix@cpan.org> 
Open MagicVox.net - http://www.magicvox.net/

=head1 COPYRIGHT

Copyright (c) 2010 Hiroyuki UENISHI. All rights reserved.

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=head1 SEE ALSO

L<MIME::Base32>

=cut
