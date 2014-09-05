
if 0 != get(g:, 'loaded_pluginclude', 0)
  finish
endif
let g:loaded_pluginclude = 1

function! pluginclude#rc()
endfunction


NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/neocomplcache.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'kana/vim-smartinput'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'glidenote/memolist.vim'
NeoBundle 'osyo-manga/unite-quickfix'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tyabuta/sline-style.vim'
NeoBundle 'tyabuta/sweep-trail.vim'
NeoBundle 'tyabuta/switch-toggler.vim'
NeoBundle 'tyru/caw.vim'
NeoBundle 'junegunn/vim-easy-align'

NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'


