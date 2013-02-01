set nocompatible
filetype plugin indent off
if has('vim_starting')
  set runtimepath+=~/dotfiles/neobundle.vim/
  call neobundle#rc(expand('~/.vim/'))
endif
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'tomasr/molokai'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle "sudo.vim"
NeoBundle "vim-jp/vimdoc-ja"
NeoBundle "Shougo/vimshell"
NeoBundle "glidenote/memolist.vim"

set background=dark
colorscheme solarized
filetype plugin indent on
nmap <F9> :NERDTreeToggle
syntax on
filetype on
filetype plugin on
filetype indent on

map <Leader>mn :MemoNew<CR>
map <Leader>ml :MemoList<CR>
map <Leader>mg :MemoGrep<CR>
