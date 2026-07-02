"autocmd FileType c,cpp setlocal cinoptions=(s,:0,l1,g0,t0,N-s,E-s
autocmd BufRead,BufNewFile *.S,*.s,*.asm setlocal filetype=asm
autocmd BufRead,BufNewFile *.hex,*.ihx setlocal filetype=hex

set nocompatible nosmartindent autoindent noincsearch nostartofline title ruler modeline modelines=6 laststatus=0 belloff=all
set fileencodings=utf-8,latin-1,chinese,gbk,gb2312,gb18030 encoding=utf-8 langmenu=none
set number 
set expandtab tabstop=4 softtabstop=4 shiftwidth=4
" highlight the  cursor line
set cursorline
set jumpoptions=stack

set clipboard=unnamed

" Searching options
set hlsearch
exec "nohlsearch"
set incsearch
set ignorecase
set smartcase

language C

filetype plugin on

"" The "syntax on" command have to be before the "highlight ..." commands to make highlight working.
syntax on

highlight Statement cterm=bold
highlight Comment cterm=bold

" paste in the insert mode
inoremap <c-v> <c-r>"

nnoremap <c-d> <c-d>zz
nnoremap <c-u> <c-u>zz
nnoremap } }zz
nnoremap { {zz
" Search word under cursor
nnoremap gw *N
" Start of the line
nnoremap 0 ^
vnoremap 0 ^
" End of the line
nnoremap ) $
vnoremap ) $

" better ctrl-c when use visul vertical mod to add some text
inoremap <c-c> <esc>

" windows
" special: [ctrl-w_o] close all windows but this one
" USE [ctrl-w-T] to move split_window to the new tab_windows
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k

" buffers
nnoremap <S-h> :bprevious<cr> 
nnoremap <S-l> :bnext<cr>
"close current buffer" 
nnoremap <space>bd :bd %<cr>
" switch buffers
nnoremap <space>, :buffers<cr>:b<space>
" buffer only
function! CloseOtherBuffers()
    let current = bufnr('%')
    for buf in range(1, bufnr('$'))
        if buf != current && buflisted(buf)
            execute 'bdelete '.buf
        endif
    endfor
endfunction
nnoremap <space>bo :call CloseOtherBuffers()<cr>

" save file
nnoremap <c-s> :w<cr>

" better indenting
vmap < <gv
vmap > >gv

nnoremap <space><cr> :nohl<cr>

" use <c-d> to quit terminal
nnoremap <space>w :set splitbelow<cr>:terminal<cr>
tnoremap <c-q> <C-\><C-n>:q!<cr><esc>
