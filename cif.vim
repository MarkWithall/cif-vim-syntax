" Vim syntax file
" Language:     CIF
" Maintainer:   Mark Withall <mark.withall@tracsis.com>
" Last Change:  2013 Apr 11

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
    finish
endif

" Basic Schedule Record
syn match cifBsRecordIdentity   "^BS"       nextgroup=cifBsTransactionType
syn match cifBsTransactionType  "."         contained nextgroup=cifBsTrainUid
syn match cifBsTrainUid         ".\{6}"     contained nextgroup=cifBsDateRunsFrom
syn match cifBsDateRunsFrom     ".\{6}"     contained nextgroup=cifBsDateRunsTo
syn match cifBsDateRunsTo       ".\{6}"     contained nextgroup=cifBsDaysRun
syn match cifBsDaysRun          ".\{7}"     contained nextgroup=cifBsBankHolidayRunning
syn match cifBsBankHolidayRunning   "."     contained nextgroup=cifBsTrainStatus
syn match cifBsTrainStatus      "."         contained nextgroup=cifBsTrainCategory
syn match cifBsTrainCategory    ".\{2}"     contained nextgroup=cifBsTrainIdentity
syn match cifBsTrainIdentity    ".\{4}"     contained nextgroup=cifBsHeadcode
syn match cifBsHeadcode         ".\{4}"     contained nextgroup=cifBsCourseIndicator
syn match cifBsCourseIndicator  "."         contained nextgroup=cifBsTrainServiceCode
syn match cifBsTrainServiceCode ".\{8}"     contained nextgroup=cifBsPortionId
syn match cifBsPortionId        "."         contained nextgroup=cifBsPowerType
syn match cifBsPowerType        ".\{3}"     contained nextgroup=cifBsTimingLoad
syn match cifBsTimingLoad       ".\{4}"     contained nextgroup=cifBsSpeed
syn match cifBsSpeed            ".\{3}"     contained nextgroup=cifBsOperatingCharacteristics
syn match cifBsOperatingCharacteristics ".\{6}" contained nextgroup=cifBsTrainClass
syn match cifBsTrainClass       "."         contained nextgroup=cifBsSleepers
syn match cifBsSleepers         "."         contained nextgroup=cifBsReservations
syn match cifBsReservations     "."         contained nextgroup=cifBsConnectionIndicator
syn match cifBsConnectionIndicator  "."     contained nextgroup=cifBsCateringCode
syn match cifBsCateringCode     ".\{4}"     contained nextgroup=cifBsServiceBranding
syn match cifBsServiceBranding  ".\{4}"     contained nextgroup=cifBsSpare
syn match cifBsSpare            "."         contained nextgroup=cifBsStpIndicator
syn match cifBsStpIndicator     "."         contained

hi link cifBsRecordIdentity     bsOdd
hi link cifBsTransactionType    bsEven
hi link cifBsTrainUid           bsOdd
hi link cifBsDateRunsFrom       bsEven
hi link cifBsDateRunsTo         bsOdd
hi link cifBsDaysRun            bsEven
hi link cifBsBankHolidayRunning bsOdd
hi link cifBsTrainStatus        bsEven
hi link cifBsTrainCategory      bsOdd
hi link cifBsTrainIdentity      bsEven
hi link cifBsHeadcode           bsOdd
hi link cifBsCourseIndicator    bsEven
hi link cifBsTrainServiceCode   bsOdd
hi link cifBsPortionId          bsEven
hi link cifBsPowerType          bsOdd
hi link cifBsTimingLoad         bsEven
hi link cifBsSpeed              bsOdd
hi link cifBsOperatingCharacteristics bsEven
hi link cifBsTrainClass         bsOdd
hi link cifBsSleepers           bsEven
hi link cifBsReservations       bsOdd
hi link cifBsConnectionIndicator bsEven
hi link cifBsCateringCode       bsOdd
hi link cifBsServiceBranding    bsEven
hi link cifBsSpare              bsOdd
hi link cifBsStpIndicator       bsEven

