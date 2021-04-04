use Test2::V0 -no_srand => 1;
use 5.020;
use PPIx::Cache::Memory;

subtest basic => sub {

  my $cache = PPIx::Cache::Memory->new;
  isa_ok $cache, 'PPIx::Cache::Memory';
  isa_ok $cache, 'PPI::Cache';

};

done_testing;


