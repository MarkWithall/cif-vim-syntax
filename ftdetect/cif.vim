if has("autocmd")
    autocmd BufRead,BufNewFile *.cif setfiletype cif
    if did_filetype()
        finish
    endif
    autocmd BufRead,BufNewFile *
        \ if getline(1) =~ '^HD' |
        \    setfiletype cif |
        \ endif
endif