" Basic Schedule Extra Detail
syn match cifBxRecordIdentity   "^BX"       nextgroup=cifBxTractionClass
syn match cifBxTractionClass    ".\{4}"     contained nextgroup=cifBxUicCode
syn match cifBxUicCode          ".\{5}"     contained nextgroup=cifBxAtocCode
syn match cifBxAtocCode         ".\{2}"     contained nextgroup=cifBxApplicableTimetableCode
syn match cifBxApplicableTimetableCode  "." contained nextgroup=cifBxReservedFieldRsid
syn match cifBxReservedFieldRsid    ".\{8}" contained nextgroup=cifBxReservedFieldDataSource
syn match cifBxReservedFieldDataSource  "." contained nextgroup=cifBxSpare
syn match cifBxSpare            ".\{57}"    contained

hi link cifBxRecordIdentity     odd
hi link cifBxTractionClass      even
hi link cifBxUicCode            odd
hi link cifBxAtocCode           even
hi link cifBxApplicableTimetableCode    odd
hi link cifBxReservedFieldRsid  even
hi link cifBxReservedFieldDataSource    odd
hi link cifBxSpare              even

" Origin Location
syn match cifLoRecordIdentity   "^LO"       nextgroup=cifLoLocation
syn match cifLoLocation         ".\{8}"     contained nextgroup=cifLoScheduledDeparture
syn match cifLoScheduledDeparture   ".\{5}" contained nextgroup=cifLoPublicDeparture
syn match cifLoPublicDeparture  ".\{4}"     contained nextgroup=cifLoPlatform
syn match cifLoPlatform         ".\{3}"     contained nextgroup=cifLoLine
syn match cifLoLine             ".\{3}"     contained nextgroup=cifLoEngineeringAllowance
syn match cifLoEngineeringAllowance ".\{2}" contained nextgroup=cifLoPathingAllowance
syn match cifLoPathingAllowance ".\{2}"     contained nextgroup=cifLoActivity
syn match cifLoActivity         ".\{12}"    contained nextgroup=cifLoPerformanceAllowance
syn match cifLoPerformanceAllowance ".\{2}" contained nextgroup=cifLoSpare
syn match cifLoSpare            ".\{37}"    contained

hi link cifLoRecordIdentity     loOdd
hi link cifLoLocation           loEven
hi link cifLoScheduledDeparture loOdd
hi link cifLoPublicDeparture    loEven
hi link cifLoPlatform           loOdd
hi link cifLoLine               loEven
hi link cifLoEngineeringAllowance   loOdd
hi link cifLoPathingAllowance   loEven
hi link cifLoActivity           loOdd
hi link cifLoPerformanceAllowance   loEven
hi link cifLoSpare              loOdd

" Intermediate Location
syn match cifLiRecordIdentity   "^LI"       nextgroup=cifLiLocation
syn match cifLiLocation         ".\{8}"     contained nextgroup=cifLiScheduledArrival
syn match cifLiScheduledArrival ".\{5}"     contained nextgroup=cifLiScheduledDeparture
syn match cifLiScheduledDeparture   ".\{5}" contained nextgroup=cifLiScheduledPass
syn match cifLiScheduledPass    ".\{5}"     contained nextgroup=cifLiPublicArrival
syn match cifLiPublicArrival    ".\{4}"     contained nextgroup=cifLiPublicDeparture
syn match cifLiPublicDeparture  ".\{4}"     contained nextgroup=cifLiPlatform
syn match cifLiPlatform         ".\{3}"     contained nextgroup=cifLiLine
syn match cifLiLine             ".\{3}"     contained nextgroup=cifLiPath
syn match cifLiPath             ".\{3}"     contained nextgroup=cifLiActivity
syn match cifLiActivity         ".\{12}"    contained nextgroup=cifLiEngineeringAllowance
syn match cifLiEngineeringAllowance ".\{2}" contained nextgroup=cifLiPathingAllowance
syn match cifLiPathingAllowance ".\{2}"     contained nextgroup=cifLiPerformanceAllowance
syn match cifLiPerformanceAllowance ".\{2}" contained nextgroup=cifLiSpare
syn match cifLiSpare            ".\{20}"    contained

hi link cifLiRecordIdentity     odd
hi link cifLiLocation           even
hi link cifLiScheduledArrival   odd
hi link cifLiScheduledDeparture even
hi link cifLiScheduledPass      odd
hi link cifLiPublicArrival      even
hi link cifLiPublicDeparture    odd
hi link cifLiPlatform           even
hi link cifLiLine               odd
hi link cifLiPath               even
hi link cifLiActivity           odd
hi link cifLiEngineeringAllowance   even
hi link cifLiPathingAllowance   odd
hi link cifLiPerformanceAllowance   even
hi link cifLiSpare              odd

