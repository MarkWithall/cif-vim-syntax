#!/usr/bin/env perl

use strict;
use warnings;
use Carp;
use List::Util 'sum';

sub read_ids {
    my $line = <DATA>;
    chomp($line);
    return split(',', $line);
}

sub read_data {
    my %data = ();
    my $id;
    while (my $line = <DATA>) {
        next if ($line =~ /^\s*$/);
        chomp($line);
        if ($line =~ /^(\w+)\s+(\d+)$/) {
            push @{$data{$id}{fields}}, {name => $1, size => $2};
        }
        elsif ($line =~ /^(\w\w),([^,]+),(\w*)/) {
            $id = $1;
            $data{$id}{description} = $2;
            $data{$id}{prefix} = $3;
        }
    }
    return %data;
}

sub create_section {
    my ($name, $id, $fields, $prefix) = @_;
    print "\" $name\n";
    create_syntax($id, $fields);
    create_links($id, $fields, $prefix);
}

sub create_syntax {
    my ($id, $fields) = @_;
    croak "Sum of field lengths must be 78" if (sum(map {$_->{size}} @$fields) != 78);
    syn_match(element($id, 'RecordIdentity'), '^' . uc($id), element($id, $$fields[0]{name}), 0);
    for my $i (0 .. $#$fields) {
        my $next = ($i < $#$fields) ? element($id, $$fields[$i+1]{name}) : '';
        syn_match(element($id, $$fields[$i]{name}), '.'x$$fields[$i]{size}, $next, 1);
    }
    print "\n";
}

sub create_links {
    my ($id, $fields, $prefix) = @_;
    hi_link(element($id, 'RecordIdentity'), highlight($prefix, 'odd'));
    my $odd_even = 'even';
    for my $i (0 .. $#$fields) {
        hi_link(element($id, $$fields[$i]{name}), highlight($prefix, $odd_even));
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
    my ($id, $field) = @_;
    return 'cif' . ucfirst($id) . $field;
}

sub highlight {
    my ($prefix, $oddEven) = @_;
    return ($prefix eq '') ? $oddEven : $prefix . ucfirst($oddEven);
}

my $lastchange = scalar localtime();
my $maintainer = 'Mark Withall <mark.withall@tracsis.com>';

# HEADER
print <<VIM;
" Vim syntax file
" Language:     CIF
" Maintainer:   $maintainer
" Last Change:  $lastchange

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
    finish
endif

VIM

my @ids = read_ids();
my %data = read_data();

for my $id (@ids) {
    create_section($data{$id}{description}, $id, $data{$id}{fields}, $data{$id}{prefix});
}

# FOOTER
print <<'VIM';
" Colouring
hi odd      guibg=#EEEEEE ctermbg=darkgrey   ctermfg=white
hi even     guibg=#CCCCCC
hi bsOdd    guibg=#EEEEFF ctermbg=blue       ctermfg=white
hi bsEven   guibg=#CCCCFF
hi loOdd    guibg=#EEFFEE ctermbg=darkgreen  ctermfg=white
hi loEven   guibg=#CCFFCC
hi ltOdd    guibg=#FFEEEE ctermbg=darkred    ctermfg=white
hi ltEven   guibg=#FFCCCC
hi crOdd    guibg=#FFFFEE ctermbg=darkyellow ctermfg=white
hi crEven   guibg=#FFFFCC

let b:current_syntax = "cif"
VIM

__DATA__
hd,bs,bx,lo,li,cr,lt,tn,ln,aa,ti,ta,td,zz

hd,Header,
FileMainframeIdentity   20
DateOfExtract           6
TimeOfExtract           4
CurrentFileRef          7
LastFileRef             7
BleedOffUpdateInd       1
Version                 1
UserExtractStartDate    6
UserExtractEndDate      6
Spare                   20

bs,Basic Schedule,bs
TransactionType              1
TrainUid                     6
DateRunsFrom                 6
DateRunsTo                   6
DaysRun                      7
BankHolidayRunning           1
TrainStatus                  1
TrainCategory                2
TrainIdentity                4
Headcode                     4
CourseIndicator              1
TrainServiceCode             8
PortionId                    1
PowerType                    3
TimingLoad                   4
Speed                        3
OperatingCharacteristics     6
TrainClass                   1
Sleepers                     1
Reservations                 1
ConnectionIndicator          1
CateringCode                 4
ServiceBranding              4
Spare                        1
StpIndicator                 1

bx,Basic Schedule Extra Detail,
TractionClass                4
UicCode                      5
AtocCode                     2
ApplicableTimetableCode      1
ReservedFieldRsid            8
ReservedFieldDataSource      1
Spare                        57

lo,Origin Location,lo
Location                 8
ScheduledDeparture       5
PublicDeparture          4
Platform                 3
Line                     3
EngineeringAllowance     2
PathingAllowance         2
Activity                 12
PerformanceAllowance     2
Spare                    37

li,Intermediate Location,
Location                 8
ScheduledArrival         5
ScheduledDeparture       5
ScheduledPass            5
PublicArrival            4
PublicDeparture          4
Platform                 3
Line                     3
Path                     3
Activity                 12
EngineeringAllowance     2
PathingAllowance         2
PerformanceAllowance     2
Spare                    20

cr,Change En Route,
Location                     8
TrainCategory                2
TrainIdentity                4
Headcode                     4
CourseIndicator              1
TrainServiceCode             8
PortionId                    1
PowerType                    3
TimingLoad                   4
Speed                        3
OperatingCharacteristics     6
TrainClass                   1
Sleepers                     1
Reservations                 1
ConnectionIndicator          1
CateringCode                 4
ServiceBranding              4
TractionClass                4
UicCode                      5
ReservedFieldRsid            8
Spare                        5

lt,Terminating Location,lt
Location             8
ScheduledArrival     5
PublicArrival        4
Platform             3
Path                 3
Activity             12
Spare                43

tn,Train Specific Note,
NoteType    1
Note        77

ln,Location Specific Note,
NoteType    1
Note        77

aa,Association,
TransactionType         1
MainTrainUid            6
AssociatedTrainUid      6
AssociationStartDate    6
AssociationEndDate      6
AssociationDays         7
AssociationCategory     2
AssociationDateInd      1
AssociationLocation     7
BaseLocationSuffix      1
AssocLocationSuffix     1
DiagramType             1
AssociationType         1
Spare                   31
StpIndicator            1

ti,Tiploc Insert,
TiplocCode                  7
CapitalsIdentification      2
Nalco                       6
NlcCheckCharacter           1
TpsDescription              26
Stanox                      5
PoMcpCode                   4
CrsCode                     3
SixteenCharacterDescription 16
Spare                       8

ta,Tiploc Amend,
TiplocCode                  7
CapitalsIdentification      2
Nalco                       6
NlcCheckCharacter           1
TpsDescription              26
Stanox                      5
PoMcpCode                   4
CrsCode                     3
SixteenCharacterDescription 16
NewTiploc                   7
Spare                       1

td,Tiploc Delete,
TiplocCode  7
Spare       71

zz,Trailer,
Spare   78

