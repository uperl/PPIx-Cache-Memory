package PPIx::Cache::Memory;

use strict;
use warnings;
use 5.026;
use experimental qw( signatures );
use Ref::Util qw( is_plain_scalarref is_ref is_blessed_ref );
use PPI::Util ();
use Storable qw( dclone );

# ABSTRACT: Cache PPI documents in memory
# VERSION

=head1 SYNOPSIS

 use PPI::Document
 use PPIx::Cache::Memory;
 
 my $cache = PPIx::Cache::Memory->new;
 PPI::Document->set_cache( $cache );

=head1 DESCRIPTION

This class is similar to L<PPI::Cache>, but it caches to memory
instead of disk, which can be useful if you are parsing the same
documents from disparate modules that aren't easily able to
cooperate, AND you don't have easy access to the filesystem.

=head1 CONSTRUCTOR

=head2 new

 my $cache = PPIx::Cache::Memory->new;

Creates a new instance of the memory cache object.  This object
can be passed into the L<PPI::Document> class C<set_cache> method,
and will be used going forward.

=cut

sub new ($class)
{
  bless {}, $class;
}

=head1 METHODS

=head2 get_document

 my $document = $cache->get_document( $md5sum );
 my $document = $cache->get_document( \$source );

Get the document from the cache.  You can provide either the MD5 sum,
or a reference to a scalar containing the complete source.

=cut

sub get_document ($self, $key)
{
  my $md5 = is_plain_scalarref $key
    ? PPI::Util::md5hex($$key)
    : !is_ref $key
      ? lc $key
      : undef;
  $self->{$md5}
    ? dclone $self->{$md5}
    : undef;
}

=head2 store_document

 $cache->store_document( $document );

Store the given document in the cache.

=cut

sub store_document ($self, $document )
{
  return undef unless is_blessed_ref $document && $document->isa('PPI::Document');
  my $md5 = $document->hex_id or return undef;
  $self->{$md5} = dclone $document;
}

sub isa ($self, $class)
{
  # lie.  But why oh why is PPI::Cache a class and not a role?
  # and why does PPI even care as long as it supports the interface?
  defined $class && $class eq 'PPI::Cache'
    ? 1
    : $self->SUPER::isa($class);
}

1;

=head1 CAVEATS

Since documents are cached until the end of the process, this module is not
appropriate for long-lived processes or in memory poor situations.

=head1 SEE ALSO

=over 4

=item L<PPI>

=item L<PPI::Document>

=item L<PPI::Cache>

=back

=cut
