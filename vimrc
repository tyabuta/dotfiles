scriptencoding utf-8
" *******************************************************************
"
"                            .vimrc
"
"                                           (c) 2012 - 2013 tyabuta.
" *******************************************************************

" vi互換モードを解除
set nocompatible


if 0 == isdirectory($VIMRUNTIME)
    echo "Not found runtime directory: " . $VIMRUNTIME
endif

" -------------------------------------------------------------------
" NeoBundle
"
" 更新 - :NeoBundleUpdate
" -------------------------------------------------------------------

" neobundleをランタイムPATHに挿入
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
" bundleディレクトリの登録
call neobundle#begin(expand('~/.vim/bundle/'))
call pluginclude#rc()
call neobundle#end()
filetype plugin indent on
NeoBundleCheck

call plugconf#rc()

" -----------------------------------------------
" 文字コードの設定
" -----------------------------------------------
set encoding    =utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileformat  =unix

set fileencodings =utf-8,ucs-bom,euc-jp,cp932,iso-2022-jp,ucs-21e,ucs-2
set fileformats   =unix,dos,mac

" 全角記号の表示調整
set ambiwidth=double

" -----------------------------------------------
" 表示関連
" -----------------------------------------------

" タイトルをウィンドウ枠に表示する。
set title

" 行数を表示する。
set number

" ルーラーを表示する。
set ruler

" シンタックスハイライトを有効にする。
syntax on

" カラースキームを設定する。
colorscheme ron

" 検索結果のハイライト(設定しない場合はデフォルトでNo)
set hlsearch
"set nohlsearch

"検索をファイルの先頭へループする
set wrapscan

" 入力中のコマンドを表示する
set showcmd

" 全角スペースに色をつける。
highlight ZenkakuSpace  guibg=gray ctermbg=gray
match ZenkakuSpace /　/

" カーソル形状
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

" Insertモード時に水平ラインを表示する
set nocursorline
autocmd InsertEnter,InsertLeave * set cursorline!


" macvim用の設定
if has('gui_macvim')
    " 透過率の設定
    set transparency=30
endif

set shortmess+=I

" スクロール遅延の軽減
set lazyredraw
set ttyfast

" マーカーでの折りたたみ
set foldmethod=marker

" -----------------------------------------------
" インデント関連
" -----------------------------------------------

" 自動的にインデントする。
set autoindent

" タブを空白に展開する。
set expandtab


" タブ幅を設定。
let &g:tabstop = macro#getTabSize()
let &l:tabstop = macro#getTabSize()
let &g:softtabstop = macro#getTabSize()
let &l:softtabstop = macro#getTabSize()

" インデント数を設定。
let &g:shiftwidth = macro#getTabSize()
let &l:shiftwidth = macro#getTabSize()



" -----------------------------------------------
" その他
" -----------------------------------------------

" カーソルを行頭・行末で止まらないようにする。
set whichwrap=b,s,h,l,<,>,[,]

" バックスペースで削除できるようにする。
set backspace=indent,eol,start

" マウスモードを有効にする
set mouse=a

" 保存しなくてもバッファ切り替えが出来る
set hidden

" スワップファイル設定
"set noswapfile                 " スワップファイルを作成しない
set directory=$HOME/.vim/backup " ディレクトリを指定

" バックアップファイル設定
"set nobackup                   " バックアップを作成しない
set backupdir=$HOME/.vim/backup " ディレクトリを指定する


" TOhtmlコマンドで行番号を出力しない
let html_number_lines=0

" クリップボード共有(guiでないと意味がない)
set clipboard=unnamed,autoselect

" 外部からファイル更新された場合、自動でリロードする。
set autoread

" ビープオンをフラッシュ表示に切り替え
set visualbell


" -----------------------------------------------
" キーバインド
" -----------------------------------------------

" exモード抑制
nnoremap Q <Nop>

" Shiftを押しながら移動キーで、画面スクロール。
nnoremap <S-j> <C-f>
nnoremap <S-k> <C-b>

" Shiftを押しながら移動キーで、行頭、行末移動。
nnoremap <S-h> ^
nnoremap <S-l> $


" Ctrl-s で保存
nnoremap <silent> <C-s> :w<CR>

" タブで画面移動
"nnoremap <Tab> <C-w>p

" vim スクリプトの読み込み(カレントバッファ)
nnoremap <F5> :call macro#Run()<CR>

" ビルドコマンドまたは、シンタックスチェック。
nnoremap <F7> :call macro#Build()<CR>

" .vimrcの再読み込み
nnoremap <F8> :source ~/.vimrc<CR>

" .vimrcファイルを開く
nnoremap <F9> :e ~/.vimrc<CR>

" 一行上をコピーして貼り付け
"nnoremap <C-d> kyyp

" バッファDelete
nnoremap <silent> <C-d> :bdelete<CR>

" 0レジスタを貼付ける。(0レジスタにはヤンクされたものだけが入る。)
nnoremap <C-p> "0p

" 数字の加算
nnoremap <C-z> <C-a>


" 日付の挿入
nnoremap <silent> <C-c>d :call macro#DateInsert()<CR>

" 検索結果のハイライトを解除
nnoremap <silent> <C-c>h :nohlsearch<CR>

" コメントライン書き込み(Shif-l強調版)
nnoremap <silent> <C-c>l
\ :call macro#CommentOutputLineWithFileType(macro#FileType(), 0)<CR>
nnoremap <silent> <C-c><S-l>
\ :call macro#CommentOutputLineWithFileType(macro#FileType(), 1)<CR>


" Shift-mでコマンドメニュー
"nnoremap <silent> <S-m> :call CommandMenu#Show()<CR>

" Shift-bでバッファ操作
nnoremap <silent> <S-b> :call macro#BufferControl()<CR>

" 全体選択
nnoremap [prefix]a ggVG


" 置換コマンドの補完
nnoremap [prefix]r :%s///gc<Left><Left><Left>
vnoremap [prefix]r :s///gc<Left><Left><Left>

" カーソル行のコマンドを外部コマンド実行する。
nnoremap <silent> [prefix]q ^y$:!<C-r>"<CR>
nnoremap <silent> [prefix]Q ^y$:r!<C-r>"<CR>

" カーソル位置の単語を検索
" nnoremap <silent> [prefix]s /<C-r><C-w><CR>

inoremap <C-f> <Esc>

inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" imap { {}<Left>
" imap [ []<Left>
" imap ( ()<Left>

" -----------------------------------------------
" オートコマンド
" -----------------------------------------------
augroup vimrc-my-group
    autocmd!

    if !has('gui_running')
        " vim終了時にターミナルをクリアする
        autocmd VimLeave * :!clear
    endif

    " .mdをmarkdownファイルと認識させる
    autocmd BufRead,BufNewFile *.md set filetype=markdown
augroup END


" -----------------------------------------------
" Command
" -----------------------------------------------

" カレントファイルをコマンド実行する。
command! Run :!./%

" FileEncodeをUTF-8に設定する。
command! UTF8 set fenc=utf8

"現バッファの差分表示。
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

"ファイルまたはバッファ番号を指定して差分表示。#なら裏バッファと比較
command! -nargs=? -complete=file Diff if '<args>'=='' | browse vertical diffsplit|else| vertical diffsplit <args>|endif



" -----------------------------------------------
" Make
" -----------------------------------------------
autocmd filetype php :set makeprg=php\ -ln\ %
autocmd filetype sh  :set makeprg=sh\ -n\ %
autocmd filetype php :set errorformat=%m\ in\ %f\ on\ line\ %l



