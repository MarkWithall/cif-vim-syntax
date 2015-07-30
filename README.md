CIF Syntax File For vim/gvim
==============

A vim/gvim syntax highlighting for CIF timetable files.

![](CIFVimSyntax.png)

To install it:

* Copy the .vim file to `$HOME/.vim/syntax` (on unix-like systems) or `$HOME\vimfiles\syntax` on Windows
* Add the line `autocmd BufRead,BufNewFile *.cif setfiletype cif` to `$MYVIMRC`

For further information on the CIF file format, see [ATOC's spec](http://www.atoc.org/clientfiles/File/RSPS5004%20v27.pdf).

Thanks to [Tracsis plc](http://www.tracsis.com/) for allowing me to share this with you.

