
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


