function! CifFolds()
    let record_type = getline(v:lnum)[0:1]
    if record_type ==# 'BS'
        return ">1"
    endif

    if record_type[0] ==# 'T' || record_type ==# 'AA'
        let previous_record_type=getline(v:lnum-1)[0:1]
        if previous_record_type !=# record_type
            return ">1"
        endif
    endif

    if record_type ==# 'HD' || record_type ==# 'ZZ'
        return "0"
    endif

    return "="
endfunction

function! CifFoldText()
    let lines=(v:foldend-v:foldstart)+1
    let record_type=getline(v:foldstart)[0:1]
    if record_type ==# 'BS'
        let line=getline(v:foldstart)
        return line[32:35] . ' (' . lines . ' lines) ' . line
    elseif record_type ==# 'TI'
        return 'TIPLOC Inserts (' . lines . ' lines)'
    elseif record_type ==# 'TA'
        return 'TIPLOC Ammends (' . lines . ' lines)'
    elseif record_type ==# 'TD'
        return 'TIPLOC Deletes (' . lines . ' lines)'
    elseif record_type ==# 'AA'
        return 'Associations (' . lines . ' lines)'
    else
        return record_type . ' (' . lines . ' lines)'
    endif
endfunction

setlocal foldmethod=expr
setlocal foldexpr=CifFolds()
setlocal foldtext=CifFoldText()
setlocal foldlevel=999
