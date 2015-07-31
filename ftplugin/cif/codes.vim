if exists("b:did_cifhelpers_ftplugin")
    finish
endif
let b:did_cifhelpers_ftplugin = 1

map <buffer> <leader>ca :call ShowActivityCodes()<cr>

function! ShowActivityCodes()
    let line=getline('.')
    let record_identity=line[0:1]
    if record_identity == 'LO'
        call ShowCodes(line[29:40])
    elseif record_identity == 'LI'
        call ShowCodes(line[42:53])
    elseif record_identity == 'LT'
        call ShowCodes(line[25:36])
    endif
endfunction

function! ShowCodes(codes)
    let activities = {
        \ 'A ': 'Stops or shunts for other trains to pass',
        \ 'AE': 'Attach/detach assisting locomotive',
        \ 'BL': 'Stops for banking locomotive',
        \ 'C ': 'Stops to change trainmen',
        \ 'D ': 'Stops to set down passengers',
        \ '-D': 'Stops to detach vehicles',
        \ 'E ': 'Stops for examination',
        \ 'G ': 'National Rail Timetable data to add',
        \ 'H ': 'Notional activity to prevent WTT timing columns merge',
        \ 'HH': 'As H, where a third column is involved',
        \ 'K ': 'Passenger count point',
        \ 'KC': 'Ticket collection and examination point',
        \ 'KE': 'Ticket examination point',
        \ 'KF': 'Ticket Examination Point, 1st Class only',
        \ 'KS': 'Selective Ticket Examination Point',
        \ 'L ': 'Stops to change locomotives',
        \ 'N ': 'Stop not advertised',
        \ 'OP': 'Stops for other operating reasons',
        \ 'OR': 'Train Locomotive on rear',
        \ 'PR': 'Propelling between points shown',
        \ 'R ': 'Stops when required',
        \ 'RM': 'Reversing movement, or driver changes ends',
        \ 'RR': 'Stops for locomotive to run round train',
        \ 'S ': 'Stops for railway personnel only',
        \ 'T ': 'Stops to take up and set down passengers',
        \ '-T': 'Stops to attach and detach vehicles',
        \ 'TB': 'Train begins (Origin)',
        \ 'TF': 'Train finishes (Destination)',
        \ 'TS': 'Detail Consist for TOPS Direct requested by EWS',
        \ 'TW': 'Stops (or at pass) for tablet, staff or token.',
        \ 'U ': 'Stops to take up passengers',
        \ '-U': 'Stops to attach vehicles',
        \ 'W ': 'Stops for watering of coaches',
        \ 'X ': 'Passes another train at crossing point on single line',
        \ '* ': 'Suppress T'
    \ }
    for code in [a:codes[0:1], a:codes[2:3], a:codes[4:5], a:codes[6:7], a:codes[8:9], a:codes[10:11]]
        if code != '  '
            if has_key(activities, code)
                echo code . ':' . activities[code]
            else
                echo code . ':' . 'UKNOWN'
            endif
        endif
    endfor
endfunction

