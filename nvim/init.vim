set nocompatible
syntax enable
filetype plugin on

let mapleader = '`'
nnoremap <leader>ev :edit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
call plug#begin('~/Appdata/Local/nvim/plugs')
"Plug 'corbob/coc-pses', {'branch': 'getPsesByVersion', 'do': { -> coc#powershell#install(
"    \ {
"    \ 'flags': '-AllowPreRelease'
"    \}
"    \ )} }
Plug 'C:\Users\corbob\Repos\coc\coc-pses', {'do': { -> coc#powershell#install()} }
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'sheerun/vim-polyglot'
Plug 'flazz/vim-colorschemes'
Plug 'scrooloose/nerdtree'
Plug 'aaronbieber/vim-quicktask'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
call plug#end()

set hidden
set number
set signcolumn=yes
autocmd VimEnter * nnoremap <Esc> :nohlsearch<CR>
set termguicolors
colorscheme dracula
set cursorline
set cmdheight=2
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" :<SID>check_back_space() ? "\<TAB>" :coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

nnoremap L w
nnoremap H b
nnoremap J <C-f>
nnoremap K <C-b>

function! VimrcGetHelp()
    let currentWord = expand("<cword>")
    execute "help ".currentWord
endfunction

autocmd FileType vim nnoremap <buffer> <S-K> :call VimrcGetHelp()<CR>
autocmd FileType help nnoremap <buffer> q :q<CR>

function! VsimProgrammerMode()
    set updatetime=300
    set signcolumn=yes
    autocmd! CursorHold  * silent call CocActionAsync('highlight')
    autocmd! CursorHoldI * silent call CocActionAsync('showSignatureHelp')
    autocmd! User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

    setl formatexpr=CocAction('formmatSelection')
    vmap <buffer> <C-e><C-d> <Plug>(coc-format-selected)
    imap <buffer> <C-e><C-d> <Plug>(coc-format-selected)
    nmap <buffer> <C-e><C-d> :call CocAction('format')<CR>

    nmap <buffer> <C-.>      <Plug>(coc-codeaction)
    vmap <buffer> <C-.>      <Plug>(coc-codeaction-selected)
    nmap <buffer> <F3>       <Plug>(coc-codeaction)
    vmap <buffer> <F3>       <Plug>(coc-codeaction-selected)

    nmap <silent> <buffer> <S-K>      :call CocActionAsync('doHover')<CR>
    nmap <silent> <buffer> <F1>       :call CocActionAsync('doHover')<CR>

    nmap <buffer> <F2>                <Plug>(coc-rename)
    nmap <silent> <buffer> <F12>      <Plug>(coc-definition)
    nmap <silent> <buffer> <C-]>      <Plug>(coc-definition)
    nmap <silent> <buffer> <C-k><C-r> <Plug>(coc-references)

    nmap <silent> <buffer> gd         <Plug>(coc-definition)
    nmap <silent> <buffer> gy         <Plug>(coc-type-definition)
    nmap <silent> <buffer> gi         <Plug>(coc-implementation)
    nmap <silent> <buffer> gr         <Plug>(coc-references)
endfunction

autocmd FileType ps1 call VsimProgrammerMode()

function! PS1OutputHandle(output) abort
    let g:output = a:output
    echomsg json_encode(a:output)
endfunction


function! PS1ExecuteLine() abort
    let g:ps1Line = getline('.')
    echo g:ps1Line
endfunction


map <F4> :NERDTreeToggle<CR>
map <F5> :NERDTreeRefreshRoot<CR>

map <C-S-Tab> :bp<CR>
map <C-Tab> :bn<CR>

set clipboard=unnamedplus

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set relativenumber
