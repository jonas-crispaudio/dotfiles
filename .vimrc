"""""""""""""""""""""""""""""""""""""""""""""""""
"                     Setup                     "
"                                               "
"""""""""""""""""""""""""""""""""""""""""""""""""
" Change LEADER character to comma
let mapleader = ","
filetype plugin on



 """""""""""""""""""""""""""""""""""""""""""""""""
 "                   Displaying                  "
 "                                               "
 """""""""""""""""""""""""""""""""""""""""""""""""
"  Set font and size
if has("gui_running")
    if has("gui_gtk2")
        set guifont=Inconsolata\ 12
    elseif has("gui_macvim")
        set guifont=Menlo\ Regular:h14
    elseif has("gui_win32")
        set guifont=Consolas:h11:cANSI
    endif
endif

"  Automatic dark themed syntax for the file
set background=dark
syntax on
colorscheme gruvbox

" Enable hybrid line numbers
set number relativenumber

" Toggle between line number modes
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set number relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END



""""""""""""""""""""""""""""""""""""""""""""""""""
"                     Search                     "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable search highlighting
set hlsearch

" Ignore case when searching
set ignorecase

" Incremental search that shows partial matches
set incsearch

" Automatically switch to case-sensitive when search contains uppercase
" letter
set smartcase



""""""""""""""""""""""""""""""""""""""""""""""""""
"                     Indent                     "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""
" Tab settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab



"""""""""""""""""""""""""""""""""""""""""""""""""
"                Key Bindings                   "
"                                               "
"""""""""""""""""""""""""""""""""""""""""""""""""
" Keys for wrapping text in quotes and other stuff
nmap <leader>s' ciw'<C-r>"'<esc>
nmap <leader>s" ciw"<C-r>""<esc>
nmap <leader>s{ ciw{<C-r>"}<esc>
nmap <leader>s( ciw(<C-r>")<esc>
nmap <leader>s[ ciw[<C-r>"]<esc>
nmap n nzz
nmap N Nzz
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l




""""""""""""""""""""""""""""""""""""""""""""""""""
"                      Other                     "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""
" Automatically source vimrc on save
augroup reload_vimrc
    autocmd!
        autocmd BufWritePost vimrc source ~/.vimrc
            " autocmd BufWritePost vimrc AirlineRefresh
            augroup END

" Remember last cursor position
set viminfo='20,\"500   " Keep a .viminfo file.
              
" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
    \ if ! exists("g:leave_my_cursor_position_alone") |
    \   if line("'\"") > 0 && line ("'\"") <= line("$") |
    \       exe "normal g'\"" |
    \   endif |
    \ endif

" No sound when reaching the end
set noerrorbells

" Restore cursor position on buffer navigation
if v:version >= 700
  au BufLeave * let b:winview = winsaveview()
  au BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif
endif

" Use system clipboard
if has('win32')
    set clipboard=unnamed
else
    set clipboard=unnamedplus
endif

" Backspace over indentation, line breaks and insertion start
set backspace=indent,eol,start

" Disable swap files
set noswapfile

" Allow unsafed buffer swap
set hidden

" Enable spellchecking
set spell

" Increase undo limit
set history=500



""""""""""""""""""""""""""""""""
"            Plugins           "
"                              "
""""""""""""""""""""""""""""""""
" Installs for vim >= 8: plugins into ~/.vim/pack/vendor/start
" (gvim: ~/vimfiles/pack/vendor/start)
" fzf.vim and fzf (both in pack/vendor/start)
" (ripgrep system install for fzf :Rg)
" lightline.vim
" nerdcommenter
" a.vim into .vim/plugin/ or vimfiles/plugin/
" better c/cpp syntax https://github.com/bfrg/vim-cpp-modern
" vim-gitbranch
" gruvbox
" vim-tmux-navigator (use Ctl-hjkl to navigate splits/windows, key bindings in
" vimrc)

 " Statusline configuration. Using lightline
 set laststatus=2
 set noshowmode

 let g:lightline = {
       \ 'active': {
       \   'left': [ [ 'mode', 'paste' ],
       \                   [ 'gitbranch', 'readonly', 'absolutepath', 'modified' ] ]
       \ },
       \ 'component_function': {
       \    'gitbranch': 'gitbranch#name'
       \ },
       \ }

" Remember marks
set viminfo='100,f1

" ripgrep 
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

let projectPath = '~/winhome/Desktop/workspace'
command! -bang ProjectFiles call fzf#vim#files(projectPath, <bang>0)

" fzf.vim
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <C-p> :ProjectFiles<CR>
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <silent> <Leader>b/ :BLines<CR>
nnoremap <silent> <Leader>/ :Lines<CR>
nnoremap <silent> <Leader>' :Marks<CR>
nnoremap <silent> <Leader>g :Commits<CR>
nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR> 

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Word completion with custom spec with popup layout option
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'window': { 'width': 0.2, 'height': 0.9, 'xoffset': 1 }})
