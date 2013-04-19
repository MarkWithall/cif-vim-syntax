#!/usr/bin/env perl

use strict;
use warnings;
use Carp;
use List::Util 'sum';

sub create_section {
    my ($name, $record_identity, $fields, $highligh_prefix) = @_;
    print "\" $name\n";
    create_syntax($record_identity, [map {$_->{name}} @$fields], [map {$_->{size}} @$fields]);
    create_links($record_identity, [map {$_->{name}} @$fields], $highligh_prefix);
}

sub create_syntax {
    my ($identity, $names, $lengths) = @_;
    croak "Must have same number of record names as lengths" if ($#$names != $#$lengths);
    croak "Sum of field lengths must be 78" if (sum(@$lengths) != 78);
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
my @bs_fields = (
    {name => 'TransactionType', size => 1},
    {name => 'TrainUid', size => 6},
    {name => 'DateRunsFrom', size => 6},
    {name => 'DateRunsTo', size => 6},
    {name => 'DaysRun', size => 7},
    {name => 'BankHolidayRunning', size => 1},
    {name => 'TrainStatus', size => 1},
    {name => 'TrainCategory', size => 2},
    {name => 'TrainIdentity', size => 4},
    {name => 'Headcode', size => 4},
    {name => 'CourseIndicator', size => 1},
    {name => 'TrainServiceCode', size => 8},
    {name => 'PortionId', size => 1},
    {name => 'PowerType', size => 3},
    {name => 'TimingLoad', size => 4},
    {name => 'Speed', size => 3},
    {name => 'OperatingCharacteristics', size => 6},
    {name => 'TrainClass', size => 1},
    {name => 'Sleepers', size => 1},
    {name => 'Reservations', size => 1},
    {name => 'ConnectionIndicator', size => 1},
    {name => 'CateringCode', size => 4},
    {name => 'ServiceBranding', size => 4},
    {name => 'Spare', size => 1},
    {name => 'StpIndicator', size => 1},
);
create_section('Basic Schedule', 'bs', \@bs_fields, 'bs');

# BX
my @bx_fields = (
    {name => 'TractionClass', size => 4},
    {name => 'UicCode', size => 5},
    {name => 'AtocCode', size => 2},
    {name => 'ApplicableTimetableCode', size => 1},
    {name => 'ReservedFieldRsid', size => 8},
    {name => 'ReservedFieldDataSource', size => 1},
    {name => 'Spare', size => 57},
);
create_section('Basic Schedule Extra Detail', 'bx', \@bx_fields, '');

# LO
my @lo_fields = (
    {name => 'Location',                size => 8},
    {name => 'ScheduledDeparture',       size => 5},
    {name => 'PublicDeparture',         size => 4},
    {name => 'Platform',                size => 3},
    {name => 'Line',                    size => 3},
    {name => 'EngineeringAllowance',    size => 2},
    {name => 'PathingAllowance',        size => 2},
    {name => 'Activity',                size => 12},
    {name => 'PerformanceAllowance',    size => 2},
    {name => 'Spare',                   size => 37},
);
create_section('Origin Location', 'lo', \@lo_fields, 'lo');

# LI
my @li_fields = (
    {name => 'Location', size => 8},
    {name => 'ScheduledArrival', size => 5},
    {name => 'ScheduledDeparture', size => 5},
    {name => 'ScheduledPass', size => 5},
    {name => 'PublicArrival', size => 4},
    {name => 'PublicDeparture', size => 4},
    {name => 'Platform', size => 3},
    {name => 'Line', size => 3},
    {name => 'Path', size => 3},
    {name => 'Activity', size => 12},
    {name => 'EngineeringAllowance', size => 2},
    {name => 'PathingAllowance', size => 2},
    {name => 'PerformanceAllowance', size => 2},
    {name => 'Spare', size => 20},
);
create_section('Intermediate Location', 'li', \@li_fields, '');

# CR
my @cr_fields = (
    {name => 'Location', size => 8},
    {name => 'TrainCategory', size => 2},
    {name => 'TrainIdentity', size => 4},
    {name => 'Headcode', size => 4},
    {name => 'CourseIndicator', size => 1},
    {name => 'TrainServiceCode', size => 8},
    {name => 'PortionId', size => 1},
    {name => 'PowerType', size => 3},
    {name => 'TimingLoad', size => 4},
    {name => 'Speed', size => 3},
    {name => 'OperatingCharacteristics', size => 6},
    {name => 'TrainClass', size => 1},
    {name => 'Sleepers', size => 1},
    {name => 'Reservations', size => 1},
    {name => 'ConnectionIndicator', size => 1},
    {name => 'CateringCode', size => 4},
    {name => 'ServiceBranding', size => 4},
    {name => 'TractionClass', size => 4},
    {name => 'UicCode', size => 5},
    {name => 'ReservedFieldRsid', size => 8},
    {name => 'Spare', size => 5},
);
create_section('Change En Route', 'cr', \@cr_fields, '');

# LT
my @lt_fields = (
    {name => 'Location', size => 8},
    {name => 'ScheduledArrival', size => 5},
    {name => 'PublicArrival', size => 4},
    {name => 'Platform', size => 3},
    {name => 'Path', size => 3},
    {name => 'Activity', size => 12},
    {name => 'Spare', size => 43},
);
create_section('Terminating Location', 'lt', \@lt_fields, 'lt');

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

