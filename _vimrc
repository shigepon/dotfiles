set nocompatible
set encoding=utf-8
" release autogroup in MyAutoCmd
augroup MyAutoCmd
    autocmd!
augroup END
" noremap \ ,
" Search setting
set ignorecase
set smartcase
set incsearch
set hlsearch
set fileencodings=utf-8,euc-jp,sjis,cp932,iso-2022-jp

" バックスラッシュやクエスチョンを状況に合わせて自動エスケープ
" cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
" cnoremap <expr> / getcmdtype() == '?' ? '\?' : '?'

" Editor setting
" シフト時の文字数自動調整 on
set shiftround
set infercase

set virtualedit=all "字が存在しない部分にもカーソルを移動させることができる
set hidden " TextEdit might fail if hidden is not set.
set switchbuf=useopen " バッファ切り替え動作（指定されたバッファがあれば移動）
set showmatch " カッコを入力した時に一瞬とじカッコに移動
set matchtime=3 " showmatchは0.3秒で戻る
set tabstop=4 " 4個のスペースでtabとカウント
set shiftwidth=4 " シフトのスペース数
set softtabstop=4 " タブのスペース数
set expandtab " タブを常にスペースにしておきたい場合に指定
set matchpairs& matchpairs+=<:> " 対応括弧に<>を追加
" Swap, Backupファイルを無効
" Some servers have issues with backup files, see #649.
set nowritebackup
set nobackup
set noswapfile

set cmdheight=2 " Give more space for displaying messages.

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" View setting
set list                " 不可視文字の可視化
set number              " 行番号の表示
set wrap                " 長いテキストの折り返し
set textwidth=0         " 自動的に改行が入るのを無効化
set colorcolumn=80      " その代わり80文字目にラインを入れる

" 前時代的スクリーンベルを無効化 beepが鳴らなくなる
set t_vb=
set novisualbell

set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲ " デフォルト不可視文字は美しくないのでUnicodeで綺麗に

" Macro setting
" 入力モード中に素早くeeと入力した場合はESCとみなす
inoremap ee <Esc>

" ESCを二回押すことで検索時ハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>

" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>
" 検索後にジャンプした際に検索単語を画面中央に持ってくる nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

filetype plugin indent off
" カーソル移動
nnoremap j gj
nnoremap k gk

" vを二回で行末まで選択
vnoremap v $h

" TABにて対応ペアにジャンプ
nnoremap <Tab> %
vnoremap <Tab> %

" Ctrl + hjkl でウィンドウ間を移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>

" T + ? で各種設定をトグル
nnoremap [toggle] <Nop>
nmap T [toggle]
nnoremap <silent> [toggle]s :setl spell!<CR>:setl spell?<CR>
nnoremap <silent> [toggle]l :setl list!<CR>:setl list?<CR>
nnoremap <silent> [toggle]t :setl expandtab!<CR>:setl expandtab?<CR>
nnoremap <silent> [toggle]w :setl wrap!<CR>:setl wrap?<CR>


autocmd MyAutoCmd QuickfixCmdPost make,grep,grepadd,vimgrep copen " make, grep などのコマンド後に自動的にQuickFixを開く

" QuickFixおよびHelpでは q でバッファを閉じる
autocmd MyAutoCmd FileType help,qf nnoremap <buffer> q <C-w>c

" w!! でスーパーユーザーとして保存（sudoが使える環境限定）
cmap w!! w !sudo tee > /dev/null %

"autocmd MyAutoCmd BufWritePre * call s:mkdir(expand('<afile>:p:h'), v:cmdbang)

" ~/.vimrc.localが存在する場合のみ設定を読み込む
let s:local_vimrc = expand('~/.vimrc.local')
if filereadable(s:local_vimrc)
    execute 'source ' . s:local_vimrc
endif

" coc.nvim設定読み込み
syntax on
"if has('vim_starting')
let s:coc_vimrc = expand('~/.vimrc.coc.nvim')
if filereadable(s:coc_vimrc)
    execute 'source ' . s:coc_vimrc
endif
"endif
"if has('vim_starting')
"  set runtimepath+=~/dotfiles/neobundle.vim/
"  call neobundle#rc(expand('~/.vim/'))
"endif
"function! s:meet_neocomplete_requirements()
"    return has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
"endfunction

