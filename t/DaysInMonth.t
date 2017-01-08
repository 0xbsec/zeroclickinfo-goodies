#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use DDG::Test::Goodie;

zci answer_type => 'days_in_month';
zci is_cached   => 0;

sub build_structured_answer {
  my ($month, $days) = @_;

  return qq(Number of days in $month is $days.),
    structured_answer => {
      input     => [$month],
      operation => 'Number of days in month',
      result    => $days
    };
}

sub build_test { test_zci(build_structured_answer(@_)) }

ddg_goodie_test(
  [qw( DDG::Goodie::DaysInMonth )],

  # month name can be complete
  # 'number of days in january' => test_zci(
  #     'Number of days in january is 31.',
  #     structured_answer => {
  #         input     => ['january'],
  #         operation => 'Number of days in month',
  #         result    => 31
  #     }
  # ),

  # month name can be complete
  'number of days in january' => build_test('January', 31),
  # can use 3-chars month name
  'how many days are in mar' => build_test('Mar', 31),
  'Number of days in may' => build_test('May', 31),
  # month name case doesn't matter
  'how many days in JAn' => build_test('Jan', 31),
  'how many days in ApRil' => build_test('April', 30),
  # invalid triggers/months
  'number of days in test' => undef,
  'number of days in febtest' => undef,
  'how many test are in' => undef,
  'quantity of days in december' => undef
);

done_testing;
