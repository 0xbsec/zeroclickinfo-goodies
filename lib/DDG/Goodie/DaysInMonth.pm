package DDG::Goodie::DaysInMonth;
# ABSTRACT: Returns number of days in a given month

use DDG::Goodie;
use strict;
use DateTime;

with 'DDG::GoodieRole::Dates';

zci answer_type => 'days_in_month';

zci is_cached => 0;

triggers any => 'how many days in','how many days are in', 'what is the number of days in', 'number of days in';

handle remainder => sub {
    my $remainder = $_;
    return unless $remainder;
    my $month_regex = month_regex();
    my ($month) = $remainder =~ qr/^($month_regex)$/;
    return unless $month;
    my $days = calculateNumberOfDaysForMonthString($month);
    return sprintf("Number of days in %s is %d.", ucfirst lc $month, $days),
    structured_answer => {
        input => [ucfirst lc $month],
        operation => 'Number of days in month',
        result => ($days)
    };
};

sub calculateNumberOfDaysForMonthString{
  my $month = lc substr($_[0], 0, 3);
  my $year = DateTime->now->year;
  my %months2num = qw(
    jan 1  feb 2  mar 3  apr 4  may 5  jun 6
    jul 7  aug 8  sep 9  oct 10 nov 11 dec 12);
  return DateTime->last_day_of_month(year => $year, month => $months2num{$month})->day;
}

1;
