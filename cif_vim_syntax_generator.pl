#!/usr/bin/env perl

use strict;
use warnings;
use Carp;

sub create_section {
    my ($name, $record_identity, $names, $lengths, $highligh_prefix) = @_;
    print "\" $name\n";
    create_syntax($record_identity, $names, $lengths);
    create_links($record_identity, $names, $highligh_prefix);
}

sub create_syntax {
    my ($identity, $names, $lengths) = @_;
    croak "Must have same number of record names as lengths" if ($#$names != $#$lengths);
    syn_match(element($identity, 'RecordIdentity'), '^' . uc($identity), element($identity, $$names[0]), 0);
    for my $i (0 .. $#$names) {
        my $next = ($i < $#$names) ? element($identity, $$names[$i+1]) : '';
        syn_match(element($identity, $$names[$i]), '.'x$$lengths[$i], $next, 1);
    }
    print "\n";
}

sub create_links {
    my ($identity, $names, $prefix) = @_;
    hi_link(element($identity, 'RecordIdentity'), highlight($prefix, 'odd'));
    my $odd_even = 'even';
    for my $i (0 .. $#$names) {
        hi_link(element($identity, $$names[$i]), highlight($prefix, $odd_even));
        $odd_even = $odd_even eq 'odd' ? 'even' : 'odd';
    }
    print "\n";
}

sub syn_match {
    my ($name, $match, $next, $contained) = @_;
    print 'syn match ' . $name . ' "' . $match . '"';
    print ' contained' if ($contained);
    print ' nextgroup=' . $next if ($next ne '');
    print "\n";
}

sub hi_link {
    my ($name, $odd_even) = @_;
    print "hi link $name $odd_even\n";
}

sub element {
    my ($record_identity, $field) = @_;
    return 'cif' . ucfirst($record_identity) . $field;
}

sub highlight {
    my ($prefix, $oddEven) = @_;
    return ($prefix eq '') ? $oddEven : $prefix . ucfirst($oddEven);
}

# HEADER
print <<'VIM';
" Vim syntax file
" Language:     CIF
" Maintainer:   Mark Withall <mark.withall@tracsis.com>
" Last Change:  2013 Apr 11

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
    finish
endif

VIM

# BS
my @bs_names = qw(TransactionType TrainUid DateRunsFrom DateRunsTo DaysRun BankHolidayRunning TrainStatus TrainCategory TrainIdentity Headcode CourseIndicator TrainServiceCode PortionId PowerType TimingLoad Speed OperatingCharacteristics TrainClass Sleepers Reservations ConnectionIndicator CateringCode ServiceBranding Spare StpIndicator);
my @bs_lengths = qw(1 6 6 6 7 1 1 2 4 4 1 8 1 3 4 3 6 1 1 1 1 4 4 1 1);
create_section('Basic Schedule', 'bs', \@bs_names, \@bs_lengths, 'bs');

# BX
my @bx_names = qw(TractionClass UicCode AtocCode ApplicableTimetableCode ReservedFieldRsid ReservedFieldDataSource Spare);
my @bx_lengths = qw(4 5 2 1 8 1 57);
create_section('Basic Schedule Extra Detail', 'bx', \@bx_names, \@bx_lengths, '');

# LO
my @lo_names = qw(Location ScheduledDeparture PublicDeparture Platform Line EngineeringAllowance PathingAllowance Activity PerformanceAllowance Spare);
my @lo_lengths = qw(8 5 4 3 3 2 2 12 2 37);
create_section('Origin Location', 'lo', \@lo_names, \@lo_lengths, 'lo');

# LI
my @li_names = qw(Location ScheduledArrival ScheduledDeparture ScheduledPass PublicArrival PublicDeparture Platform Line Path Activity EngineeringAllowance PathingAllowance PerformanceAllowance Spare);
my @li_lengths = qw(8 5 5 5 4 4 3 3 3 12 2 2 2 20);
create_section('Intermediate Location', 'li', \@li_names, \@li_lengths, '');

# CR
my @cr_names = qw(Location TrainCategory TrainIdentity Headcode CourseIndicator TrainServiceCode PortionId PowerType TimingLoad Speed OperatingCharacteristics TrainClass Sleepers Reservations ConnectionIndicator CateringCode ServiceBranding TractionClass UicCode ReservedFieldRsid Spare);
my @cr_lengths = qw(8 2 4 4 1 8 1 3 4 3 6 1 1 1 1 4 4 4 5 8 5);
create_section('Change En Route', 'cr', \@cr_names, \@cr_lengths, '');

# LT
my @lt_names = qw(Location ScheduledArrival PublicArrival Platform Path Activity Spare);
my @lt_lengths = qw(8 5 4 3 3 12 43);
create_section('Terminating Location', 'lt', \@lt_names, \@lt_lengths, 'lt');

# FOOTER
print <<'VIM';
" Colouring
hi odd      guibg=#EEEEEE
hi even     guibg=#CCCCCC
hi bsOdd    guibg=#EEEEFF
hi bsEven   guibg=#CCCCFF
hi loOdd    guibg=#EEFFEE
hi loEven   guibg=#CCFFCC
hi ltOdd    guibg=#FFEEEE
hi ltEven   guibg=#FFCCCC
hi crOdd    guibg=#FFFFEE
hi crEven   guibg=#FFFFCC

let b:current_syntax = "cif"
VIM

