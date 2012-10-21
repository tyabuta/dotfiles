" vi互換モードを解除
set nocompatible

filetype off

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/

    call neobundle#rc(expand('~/.bundle'))
endif

NeoBundle 'git://github.com/Shougo/clang_complete.git'
NeoBundle 'git://github.com/Shougo/echodoc.git'
NeoBundle 'git://github.com/Shougo/neocomplcache.git'
NeoBundle 'git://github.com/Shougo/neobundle.vim.git'
NeoBundle 'git://github.com/Shougo/unite.vim.git'
NeoBundle 'git://github.com/Shougo/vim-vcs.git'
NeoBundle 'git://github.com/Shougo/vimfiler.git'
NeoBundle 'git://github.com/Shougo/vimshell.git'
NeoBundle 'git://github.com/Shougo/vinarise.git'

filetype plugin on
filetype indent on


" -----------------------------------------------
" 文字コードの設定
" -----------------------------------------------
set encoding    =utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileformat  =unix

set fileencodings =ucs-bom,euc-jp,cp932,iso-2022-jp
set fileencodings+=,ucs-21e,ucs-2,utf-8
set fileformats   =unix,dos,mac



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

" ステータスライン
set laststatus =2
set statusline =%<%f\ #%n%m%r%h%w
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}
set statusline+=%=\ (%v,%l)/%L%8P\


" macvim用の設定
if has('gui_macvim')
    " 透過率の設定
    set transparency=30
endif

set shortmess+=I


" -----------------------------------------------
" インデント関連
" -----------------------------------------------

" 自動的にインデントする。
set autoindent

" タブ幅を設定。
set tabstop=4

" インデント数を設定。
set shiftwidth=4

" タブを空白に展開する。
set expandtab



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

" スワップファイルを作成しない
set noswapfile

" バックアップを作成しない
set nobackup

" TOhtmlコマンドで行番号を出力しない
let html_number_lines=0



" -----------------------------------------------
" キーバインド
" -----------------------------------------------

" タブで画面移動
nmap <Tab> <C-w>p

" makeの実行
nmap <F7> :make<CR>

" .vimrcの再読み込み
nmap <F8> :source ~/.vimrc<CR>

" .vimrcファイルを開く
nmap <F9> :e ~/.vimrc<CR>

" 一行上をコピーして貼り付け
nmap <C-d> kyyp


" バッファの切り替え
nmap <Space>b :ls<CR>:buffer

" 次のバッファへ移動
nmap <Space>n :bn<CR>

" 前回表示していたバッファに移動
nmap <Space>v :b#<CR>

nmap <Space>e :vs<CR>:e.<CR>


" -----------------------------------------------
" オートコマンド
" -----------------------------------------------

augroup MyAutoCmd
    autocmd!

    " メイクファイルの場合、タブの展開をしない。
    autocmd FileType make set noexpandtab
augroup END



