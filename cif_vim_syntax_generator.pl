#!/usr/bin/env perl

use strict;
use warnings;
use Carp;

sub create_section {
    my ($name, $record_identity, $names, $lengths, $highligh_prefix) = @_;
    println('" ' . $name);
    create_syntax($record_identity, $names, $lengths);
    create_links($record_identity, $names, $highligh_prefix);
}

sub create_syntax {
    my ($record_identity, $names, $lengths) = @_;
    croak "Must have same number of record names as lengths" if ($#$names != $#$lengths);
    print 'syn match ' . element_name($record_identity, 'RecordIdentity') . ' "^' . uc($record_identity) . '" nextgroup=' . element_name($record_identity, $$names[0]) . "\n";
    for my $i (0 .. $#$names) {
        print 'syn match ' . element_name($record_identity, $$names[$i]) . ' "' . '.'x$$lengths[$i] . '" contained';
        print ' nextgroup=' . element_name($record_identity, $$names[$i+1]) if ($i < $#$names);
        print "\n";
    }
    print "\n";
}

sub create_links {
    my ($record_identity, $names, $highlight_prefix) = @_;
    print 'hi link ' . element_name($record_identity, 'RecordIdentity') . ' ' . highlight($highlight_prefix, 'odd') . "\n";
    my $oddEven = 'even';
    for my $i (0 .. $#$names) {
        print 'hi link ' . element_name($record_identity, $$names[$i]) . ' ' . highlight($highlight_prefix, $oddEven) . "\n";
        $oddEven = $oddEven eq 'odd' ? 'even' : 'odd';
    }
    print "\n";
}

sub element_name {
    my ($record_identity, $field) = @_;
    return 'cif' . ucfirst($record_identity) . $field;
}

sub highlight {
    my ($prefix, $oddEven) = @_;
    return ($prefix eq '') ? $oddEven : $prefix . ucfirst($oddEven);
}

sub println {
    print "$_[0]\n";
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