"NeoBundle 'Shougo/neobundle.vim'
"if s:meet_neocomplete_requirements()
"    NeoBundle 'Shougo/neocomplete'
"    NeoBundleFetch 'Shougo/neocomplcache'
"else
"    NeoBundleFetch 'Shougo/neocomplete'
"    NeoBundle 'Shougo/neocomplcache'
"endif
""NeoBundle 'Shougo/neosnippet'
""NeoBundle 'Shougo/neosnippet-snippets'
"NeoBundle 'chrisbra/Colorizer'
"NeoBundle 'Shougo/unite.vim'
"NeoBundle 'Shougo/vimshell'
"NeoBundle 'Lokaltog/vim-powerline'
""NeoBundle 'scrooloose/syntastic'
"NeoBundle 'scrooloose/nerdtree'
""NeoBundle 'tomasr/molokai'
"NeoBundle 'jonathanfilip/vim-lucius'
"colorscheme lucius
"NeoBundle 'sudo.vim'
"NeoBundle 'vim-jp/vimdoc-ja'
""NeoBundle 'vim-scripts/YankRing.vim'
"NeoBundle 'glidenote/memolist.vim'
"NeoBundle 'mattn/zencoding-vim'
"NeoBundle 'myusuf3/numbers.vim'
"NeoBundle 'nathanaelkane/vim-indent-guides'
"NeoBundle 'tpope/vim-surround'
"NeoBundle 'Shougo/vimproc',{
"    \ "build": {
"    \ "unix": "make -f make_unix.mak",
"    \}}
"NeoBundleLazy "vim-scripts/TaskList.vim", {
"      \ "autoload": {
"      \   "mappings": ['<Plug>TaskList'],
"      \}}
"nmap <Leader>T <plug>TaskList
"NeoBundle 'majutsushi/tagbar'
"nmap <Leader>t :TagbarToggle<CR>
"" Djangoを正しくVimで読み込めるようにする
"NeoBundleLazy "lambdalisue/vim-django-support", {
"      \ "autoload": {
"      \   "filetypes": ["python", "python3", "djangohtml"]
"      \ }}
"" Vimで正しくvirtualenvを処理できるようにする
"NeoBundleLazy "jmcantrell/vim-virtualenv", {
"      \ "autoload": {
"      \   "filetypes": ["python", "python3", "djangohtml"]
"      \ }}
"
" ファイルタイププラグインおよびインデントを有効化
" これはNeoBundleによる処理が終了したあとに呼ばなければならない
"filetype plugin indent on
"
"let s:hooks = neobundle#get_hooks("vim-indent-guides")
"function! s:hooks.on_source(bundle)
"  let g:indent_guides_guide_size = 1
"  IndentGuidesEnable
"endfunction
"
"set background=light
"hi Comment ctermfg=105
"hi Number          ctermfg=221
"hi Label          ctermfg=153
"nmap <F9> :NERDTreeToggle
"filetype on
"filetype plugin on
"filetype indent on
"
"
"if s:meet_neocomplete_requirements()
"    let g:neocomplcache_enable_at_startup = 1
"    let g:neocomplcache_max_list = 10
"    let g:neocomplcache_enable_smart_case = 1
"    let g:neocomplcache_enable_underbar_completion = 1
"    let g:neocomplcache_enable_camel_case_completion = 1
"else
"    let g:neocomplete#enable_at_startup = 1
"endif
"inoremap <expr><Tab> pumvisible() ? "\<Down>" : "\<Tab>"
"inoremap <expr><S-Tab> pumvisible() ? "\<Up>" : "\<S-Tab>"
"
"set tags+=~/.tags
"let g:neocomplcache_ctags_arguments_list = {
"\ 'php' : '-R --languages=PHP --langmap=PHP:.php.inc --php-types=c+f+d'
"\ }
"let g:neocomplcache_delimiter_patterns = {
"\ 'php' : ['->', '::', '\']
"\ }
"
"" Database setting
""let dbext_default_profile=''
""let dbext_default_type='PGSQL'
""let dbext_default_user='shigepon'
""let dbext_default_dbname='law'
""let dbext_default_host='49.212.176.75'
""let dbext_default_port='5432'
""let dbext_default_passwd='bmmr6111'
"
"" " For snippet_complete marker.
"if has('conceal')
"  set conceallevel=2 concealcursor=i
"endif
"
"function! s:remove_dust()
"    let cursor = getpos('.')
"" 保存時に行末の空白を除去
"    %s/\s\+$//ge
"" 保存時にタブを4スペースに変換
"    %s/\t/    /ge
"    call setpos('.', cursor)
"    unlet cursor
"endfunction
"nnoremap <C-t><C-t> :<C-u>call <SID>remove_dust()<CR>
""autocmd MyAutoCmd BufWritePre * call <SID>remove_dust()
"autocmd BufNewFile,BufRead *.nako set filetype=nako
"autocmd BufNewFile,BufRead *.json set filetype=json
"set maxmempattern=10000
"NeoBundleCheck
"autocmd BufNewFile,BufRead * highlight Comment ctermfg=22
"autocmd BufNewFile,BufRead * highlight Label ctermfg=22
"autocmd BufNewFile,BufRead * highlight Number cterm=bold ctermfg=30
"command! -nargs=? Jq call s:Jq(<f-args>)
"function! s:Jq(...)
"    if 0 == a:0
"        let l:arg = "."
"    else
"        let l:arg = a:1
"    endif
"    execute "%! jq \"" . l:arg . "\""
"endfunction
"vnoremap <leader>en :!python -c 'import sys,urllib;print urllib.quote(sys.stdin.read().strip())'<cr>
"vnoremap <leader>de :!python -c 'import sys,urllib;print urllib.unquote(sys.stdin.read().strip())'<cr>
"nnoremap ee :%s/\\u\([0-9a-f]\{4}\)/\=nr2char(eval("0x".submatch(1)),1)/g
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
"function! s:check_back_space() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~# '\s'
"endfunction
"
"" Use <c-space> to trigger completion.
"if has('nvim')
"  inoremap <silent><expr> <c-space> coc#refresh()
"else
"  inoremap <silent><expr> <c-@> coc#refresh()
"endif
"
"" Make <CR> auto-select the first completion item and notify coc.nvim to
"" format on enter, <cr> could be remapped by other vim plugin
"inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"
"" Use `[g` and `]g` to navigate diagnostics
"" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
"nmap <silent> [g <Plug>(coc-diagnostic-prev)
"nmap <silent> ]g <Plug>(coc-diagnostic-next)
"
"" GoTo code navigation.
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)
"
"" Use K to show documentation in preview window.
"nnoremap <silent> K :call <SID>show_documentation()<CR>
"
"function! s:show_documentation()
"  if (index(['vim','help'], &filetype) >= 0)
"    execute 'h '.expand('<cword>')
"  elseif (coc#rpc#ready())
"    call CocActionAsync('doHover')
"  else
"    execute '!' . &keywordprg . " " . expand('<cword>')
"  endif
"endfunction
"
"" Highlight the symbol and its references when holding the cursor.
"autocmd CursorHold * silent call CocActionAsync('highlight')
"
"" Symbol renaming.
"nmap <leader>rn <Plug>(coc-rename)
"
"" Formatting selected code.
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)
"
"augroup mygroup
"  autocmd!
"  " Setup formatexpr specified filetype(s).
"  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"  " Update signature help on jump placeholder.
"  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
"augroup end
"
"" Applying codeAction to the selected region.
"" Example: `<leader>aap` for current paragraph
"xmap <leader>a  <Plug>(coc-codeaction-selected)
"nmap <leader>a  <Plug>(coc-codeaction-selected)
"
"" Remap keys for applying codeAction to the current buffer.
"nmap <leader>ac  <Plug>(coc-codeaction)
"" Apply AutoFix to problem on the current line.
"nmap <leader>qf  <Plug>(coc-fix-current)
"
"" Map function and class text objects
"" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
"xmap if <Plug>(coc-funcobj-i)
"omap if <Plug>(coc-funcobj-i)
"xmap af <Plug>(coc-funcobj-a)
"omap af <Plug>(coc-funcobj-a)
"xmap ic <Plug>(coc-classobj-i)
"omap ic <Plug>(coc-classobj-i)
"xmap ac <Plug>(coc-classobj-a)
"omap ac <Plug>(coc-classobj-a)
"
"" Remap <C-f> and <C-b> for scroll float windows/popups.
"if has('nvim-0.4.0') || has('patch-8.2.0750')
"  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
"  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"endif
"
"" Use CTRL-S for selections ranges.
"" Requires 'textDocument/selectionRange' support of language server.
"nmap <silent> <C-s> <Plug>(coc-range-select)
"xmap <silent> <C-s> <Plug>(coc-range-select)
"
"" Add `:Format` command to format current buffer.
"command! -nargs=0 Format :call CocAction('format')
"
"" Add `:Fold` command to fold current buffer.
"command! -nargs=? Fold :call     CocAction('fold', <f-args>)
"
"" Add `:OR` command for organize imports of the current buffer.
"command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
"
"" Add (Neo)Vim's native statusline support.
"" NOTE: Please see `:h coc-status` for integrations with external plugins that
"" provide custom statusline: lightline.vim, vim-airline.
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"
"" Mappings for CoCList
"" Show all diagnostics.
"nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
"" Manage extensions.
"nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
"" Show commands.
"nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
"" Find symbol of current document.
"nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
"" Search workspace symbols.
"nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
"" Do default action for next item.
"nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
"" Do default action for previous item.
"nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
"" Resume latest coc list.
"nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
