use Test2::V0 -no_srand => 1;
use 5.026;
use PPIx::Cache::Memory;
use Scalar::Util qw( refaddr );
use PPI::Document;
use Path::Tiny ();

my $cache = PPIx::Cache::Memory->new;

subtest 'basic' => sub {

  isa_ok $cache, 'PPIx::Cache::Memory';
  isa_ok $cache, 'PPI::Cache';

};

subtest 'set the cache' => sub {

  is(
    PPI::Document->set_cache($cache),
    T(),
  );

  is(
    refaddr(PPI::Document->get_cache),
    refaddr($cache),
  );

};

subtest 'use cache' => sub {

  my $perl = <<~'PERL';
    use strict;
    use warnings;

    say "Hello world!";  # a comment
    PERL

  my $dir = Path::Tiny->tempdir;
  my $file = $dir->child('foo.pl');
  $file->spew_utf8($perl);

  my $document1 = PPI::Document->new("$file");

  isa_ok(
    $cache->{$document1->hex_id},
    'PPI::Document',
  );

  my $document2 = PPI::Document->new("$file");

  is(
    $document1->serialize,
    $document2->serialize,
  );

  isnt
    refaddr($document1),
    refaddr($document2),
  ;

  $document1->prune('PPI::Token::Comment');

  isnt(
    $document1->serialize,
    $document2->serialize,
  );

};

done_testing;
