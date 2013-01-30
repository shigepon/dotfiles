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
NeoBundle "sudo.vim"
NeoBundle "vim-jp/vimdoc-ja"

filetype plugin indent on
nmap <F9> :NERDTreeToggle
colorscheme molokai
