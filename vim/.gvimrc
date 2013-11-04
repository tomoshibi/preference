" .gvimrc


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

" ----------------------------------------
" 表示設定
" ----------------------------------------
"カラー設定
colorscheme my_jellybeans

" 全角スペースの色を変更
hi ZenkakuSpace gui=underline guifg=LightGray cterm=underline ctermfg=LightGray
match ZenkakuSpace /　/

" ----------------------------------------
" GUI設定
" ----------------------------------------
" ツールバーを削除
set guioptions-=T
"メニューを削除
"set guioptions-=m
" 水平スクロールバーON
set guioptions+=b

" ----------------------------------------
" フォント設定
" ----------------------------------------
"set guifont=TakaoGothic\ 11
"set guifont=モトヤLマリベリ3等幅\ 11
"set guifont=MotoyaLMaru\ 11
"set guifont=MotoyaLCedar\ 11
if ostype == 'win'
	set guifont=Ricty_Diminished:h12
	set rop=type:directx
else
	set guifont=Ricty\ Diminished\ 12
endif

" ----------------------------------------
" サイズ設定
" ------------------------------------
" ウインドウの表示位置（左上の座標）
winpos 960 26
" 横幅 デフォルトは80
set columns=117
" 縦幅 デフォルトは24
set lines=61

" ----------------------------------------
" IME設定
" ----------------------------------------
"## 「imdisable」オプション
"augroup InsModeAu
"    autocmd!
"    autocmd InsertEnter,CmdwinEnter * set noimdisable
"    autocmd InsertLeave,CmdwinLeave * set imdisable
"augroup END

"## IME状態に応じたカーソル色を設定
if has('multi_byte_ime')
  highlight Cursor guifg=NONE guibg=Green
  highlight CursorIM guifg=NONE guibg=Purple
endif

" ----------------------------------------
" クリップボード設定
" ----------------------------------------

