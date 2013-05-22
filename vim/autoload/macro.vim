
"
" more-promptの設定をする。
" 1 -> more  0 -> nomore
"
function! macro#MorePromptSetEnabled(bMore)
    if a:bMore
        set more
    else
        set nomore
    endif
endfunction

"
" more-promptの設定値を返す。
" 1 -> more  0 -> nomore
"
function! macro#MorePrompt()
    return &g:more
endfunction


"
" コマンドラインに選択リストを表示する。
" カーソルで操作し、決定すると選択されたリストインデックスを返す。
" 選択がキャンセルされると-1を返します。
"   msg: 選択を促すメッセージ
" items: 選択リストに表示する項目を配列で渡す。
"
function! macro#PromptSelectMenuList(msg, items)
    " more-promptの既存設定値
    let original_more = macro#MorePrompt()
    " echo出力があふれた時にMore表示が出ないようにする。
    call macro#MorePromptSetEnabled(0)

    let sel = 0
    let items_lentgh = len(a:items)
    while 1
        " --- 描画 ---
        redraw | echo a:msg
        let i = 0
        for item in a:items
            echo (sel==i? '->' : '  ') . item
            let i+=1
        endfor
        echo printf("sel:%2d (^,v:Select  <:Cancel  >:OK) ", sel)

        " --- 入力 ---
        let a = getchar()
        let c = nr2char(a)
        if     "\<Down>"  ==a || 'j'==c
            let sel+=1
        elseif "\<Up>"    ==a || 'k'==c
            let sel-=1
        elseif "\<Left>"  ==a || 'h'==c
            let sel = -1
            break
        elseif "\<Right>" ==a || 'l'==c
            break
        endif
        " インデックスのループ計算
        let sel = (sel+items_lentgh) % items_lentgh
    endwhile

    " オリジナルの設定に戻す。
    call macro#MorePromptSetEnabled(original_more)
    " 再描画
    redraw
    return sel
endfunction


"
" カーソル移動についてのヘルプを表示する。
"
function! macro#HelpCursorControl()
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
" カレントバッファのファイルタイプを取得する。
"
function! macro#FileType()
    return &l:filetype
endfunction

"
" 日時を挿入する。
" 挿入する日時はコマンドラインより選択できる。
"
function! macro#DateInsert()
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
" バッファ操作をカーソルキーで行う。
"   左: 前のバッファへ
"   右: 次のバッファへ
"   下: カレントバッファを閉じる
" 数値: 1-9の指定のバッファ番号へ(10以上は不可)
"
function! macro#BufferControl()
    echo "*** Buffer Control ***"
    echo "%:Current #:Alternate a:Active h:Hidden +:Changed"
    echo "--------------------------------------------------"
    buffers
    echo "--------------------------------------------------"
    echo "                       ^"
    echo "< Previous  Close  Alternate  Next >"
    echo "              v                      Please key press."

    " キー入力
    let a = getchar()  " Ascii
    let c = nr2char(a) " Char
    let n = str2nr(c)  " Number
    if     "\<Left>" ==a || 'h'==c
        bprevious
    elseif "\<Down>" ==a || 'j'==c
        bdelete
    elseif "\<Up>"   ==a || 'k'==c
        b#
    elseif "\<Right>"==a || 'l'==c
        bNext
    else
        " 1-9の数値入力の場合、番号指定でバッファ移動する。
        if 0<n && bufexists(n)
            execute ":buffer " . n
        endif
    endif

    " 画面更新
    redraw
endfunction



"
" PHP用のシンタックスチェック
"
function! macro#PHPSyntaxCheck()
    execute ":silent !clear"
    execute ":silent !echo PHP Syntax Check"
    execute ":!php --syntax-check %"
endfunction


"
" ビルドコマンド、またはシンタックスチェックを
" ファイルタイプに応じて行う。
"
function! macro#Build()
    let filetype = macro#FileType()
    if "php" == filetype
        call macro#PHPSyntaxCheck()
    else
        echo printf("[%s]に適切なビルドコマンドが見つかりません。", filetype)
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
function! macro#CommentOutputLine(line, begin_str, end_str, char)
    let cur_line = line(a:line)
    " コメントの最大列数
    let col_max = 70

    let str = a:begin_str
    let str.= repeat(a:char, col_max - strlen(a:begin_str . a:end_str))
    let str.= a:end_str
    call setline(cur_line, str)
endfunction

"
"
" textファイル用のコメントライン書き込み関数
" linetype: 0 -> -----
"           1 -> =====
"
function! macro#CommentOutputLineForText(linetype)
    call macro#CommentOutputLine(".",
        \ '',
        \ '',
        \ (a:linetype? '=' : '-'))
endfunction

"
"
" vimファイル用のコメントライン書き込み関数
" linetype: 0 -> " -----
"           1 -> " *****
"
function! macro#CommentOutputLineForVim(linetype)
    call macro#CommentOutputLine(".",
        \ '" ',
        \ '',
        \ (a:linetype? '*' : '-'))
endfunction

"
"
" Shellスクリプト用のコメントライン書き込み関数
" Ruby, Perlでも使用可。
" linetype: 0 -> # -----
"           1 -> # *****
"
function! macro#CommentOutputLineForShell(linetype)
    call macro#CommentOutputLine(".",
        \ '# ',
        \ '',
        \ (a:linetype? '*' : '-'))
endfunction

"
" ファイルタイプに応じてコメントによるラインを書き込む。
"
function! macro#CommentOutputLineWithFileType(ftype, linetype)
    if "vim"==a:ftype
        call macro#CommentOutputLineForVim(a:linetype)
    elseif "sh"==a:ftype || "ruby"==a:ftype || "perl"==a:ftype
        call macro#CommentOutputLineForShell(a:linetype)
    else
        call macro#CommentOutputLineForText(a:linetype)
    endif
endfunction

