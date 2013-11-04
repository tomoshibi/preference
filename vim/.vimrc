" .vimrc

" ----------------------------------------
" 共通設定
" ----------------------------------------
"OS判定 
let ostype='Other'
if has('win32') || has('win64')
	let ostype = 'win'
elseif has('mac')
	let ostype = 'mac'
elseif has('unix')
	let ostype = 'unix'
endif
"日本語設定
set encoding=utf-8
set fileencodings=utf-8
"バックアップファイルを作るディレクトリ
"set backupdir=$HOME/vimbackup
"ファイル保存ダイアログの初期ディレクトリをバッファファイル位置に設定
set browsedir=buffer 
"Vi互換をオフ
set nocompatible
"スワップファイル用のディレクトリ
"set directory=$HOME/vimbackup
"変更中のファイルでも、保存しないで他のファイルを表示
set hidden
" Swapファイル、Backupファイル、全て無効化
set nowritebackup
set nobackup
set noswapfile

" ----------------------------------------
" 表示設定
" ----------------------------------------
"カラー設定
"colorscheme my_jellybeans
"シンタックス
syntax on
" 常にステータス行を表示 (詳細は:he laststatus)
set laststatus=2
" ステータスライン表示項目
"set statusline=%F%m%r%h%w\%=[TYPE=%Y]\[FORMAT=%{&ff}]\[ENC=%{&fileencoding}]\[LOW=%l/%L]
" 行番号を表示
set number
" ルーラーを表示 (noruler:非表示)
set ruler
" タブや改行を表示
set list
" どの文字でタブや改行を表示するかを設定
"set listchars=tab:^\ ,extends:<,trail:-,eol:¬
set listchars=tab:^\ ,extends:<,trail:-,eol:￬
"ファイル内の <Tab> が対応する空白の数
set tabstop=4
" 256色に設定
set t_Co=256
" カーソル行をハイライト
"set cursorline
" 全角記号（■等が重なる問題の対応）
set ambiwidth=double
" 行の折り返しOFF
set nowrap

" ----------------------------------------
" 編集設定
" ----------------------------------------
"ノーマルモードで改行を挿入
"noremap <CR> i<CR><ESC>
"新しい行のインデントを現在行と同じにする
set autoindent
"クリップボードをOSと連携
"set clipboard=unnamed
"set clipboard+=unnamedplus,unnamed
set clipboard=unnamedplus
"閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch
"新しい行を作成ときに高度な自動インデントを行う
set smartindent
"タブの代わりに空白文字を挿入する
"set expandtab
"行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab
" バックスペースでなんでも消せるようにする
set backspace=indent,eol,start
" 整形オプション，マルチバイト系を追加
set formatoptions=lmoq

" ----------------------------------------
" 移動設定
" ----------------------------------------
"カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
"シフト移動幅
set shiftwidth=4

" ----------------------------------------
" 検索設定
" ----------------------------------------
"大文字小文字を区別しない
set ignorecase
"検索時に大文字を含んでいたら大/小を区別
set smartcase
"インクリメンタルサーチを行う
set incsearch
"検索をファイルの先頭へループしない
set nowrapscan
"検索結果をハイライト
set hlsearch

" ----------------------------------------
" コマンド設定
" ----------------------------------------
" コマンド補完を強化
set wildmenu
" リスト表示，最長マッチ
set wildmode=list:full
" コマンド行数設定
set cmdheight=2

" ----------------------------------------
" ヘルプ設定
" ----------------------------------------
if ostype=='unix'
	helptags ~/.vim/vimdoc-ja/doc
endif
set helplang=ja,en

" ----------------------------------------
" プラグイン設定
" ----------------------------------------
" ---------- NeoBundle ----------
set nocompatible
filetype off

if has('vim_starting')
	if ostype=='win'
		set runtimepath+=~/vimfiles/bundle/neobundle.vim
		call neobundle#rc(expand('~/vimfiles/bundle'))
	else
		set runtimepath+=~/.vim/bundle/neobundle.vim
		call neobundle#rc(expand('~/.vim/bundle'))
	endif
endif

" ここにインストールしたいプラグインのリストを書く
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'YankRing.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'Shougo/vimproc', {
\ 'build' : {
\ 'windows' : 'make -f make_mingw32.mak',
\ 'cygwin' : 'make -f make_cygwin.mak',
\ 'mac' : 'make -f make_mac.mak',
\ 'unix' : 'make -f make_unix.mak',
\ },
\ }

