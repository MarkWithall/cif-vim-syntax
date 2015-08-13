function! RecordType(linenum)
    if a:linenum < 0
        return ''
    endif
    return getline(a:linenum)[0:1]
endfunction

function! CifFolds()
    let previous_record_type=RecordType(v:lnum-1)
    let record_type = RecordType(v:lnum)
    if record_type == 'BS'
        return ">1"
    elseif record_type == 'TI' && previous_record_type != 'TI'
        return ">1"
    elseif record_type == 'TA' && previous_record_type != 'TA'
        return ">1"
    elseif record_type == 'TD' && previous_record_type != 'TD'
        return ">1"
    elseif record_type == 'AA' && previous_record_type != 'AA'
        return ">1"
    elseif record_type == 'ZZ'
        return "0"
    endif
    return "="
endfunction

function! CifFoldText()
    let lines=(v:foldend-v:foldstart)+1
    let record_type=RecordType(v:foldstart)
    if record_type == 'BS'
        let line=getline(v:foldstart)
        return line[32:35] . ' (' . lines . ' lines) ' . line
    elseif record_type == 'TI'
        return 'TIPLOC Inserts (' . lines . ' lines)'
    elseif record_type == 'TA'
        return 'TIPLOC Ammends (' . lines . ' lines)'
    elseif record_type == 'TD'
        return 'TIPLOC Deletes (' . lines . ' lines)'
    elseif record_type == 'AA'
        return 'Associations (' . lines . ' lines)'
    else
        return record_type . ' (' . lines . ' lines)'
    endif
endfunction

setlocal foldmethod=expr
setlocal foldexpr=CifFolds()
setlocal foldtext=CifFoldText()
setlocal foldlevel=999

