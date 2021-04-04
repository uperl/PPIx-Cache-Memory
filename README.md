# PPIx::Cache::Memory ![linux](https://github.com/uperl/PPIx-Cache-Memory/workflows/linux/badge.svg) ![windows](https://github.com/uperl/PPIx-Cache-Memory/workflows/windows/badge.svg) ![macos](https://github.com/uperl/PPIx-Cache-Memory/workflows/macos/badge.svg) ![cygwin](https://github.com/uperl/PPIx-Cache-Memory/workflows/cygwin/badge.svg) ![msys2-mingw](https://github.com/uperl/PPIx-Cache-Memory/workflows/msys2-mingw/badge.svg)

Cache PPI documents in memory

# SYNOPSIS

```perl
use PPI::Document
use PPIx::Cache::Memory;

my $cache = PPIx::Cache::Memory->new;
PPI::Document->set_cache( $cache );
```

# DESCRIPTION

This class is similar to [PPI::Cache](https://metacpan.org/pod/PPI::Cache), but it caches to memory
instead of disk, which can be useful if you are parsing the same
documents from disparate modules that aren't easily able to
cooperate, AND you don't have easy access to the filesystem.

# CONSTRUCTOR

## new

```perl
my $cache = PPIx::Cache::Memory->new;
```

Creates a new instance of the memory cache object.  This object
can be passed into the [PPI::Document](https://metacpan.org/pod/PPI::Document) class `set_cache` method,
and will be used going forward.

# METHODS

## get\_document

```perl
my $document = $cache->get_document( $md5sum );
my $document = $cache->get_document( \$source );
```

Get the document from the cache.  You can provide either the MD5 sum,
or a reference to a scalar containing the complete source.

## store\_document

```
$cache->store_document( $document );
```

Store the given document in the cache.

# CAVEATS

Since documents are cached until the end of the process, this module is not
appropriate for long-lived processes or in memory poor situations.

# SEE ALSO

- [PPI](https://metacpan.org/pod/PPI)
- [PPI::Document](https://metacpan.org/pod/PPI::Document)
- [PPI::Cache](https://metacpan.org/pod/PPI::Cache)

# AUTHOR

Graham Ollis <plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2021 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
