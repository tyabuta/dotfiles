
"
" メニューアイテム配列から、ディスプレイ配列を生成する。
"
function! s:get_display_array(menu)
    let arr = []
    for item in a:menu
        call add(arr, item.display)
    endfor
    return arr
endfunction


"
" 「挿入」メニュー用のコマンドメニュー
"
function! s:command_menu_insert()

    let item1 = {'display': "コメントライン"}
    function item1.func()
        call macro#CommentOutputLineWithFileType(macro#FileType(), 0)
    endfunction

    let item2 = {'display': "コメントライン(強調)"}
    function item2.func()
        call macro#CommentOutputLineWithFileType(macro#FileType(), 1)
    endfunction

    let item3 = {'display': "日付"}
    function item3.func()
        call macro#DateInsert()
    endfunction

    let menu = [item1, item2, item3]
    let ret = macro#PromptSelectMenuList("*** Command Menu ***",
                                       \ s:get_display_array(menu))
    if -1 != ret
        call menu[ret].func()
    endif
endfunction


"
" コマンドメニュー
" 選択メニュー形式で、コマンド機能を呼び出せる。
"
function! CommandMenu#Show()

    let item1 = {'display': "そうにゅう"}
    function item1.func()
        call s:command_menu_insert()
    endfunction

    let item2 = {'display': "へんしゅう"}
    function item2.func()
        echo "未実装"
    endfunction

    let menu = [item1, item2]
    let ret = macro#PromptSelectMenuList("*** Command Menu ***",
                                       \ s:get_display_array(menu))
    if -1 != ret
        call menu[ret].func()
    endif
endfunction


