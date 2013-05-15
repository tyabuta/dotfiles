" *******************************************************************
"
"                            .vimrc
"
"                                           (c) 2012 - 2013 tyabuta.
" *******************************************************************

" vi互換モードを解除
set nocompatible

" neocomplcache
set runtimepath+=$HOME/.vim/neocomplcache
let g:neocomplcache_enable_at_startup = 1

" タブで補完を確定する。
inoremap <expr><TAB>   pumvisible() ? "<CR>" : "\<TAB>"




" -----------------------------------------------
" 文字コードの設定
" -----------------------------------------------
set encoding    =utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileformat  =unix

set fileencodings =utf-8,ucs-bom,euc-jp,cp932,iso-2022-jp,ucs-21e,ucs-2
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

" 検索結果のハイライト(設定しない場合はデフォルトでNo)
set hlsearch
"set nohlsearch

"検索をファイルの先頭へループする
set wrapscan

" 全角スペースに色をつける。
highlight ZenkakuSpace  guibg=gray ctermbg=gray
match ZenkakuSpace /　/


" ステータスライン
set laststatus =2
set statusline =%<%f%y\ #%n%m%r%h%w
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



" -----------------------------------------------
" キーバインド
" -----------------------------------------------

" Shiftを押しながら移動キーで、画面スクロール。
nnoremap <S-j> <C-f>
nnoremap <S-k> <C-b>

" タブで画面移動
nnoremap <Tab> <C-w>p

" vim スクリプトの読み込み(カレントバッファ)
nnoremap <silent> <F5> :call ImportCurrentBuffer()<CR>

" makeの実行
nnoremap <F7> :make<CR>

" .vimrcの再読み込み
nnoremap <F8> :source ~/.vimrc<CR>

" .vimrcファイルを開く
nnoremap <F9> :e ~/.vimrc<CR>

" 一行上をコピーして貼り付け
nnoremap <C-d> kyyp

" 0レジスタを貼付ける。(0レジスタにはヤンクされたものだけが入る。)
nnoremap <C-p> "0p



" 日付の挿入
nnoremap <silent> <C-c><C-d> :call DateInsert()<CR>

" 検索結果のハイライトを解除
nnoremap <silent> <C-c><C-h> :nohlsearch<CR>

" Shift-bでバッファ操作
nnoremap <silent> <S-b> :call BufferControl()<CR>


" バッファの切り替え
nnoremap <Space>b :ls<CR>:buffer

" 次のバッファへ移動
nnoremap <Space>n :bn<CR>

" 前回表示していたバッファに移動
nnoremap <Space>v :b#<CR>

nnoremap <Space>e :vs<CR>:e.<CR>


" -----------------------------------------------
" オートコマンド
" -----------------------------------------------

augroup MyAutoCmd
    " グループ内のオートコマンドを一旦消去
    autocmd!

    " メイクファイルの場合、タブの展開をしない。
    autocmd FileType make set noexpandtab

    " バッファ保存時に不要な末日の空白を削除する。
    autocmd BufWrite * call ClearTailSpace()

augroup END



" -----------------------------------------------
" Command
" -----------------------------------------------

" カレントファイルをコマンド実行する。
command! Run :!./%

" FileEncodeをUTF-8に設定する。
command! UTF8 set fenc=utf8

" 登録されているレジスタの一覧を表示する。
command! RegisterList :reg





" -----------------------------------------------
" Functions
" -----------------------------------------------

"
" カレントバッファをsourceコマンドで読み込む
"
function! ImportCurrentBuffer()
    if "vim" == &l:filetype
        echo "import " . expand("%:p")
        source %
    endif
endfunction

"
" シンタックスハイライトを切り替える。(enable/off)
"
function! SyntaxHighlightToggle()
    if exists("g:syntax_on")
        syntax off
    else
        syntax enable
    endif
endfunction

"
" コメントによる線を引く。
"
"      line: 行を表す表記
" begin_str: コメントの始まり
"   end_str: コメントの終わり
"      char: ライン形成に使用する文字
"
function! CommentOutputLine(line, begin_str, end_str, char)
    let cur_line = line(a:line)
    " コメントの最大列数
    let col_max = 70

    let str = a:begin_str
    let str.= repeat(a:char, col_max - strlen(a:begin_str . a:end_str))
    let str.= a:end_str
    call setline(cur_line, str)
endfunction

"
" 日時を挿入する。
" 挿入する日時はコマンドラインより選択できる。
"
function! DateInsert()
    " 候補となる日付書式を作成
    let now = localtime()
    let formats = [
        \ strftime("%Y.%m.%d", now),
        \ strftime("%Y.%m.%d %H:%M", now),
        \ strftime("%Y/%m/%d", now),
        \ strftime("%Y/%m/%d %H:%M", now),
        \ strftime("%H:%M", now),
        \ strftime("%H時%M分", now),
        \ strftime("%H時%M分%S秒", now),
        \ strftime("%Y年%m月%d日 %H時%M分", now),
        \ strftime("%Y年%m月%d日 %A %H時%M分", now),
        \ strftime("%Y.%m.%d(%a)", now),
        \ strftime("%Y/%m/%d(%a)", now),
        \ strftime("%Y年%m月%d日(%a)", now),
        \ strftime("%Y年%m月%d日 %A", now)]

    " メッセージ用のリストを作成
    let msg_list = []
    call add(msg_list, "挿入する日付書式を選んでください。")
    let i =1
    for n in formats
        call add(msg_list, ((i<10)?' '.i : i) .') '.n)
        let i += 1
    endfor

    " コマンドラインで入力を受け付ける。
    let ret = inputlist(msg_list)
    if 0<ret && ret<=len(formats)
        " 選択された日付を挿入
        execute ":normal i" . formats[ret-1]
    endif
endfunction



"
" カレントバッファの不要な末尾空白を消去する。
"
function! ClearTailSpace()
    " マッチしない場合にError表示が出るのでトラップする。
    try
        %s/\s\+$//
    catch
    endtry
endfunction

"
" カーソル移動についてのヘルプを表示する。
"
function! HelpCursorControl()
    echo "Cursor移動 h,j,k,l"
    echo "    k ... カーソルを上に移動        k:上"
    echo "    h ... カーソルを左に移動  h:左"
    echo "    l ... カーソルを右に移動           l:右"
    echo "    j ... カーソルを下に移動     j:下"
    echo "Word移動 w,b,e,ge"
    echo "    w ... 次の単語の先頭に移動"
    echo "    b ... 前の単語の先頭に移動"
    echo "    e ... 次の単語の末尾に移動"
    echo "   ge ... 前の単語の末尾に移動"
    echo "行移動 ^,$"
    echo "    ^ ... 行頭へ移動"
    echo "    $ ... 行末へ移動"
    echo "括弧移動 %"
    echo "    % ... 対応する括弧へ移動"
    echo "画面移動 C-f,C-b"
    echo "  C-f ... １画面分進む or S-j (my custom)"
    echo "  C-b ... １画面分戻る or S-k (my custom)"
endfunction




"
" バッファ操作をキー操作で行う。
" 左: 前のバッファへ
" 右: 次のバッファへ
" 下: カレントバッファを閉じる
"
function! BufferControl()
    echo "-BufferControl- "
    buffers
    echo "< Prev      Next >"
    echo "      Close"
    echo "        v  "
    echo "カーソルキーで操作入力してください。(何もしない場合はReturn) "

    " キー入力
    let c = getchar()
    if "\<Left>" == c
        bprevious
    elseif "\<Right>" == c
        bNext
    elseif "\<Down>" == c
        bdelete
    endif
    " 画面更新
    redraw
endfunction


