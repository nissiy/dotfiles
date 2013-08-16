" -----------------------
" common
" -----------------------
set nocompatible

" -----------------------
" display
" -----------------------
set number
set ruler
set ts=2
set sw=2
set ai
set expandtab
set wildmenu
set wildmode=list:longest
set backspace=indent,eol,start

" 拡張子毎の独自設定
au BufNewFile,BufRead *.html set ts=2 sw=2 noexpandtab
au BufNewFile,BufRead *.php set ts=4 sw=4 expandtab

" -----------------------
" color
" -----------------------
syntax on

" -----------------------
" serach
" -----------------------
set ignorecase
set smartcase

" -----------------------
" completion
" -----------------------
set complete+=k

" -----------------------
" MacVim専用設定
" -----------------------
if has('gui_macvim')
  set showtabline=2	" タブを常に表示
  set imdisable	" IMを無効化
  set transparency=10	" 透明度を指定
  set antialias
  set guifont=Monaco:h14
  colorscheme macvim
endif

" -----------------------
" 全角スペースを表示
" -----------------------
function! ZenkakuSpace()
  "ZenkakuSpaceをカラーファイルで設定するなら次の行は削除
  highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=darkgrey
  "全角スペースを明示的に表示する。
  silent! match ZenkakuSpace /　/
endfunction
if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd VimEnter,BufEnter * call ZenkakuSpace()
  augroup END
endif

" -----------------------
" encoding
" -----------------------
set encoding=utf-8

" 改行コードの自動認識
set fileformats=unix,dos,mac
" 特殊文字がある場合にカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

" 文字コードの自動認識
"if &encoding !=# 'utf-8'
"	set encoding=japan
"	set fileencoding=japan
"endif
"if has('iconv')
"	let s:enc_euc = 'euc-jp'
"	let s:enc_jis = 'iso-2022-jp'
"	" iconvがeucJP-msに対応しているかをチェック
"	if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
"		let s:enc_euc = 'eucjp-ms'
"		let s:enc_jis = 'iso-2022-jp-3'
"	" iconvがJISX0213に対応しているかをチェック
"	elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
"		let s:enc_euc = 'euc-jisx0213'
"		let s:enc_jis = 'iso-2022-jp-3'
"	endif
"	" fileencodingsを構築
"	if &encoding ==# 'utf-8'
"		let s:fileencodings_default = &fileencodings
"		let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
"		let &fileencodings = &fileencodings .','. s:fileencodings_default
"		unlet s:fileencodings_default
"	else
"		let &fileencodings = &fileencodings .','. s:enc_jis
"		set fileencodings+=utf-8,ucs-2le,ucs-2
"		if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
"			set fileencodings+=cp932
"			set fileencodings-=euc-jp
"			set fileencodings-=euc-jisx0213
"			set fileencodings-=eucjp-ms
"			let &encoding = s:enc_euc
"			let &fileencoding = s:enc_euc
"		else
"			let &fileencodings = &fileencodings .','. s:enc_euc
"		endif
"	endif
"	" 定数を処分
"	unlet s:enc_euc
"	unlet s:enc_jis
"endif
"" 日本語を含まない場合は fileencoding に encoding を使うようにする
"if has('autocmd')
"	function! AU_ReCheck_FENC()
"		if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
"			let &fileencoding=&encoding
"		endif
"	endfunction
"	autocmd BufReadPost * call AU_ReCheck_FENC()
"endif
