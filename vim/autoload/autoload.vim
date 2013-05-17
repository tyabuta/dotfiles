" *******************************************************************
"
"                      autoload用のスクリプト
"
"                                                  (c) 2013 tyabuta.
" *******************************************************************


"
" カーソル移動についてのヘルプを表示する。
"
function! autoload#HelpCursorControl()
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
function! autoload#FileType()
    return &l:filetype
endfunction

"
" 日時を挿入する。
" 挿入する日時はコマンドラインより選択できる。
"
function! autoload#DateInsert()
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
" バッファ操作をキー操作で行う。
"   左: 前のバッファへ
"   右: 次のバッファへ
"   下: カレントバッファを閉じる
" 数値: 1-9の指定のバッファ番号へ
"
function! autoload#BufferControl()
    echo "--- Buffer Control --- %:Current #:Alternate a:Active h:Hidden"
    buffers
    echo "< Prev      Next >"
    echo "      Close"
    echo "        v  "
    echo "カーソルキー、または数値を入力してください。(何もしない場合はReturn) "

    " キー入力
    let c = getchar()
    if "\<Left>" == c
        bprevious
    elseif "\<Right>" == c
        bNext
    elseif "\<Down>" == c
        bdelete
    else
        " 1-9の数値入力の場合、番号指定でバッファ移動する。
        let num = str2nr(nr2char(c))
        if 0<num && bufexists(num)
            execute ":buffer " . num
        endif
    endif
    " 画面更新
    redraw
endfunction