" Changed En Route
syn match cifCrRecordIdentity   "^CR"       nextgroup=cifCrLocation
syn match cifCrLocation         ".\{8}"     contained nextgroup=cifCrTrainCategory
syn match cifCrTrainCategory    ".\{2}"     contained nextgroup=cifCrTrainIdentity
syn match cifCrTrainIdentity    ".\{4}"     contained nextgroup=cifCrHeadcode
syn match cifCrHeadcode         ".\{4}"     contained nextgroup=cifCrCourseIndicator
syn match cifCrCourseIndicator  "."         contained nextgroup=cifCrTrainServiceCode
syn match cifCrTrainServiceCode ".\{8}"     contained nextgroup=cifCrPortionId
syn match cifCrPortionId        "."         contained nextgroup=cifCrPowerType
syn match cifCrPowerType        ".\{3}"     contained nextgroup=cifCrTimingLoad
syn match cifCrTimingLoad       ".\{4}"     contained nextgroup=cifCrSpeed
syn match cifCrSpeed            ".\{3}"     contained nextgroup=cifCrOperatingCharacteristics
syn match cifCrOperatingCharacteristics ".\{6}" contained nextgroup=cifCrTrainClass
syn match cifCrTrainClass       "."         contained nextgroup=cifCrSleepers
syn match cifCrSleepers         "."         contained nextgroup=cifCrReservations
syn match cifCrReservations     "."         contained nextgroup=cifCrConnectionIndicator
syn match cifCrConnectionIndicator  "."     contained nextgroup=cifCrCateringCode
syn match cifCrCateringCode     ".\{4}"     contained nextgroup=cifCrServiceBranding
syn match cifCrServiceBranding  ".\{4}"     contained nextgroup=cifCrTractionClass
syn match cifCrTractionClass    ".\{4}"     contained nextgroup=cifCrUicCode
syn match cifCrUicCode          ".\{5}"     contained nextgroup=cifCrReservedFieldRsid
syn match cifCrReservedFieldRsid    ".\{8}" contained nextgroup=cifCrSpare
syn match cifCrSpare            ".\{5}"         contained

hi link cifCrRecordIdentity     odd
hi link cifCrLocation           even
hi link cifCrTrainCategory      odd
hi link cifCrTrainIdentity      even
hi link cifCrHeadcode           odd
hi link cifCrCourseIndicator    even
hi link cifCrTrainServiceCode   odd
hi link cifCrPortionId          even
hi link cifCrPowerType          odd
hi link cifCrTimingLoad         even
hi link cifCrSpeed              odd
hi link cifCrOperatingCharacteristics even
hi link cifCrTrainClass         odd
hi link cifCrSleepers           even
hi link cifCrReservations       odd
hi link cifCrConnectionIndicator even
hi link cifCrCateringCode       odd
hi link cifCrServiceBranding    even
hi link cifCrTractionClass      odd
hi link cifCrUicCode            even
hi link cifCrReservedFieldRsid  odd
hi link cifCrSpare              even

" Terminating Location
syn match cifLtRecordIdentity   "^LT"       nextgroup=cifLtLocation
syn match cifLtLocation         ".\{8}"     contained nextgroup=cifLtScheduledArrival
syn match cifLtScheduledArrival   ".\{5}" contained nextgroup=cifLtPublicArrival
syn match cifLtPublicArrival  ".\{4}"     contained nextgroup=cifLtPlatform
syn match cifLtPlatform         ".\{3}"     contained nextgroup=cifLtPath
syn match cifLtPath             ".\{3}"     contained nextgroup=cifLtActivity
syn match cifLtActivity         ".\{12}"    contained nextgroup=cifLtSpare
syn match cifLtSpare            ".\{43}"    contained

hi link cifLtRecordIdentity     ltOdd
hi link cifLtLocation           ltEven
hi link cifLtScheduledArrival   ltOdd
hi link cifLtPublicArrival      ltEven
hi link cifLtPlatform           ltOdd
hi link cifLtPath               ltEven
hi link cifLtActivity           ltOdd
hi link cifLtSpare              ltEven

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
