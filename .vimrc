set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

"if has("vms")
"  set nobackup		" do not keep a backup file, use versions instead
"else
"  set backup		" keep a backup file
"endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
"map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")
" private setting
colorscheme zellner
"set backupdir=$HOME/.vim/backupdir
set tabstop=4
set shiftwidth=4
set backspace=2
set cindent
set smartindent
set number
set expandtab
"set toolbar=icons,tooltips,text
set title
set showcmd
set wildmenu
set hlsearch
set wrapscan
set laststatus=2
set statusline=%F%m%r%h%w\%=[TYPE=%Y]\[FORMAT=%{&ff}]\[ENC=%{&fileencoding}]\[LOW=%l/%L]
"set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
"ab #i #include <>
"ab in int main(void) {
"ab pr printf("", );
"ab st static void
set encoding=utf-8
set fileencoding=utf-8
set fileencodings+=iso-2022-jp,utf-8,cp932
"set fileformat=unix
source $VIMRUNTIME/mswin.vim
"set clipboard=unnamed

let g:Perl_AuthorName      = 'Kanaderu Fukuda'
let g:Perl_AuthorRef       = 'Mn'
let g:Perl_Email           = 'kafukuda@yahoo-corp.jp'
let g:Perl_Company         = 'Yahoo Japan Corporation'

function! InsertTabWrapper()
		let col = col('.') - 1
		if !col || getline('.')[col - 1] !~ '\k'
			return "\<TAB>"
		else
			if pumvisible()
				return "\<C-N>"
			else
				return "\<C-N>\<C-P>"
			end
		endif
endfunction

"inoremap <tab> <c-r>=InsertTabWrapper()<cr>
autocmd FileType * let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i'
autocmd FileType perl let g:AutoComplPop_CompleteOption = '.,w,b,u,t,k~/.vim/dict/perl.dict'
autocmd FileType ruby let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k~/.vim/dict/ruby.dict'
autocmd FileType javascript let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k~/.vim/dict/javascript.dict'
autocmd FileType erlang let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k~/.vim/dict/erlang.dict'
"autocmd FileType perl :set dictionary+=~/.vim/dict/perl.dict
let g:AutoComplPop_IgnoreCaseOption = 1

set complete+=k;
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

cmap     <C-v> <C-v>
inoremap <C-v> <C-v>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Del>
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
inoremap <C-n> <BS>
inoremap <C-f> <ESC>
"nnoremap <silent> <C-x>1 :only<CR>
"nnoremap <silent> <C-x>2 :sp<CR>
"nnoremap <silent> <C-x>3 :vsp<CR>
