function! CifFolds()
    if getline(v:lnum)[0:1] == 'BS'
        return ">1"
    endif
    return "="
endfunction

function! CifFoldText()
    let line=getline(v:foldstart)
    let lines=(v:foldend-v:foldstart)+1
    return line[32:35] . ' (' . lines . ' lines) ' . line
endfunction

setlocal foldmethod=expr
setlocal foldexpr=CifFolds()
setlocal foldtext=CifFoldText()
setlocal foldlevel=999

