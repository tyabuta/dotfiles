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
call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'
" -------- Bundle管理 ---------

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/neocomplcache.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'tpope/vim-surround'
NeoBundle 'glidenote/memolist.vim'
NeoBundle 'tyru/caw.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'osyo-manga/unite-quickfix'
NeoBundle 'h1mesuke/unite-outline'



" ----- End of Bundle管理 -----
" ------------------
filetype plugin indent on
NeoBundleCheck

" prefix-key for Keymapping
nnoremap [prefix] <Nop>
nmap <space> [prefix]
vmap <space> [prefix]


" -------------------------------------------------------------------
" Unite
" -------------------------------------------------------------------

" unite-menu
let g:unite_source_menu_menus = {}
let g:unite_source_menu_menus.shortcat = {
    \'description': 'shortcat'
    \ }

let g:unite_source_menu_menus.shortcat.command_candidates = [
    \ ['vimrc-edit   (F9)', 'e $HOME/.vimrc'],
    \ ['vimrc-reload (F8)', 'source $HOME/.vimrc'],
    \ ['unite-file-mru',              'Unite file_mru'],
    \ ['unite-history-yank',          'Unite history/yank'],
    \ ['unite-same-dir-files',        'Unite file:%:h'],
    \ ['unite-bookmark-config-files', "Unite file:$HOME/.cache/unite/bookmark"],
    \ ['memolist-new',      'MemoNew'],
    \ ['switch-number',     "call macro#ToggleNumberDisplay()"],
    \ ['switch-wrap',       "call macro#ToggleWrap()"],
    \ ['switch-expandtab',  "call macro#ToggleExpandtab()"],
    \ ['php-function-list', 'vimgrep /\(^\|\s\+\)function\s\+.\+/ % | cwindow'],
    \ ]

" unite-mru
let g:unite_source_file_mru_limit = 500

" unite-history/yank
let g:unite_source_history_yank_enable = 1

" unite キーバインド
nnoremap <silent> [prefix]b :Unite buffer<CR>
nnoremap <silent> [prefix]c :Unite bookmark:*<CR>
nnoremap <silent> [prefix]u :UniteBookmarkAdd<CR>
nnoremap <silent> [prefix]f :Unite -start-insert buffer bookmark:* file_mru directory_mru file<CR>
nnoremap <silent> [prefix]<S-f> :Unite -start-insert file<CR>
nnoremap <silent> [prefix]m :Unite -start-insert menu:shortcat<CR>
nnoremap <silent> [prefix]j :Unite -auto-preview jump<CR>
nnoremap <silent> [prefix]l :Unite -direction=botright location_list<CR>
nnoremap <silent> [prefix]d :Unite -direction=botright -vertical -winwidth=70 outline<CR>


" -------------------------------------------------------------------
" memolist
" -------------------------------------------------------------------

let g:memolist_path = "$HOME/memo"
let g:memolist_memo_suffix = "txt"
let g:memolist_unite = 1
let g:memolist_unite_source = 'file_rec'
" let g:memolist_unite_option = "-auto-preview"

nnoremap <silent> [prefix]n :MemoList<CR>

" グローバルテキスト
"noremap [prefix]n :call macro#openGlobalMemo()<CR>

" -------------------------------------------------------------------
" NeoComplcache
" -------------------------------------------------------------------

" 補完機能を有効にする。
let g:neocomplcache_enable_at_startup = 1

" タブで補完を確定する。
inoremap <expr><TAB>   pumvisible() ? "<CR>" : "\<TAB>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags



" -------------------------------------------------------------------
" neosnippet
" -------------------------------------------------------------------

" Plugin key-mappings.
"imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)"
            \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)"
            \: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
    set conceallevel=2 concealcursor=i
endif

" -------------------------------------------------------------------
" vimfiler
" -------------------------------------------------------------------

let g:vimfiler_as_default_explorer = 1
nnoremap <silent> [prefix]e :VimFilerExplorer<CR>

" -------------------------------------------------------------------
" EasyMotion
" <Leader> はBackSlashキー
" -------------------------------------------------------------------

let g:EasyMotion_use_migemo = 1

" key-mapping
"nmap ' <Plug>(easymotion-s)
"vmap ' <Plug>(easymotion-s)
"omap ' <Plug>(easymotion-s)

nmap [prefix]w <Plug>(easymotion-bd-w)
vmap [prefix]w <Plug>(easymotion-bd-w)
omap [prefix]w <Plug>(easymotion-bd-w)

"nmap [prefix]e <Plug>(easymotion-bd-e)
"vmap [prefix]e <Plug>(easymotion-bd-e)
"omap [prefix]e <Plug>(easymotion-bd-e)



" -------------------------------------------------------------------
" caw.vim
" -------------------------------------------------------------------

" コメントアウト
nmap [prefix]o <Plug>(caw:i:toggle)
vmap [prefix]o <Plug>(caw:i:toggle)


" -------------------------------------------------------------------
" syntastic
" -------------------------------------------------------------------
let g:syntastic_enable_signs  = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_always_populate_loc_list = 1

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

" スクロール遅延の軽減
set lazyredraw
set ttyfast



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
nnoremap <C-d> kyyp

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

augroup MyAutoCmd
    " グループ内のオートコマンドを一旦消去
    autocmd!

    " バッファ保存時に不要な末日の空白を削除する。
    autocmd BufWrite * call ClearTailSpace()

    if !has('gui_running')
        " vim終了時にターミナルをクリアする
        autocmd VimLeave * :!clear
    endif
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
" Functions
" -----------------------------------------------

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
" カレントバッファの不要な末尾空白を消去する。
"
function! ClearTailSpace()
    let pos = getpos(".")

    " マッチしない場合にError表示が出るのでトラップする。
    try
        %s/\s\+$//
    catch
    endtry

    call setpos(".", pos)
endfunction



" -----------------------------------------------
" Make
" -----------------------------------------------
autocmd filetype php :set makeprg=php\ -ln\ %
autocmd filetype sh  :set makeprg=sh\ -n\ %
autocmd filetype php :set errorformat=%m\ in\ %f\ on\ line\ %l