filetype plugin on
filetype indent on

" --------- lightline ----------
let g:lightline = {
\'colorscheme': 'jellybeans',
\ 'component': {
\   'readonly': '%{&readonly?"ReadOnly":""}',
\ },
\ 'separator': { 'left': '', 'right': '' },
\ 'subseparator': { 'left': '|', 'right': '|' },
\'active': {
\'left': [ ['mode', 'paste'], [ 'filename', 'readonly','modified'] ]
\}
\}

" --------- neocomplete ----------
if has('lua') && v:version >= 703 && has('patch885')
    NeoBundle 'Shougo/neocomplete.vim'
    " 2013-07-03 14:30 NeoComplCacheに合わせた
    let g:neocomplete#enable_at_startup = 1
    let s:hooks = neobundle#get_hooks("neocomplete.vim")
    function! s:hooks.on_source(bundle)
        let g:acp_enableAtStartup = 0
        let g:neocomplet#enable_smart_case = 1
        " NeoCompleteを有効化
        " NeoCompleteEnable
    endfunction
else
    NeoBundle 'Shougo/neocomplcache.vim'
    " 2013-07-03 14:30 原因不明だがNeoComplCacheEnableコマンドが見つからないので変更
    let g:neocomplcache_enable_at_startup = 1
    let s:hooks = neobundle#get_hooks("neocomplcache.vim")
    function! s:hooks.on_source(bundle)
        let g:acp_enableAtStartup = 0
        let g:neocomplcache_enable_smart_case = 1
        " NeoComplCacheを有効化
        " NeoComplCacheEnable 
    endfunction
endif

" --------- tcomment ----------
" tcommentで使用する形式を追加
if !exists('g:tcomment_types')
  let g:tcomment_types = {}
endif
let g:tcomment_types = {
\'c_surround' : "//%s",
\}

" ---------- YankRing ----------
" 特になし

" ---------- unite ---------
"insert modeで開始
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 20
" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 10

" ----------------------------------------
" ショートカット設定
" :help index.txtでキーマップ表示
" ----------------------------------------
" ---------- unite ---------
"nnoremap <silent> <F6> :<C-u>Unite history/yank<CR>
"nnoremap <silent> <F7> :<C-u>Unite -buffer-name=register register<CR>
"nnoremap <silent> <F7> :<C-u>UniteResume search-buffer<CR>
"grep検索
nnoremap <F5> :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
"選択文字をgrep検索
vnoremap <F5> y:Unite grep::-iHRn:<C-R>=escape(@", '\\.*$^[]')<CR><CR>
"preovを再呼出
nnoremap <F7> :<C-u>Unite buffer file_mru<CR>
nnoremap <F8> :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
" --------- tcomment ----------
" コメントされていれば、コメントを外し、コメントされてなければコメント化する。
nmap <C-/> <C-_><C-_>
vmap <C-/> <C-_><C-_>
function! SetCMapping()
	nmap <C-/> :TCommentAs c_surround<CR>
	vmap <C-/> :TCommentAs c_surround<CR>
endfunction
" Cのときだけ設定を追加
au FileType c call SetCMapping()
" my
" ウィンドウ移動
nnoremap <S-Left> <C-w>h
nnoremap <S-Right> <C-w>l
nnoremap <S-Up> <C-w>k
nnoremap <S-Down> <C-w>j
" ウィンドウサイズ変更
nnoremap <C-S-Left> <C-w><
nnoremap <C-S-Right> <C-w>>
nnoremap <C-S-Up> <C-w>+
nnoremap <C-S-Down> <C-w>-
" モード設定
inoremap <silent> <S-CR> <Esc>
vnoremap <silent> <S-CR> <Esc>
nnoremap <silent> <ESC> <ESC>:noh<CR>
"nnoremap <CR> i<CR><ESC>
" 選択
vmap <CR> y
nmap <Space> viw
" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
" 検索
vnoremap / "zy:let @/ = @z<CR>n
" 置換
nnoremap <expr> <F6> ':%s ;\<' . expand('<cword>') . '\>;'
vnoremap <expr> <F6> ':s ;\<' . expand('<cword>') . '\>;'

" ESCでIMEを確実にOFF
"inoremap <ESC> <ESC>:set iminsert=0<CR>



