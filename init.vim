"  |    _)  _ \___  |_ |_ |
"  __ \  | |   |   /   |  |
"  | | | | |   |  /    |  |
" _| |_|_|\___/ _/    _| _|

" ----------------------------------------
" Start vim-plug settings
" ----------------------------------------
"{{{
call plug#begin('~/.config/nvim/plugged')
  Plug 'Shougo/vimproc.vim', { 'do': 'make' }
  Plug 'cespare/vim-toml'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'fuenor/JpFormat.vim'
  Plug 'github/copilot.vim'
  Plug 'hrsh7th/vim-eft'
  Plug 'itchyny/lightline.vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/vim-easy-align'
  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-operator-replace'
  Plug 'kana/vim-operator-user'
  Plug 'osyo-manga/vim-textobj-multiblock'
  Plug 'lambdalisue/gina.vim'
  Plug 'lambdalisue/kensaku-search.vim'
  Plug 'lambdalisue/kensaku.vim'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'machakann/vim-sandwich'
  Plug 'mattn/emmet-vim'
  Plug 'neoclide/coc.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/nvim-treesitter-context'
  Plug 'phaazon/hop.nvim'
  Plug 'rebelot/kanagawa.nvim'
  Plug 'rking/ag.vim'
  Plug 'stevearc/oil.nvim'
  Plug 'thinca/vim-qfreplace'
  Plug 'tyru/columnskip.vim'
  Plug 'vim-denops/denops.vim'
  Plug 'yuki-yano/fuzzy-motion.vim'
  Plug 'leafOfTree/vim-svelte-plugin'
  Plug 'shellRaining/hlchunk.nvim'
  Plug 'yaegassy/coc-astro', {'do': 'yarn install --frozen-lockfile'}
  " Copilot Chat dependencies
  Plug 'zbirenbaum/copilot.lua'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'CopilotC-Nvim/CopilotChat.nvim', { 'branch': 'main' }
call plug#end()
filetype plugin indent on
"}}}

" ----------------------------------------
"  Basic Settings
" ----------------------------------------
"{{{
  nnoremap s <Nop>
  nnoremap <Space> <Nop>
  let mapleader="\<Space>"
  let g:yankring_clipboard_monitor=0
  set ambiwidth=double
  set backspace=2
  set clipboard=unnamed
  set cmdheight=1
  set diffopt=vertical
  set display=lastline
  set expandtab
  set fencs=utf-8,sjis,euc-jp
  set foldclose=all
  set foldcolumn=1
  set foldexpr=nvim_treesitter#foldexpr()
  set foldmethod=expr
  set foldopen=all
  set formatoptions+=mMj
  set hidden
  set history=1000
  set hlsearch
  set ignorecase
  set inccommand=split
  set incsearch
  set laststatus=2
  set lazyredraw
  set matchtime=1
  set modeline
  set modifiable
  set mouse=
  set nrformats-=octal
  set nu
  set pumblend=30
  set pumheight=10
  set ruler
  set shiftwidth=2
  set shortmess+=c
  set showcmd
  set showmatch
  set signcolumn=yes
  set smartcase
  set smartindent
  set smarttab
  set so=3
  set spelllang+=cjk
  set tabstop=2
  set textwidth=0
  set title
  set tm=500
  set ttyfast
  set updatetime=250
  set virtualedit+=all
  set visualbell t_vb=
  set wildchar=<TAB>
  set wildmenu
  set wildmode=longest:full,full
  set wrap
  set wrapscan
  set write
  " ripgrep
    if executable('rg')
      set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
      set grepformat=%f:%l:%c:%m
    endif
  " breakindent設定
    if exists('+breakindent')
      set breakindent
    endif
  " backupファイルとスワップファイルの設定
    set backup
    set backupdir=~/.config/nvim/backup
    set swapfile
    set directory=~/.config/nvim/swap
    set backupskip=/tmp/*,/private/tmp/*
  " 保存時に行末の空白を除去する
    function! s:remove_dust()
      let cursor = getpos(".")
      %s/\s\+$//ge
      call setpos(".", cursor)
      unlet cursor
    endfunction
    autocmd BufWritePre * if &filetype !=# 'markdown' | call <SID>remove_dust() | endif
  " 全角スペースの設定
    function! ZenkakuSpace()
        highlight ZenkakuSpace cterm=reverse ctermfg=darkgray gui=reverse guifg=darkgray
    endfunction
    if has('syntax')
      augroup ZenkakuSpace
        au!
        autocmd ColorScheme       * call ZenkakuSpace()
        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
      augroup END
      call ZenkakuSpace()
    endif
  "visual モードの時にスターで選択位置のコードを検索するようにする
    xnoremap * :call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
    xnoremap # :call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
    function! s:VSetSearch()
      let temp = @s
      norm! gv"sy
      let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
      let @s = temp
    endfunction
  " undo記憶、undoファイルの生成
    if has('persistent_undo')
      set undodir=~/.config/nvim/undo
      set undofile
    endif
  " grep後にcwinを表示
    autocmd QuickFixCmdPost make,grep,grepadd,vimgrep,vimgrepadd cwin
  " foldtextの設定
    set foldtext=v:folddashes.substitute(getline(v:foldstart),'/\\*\\\|\\*/\\\|{{{\\d\\=','','g')
  " Prepend mise shims to PATH
    let $PATH = $HOME . '/.local/share/mise/shims:' . $PATH
"}}}

" ----------------------------------------
"  key mappings
" ----------------------------------------
"{{{
" スペースキー + . で.vimrcを開く
  nnoremap <Leader>. :tabedit ~/.config/nvim/init.vim<CR>
" 検索語が画面の真ん中に来るようにする
  nmap n nzz
  nmap N Nzz
  nmap * *zz
  nmap # #zz
  nmap g* g*zz
  nmap g# g#zz
" zz モーション
  nmap zz zz<sid>(z1)
  nnoremap <script> <sid>(z1)z zt<sid>(z2)
  nnoremap <script> <sid>(z2)z zb<sid>(z3)
  nnoremap <script> <sid>(z3)z zz<sid>(z1)
" insertモードから抜ける
  inoremap <silent><C-j> <ESC>
" terminalモードから抜ける
  tnoremap <silent>jj <C-\><C-n>
" カーソル操作
  inoremap <C-a> <Home>
  inoremap <C-e> <End>
  inoremap <C-f> <Right>
  inoremap <C-b> <Left>
" 移動を表示行単位に
  noremap j gj
  noremap k gk
  noremap gj j
  noremap gk k
" 現在行を入れ替える
  nnoremap [.  :execute 'move -1-'. v:count1<CR>
  nnoremap ].  :execute 'move +'. v:count1<CR>
" insertモードで次の行に直接改行
  inoremap <C-o> <Esc>o
" cntrl + n キーで改行
  noremap <C-n> o<Esc>
" カーソルキーでバッファのサイズ変更
  nnoremap <silent><Down>  <C-w>-
  nnoremap <silent><Up>    <C-w>+
  nnoremap <silent><Left>  <C-w><
  nnoremap <silent><Right> <C-w>>
" ファイル操作
  nnoremap <Leader>, :w<CR>
" 同単語検索設定
  nnoremap * *N
" キー入れ替え
  noremap ; :
  noremap : ;
" x の挙動
  nnoremap x "_d
  nnoremap X "_D
  xnoremap x "_d
  onoremap x d
" cc の挙動
  nnoremap cc "_cc
" i<space> の設定
  onoremap i<space> iW
  xnoremap i<space> iW
" redo
  nnoremap <silent>U <C-r>
" copy の挙動
 xnoremap y mzy`z
" 空行編集時の挙動
  nnoremap <expr> i empty(getline('.')) ? '"_cc' : 'i'
  nnoremap <expr> A empty(getline('.')) ? '"_cc' : 'A'
" 大文字小文字の切り替え
  " 全部大文字
  inoremap <C-g><C-u> <esc>gUiwgi
  " 全部小文字
  inoremap <C-g><C-l> <esc>guiwgi
  " 先頭大文字
  inoremap <C-g><C-k> <esc>bgUlgi
" 置換の設定
  nnoremap S :%s/\V\<<C-r><C-w>\>//g<Left><Left>
  xnoremap S "zy:%s/\V<C-r><C-r>=escape(@z,'/\')<CR>//gce<Left><Left><Left><Left>
" ペーストの設定
  nnoremap p ]p`]
  nnoremap P ]P`]
" vimgrep時の候補移動
  nnoremap <silent>[q :cprevious<CR>
  nnoremap <silent>]q :cnext<CR>
  nnoremap <silent>[Q :cfirst<CR>
  nnoremap <silent>]Q :clast<CR>
" .vimrcの再読み込み
  nnoremap <silent><F6> :source $MYVIMRC<CR>
" コマンドライン設定
  cnoremap <C-a> <Home>
  cnoremap <C-b> <Left>
  cnoremap <C-f> <Right>
  cnoremap <C-h> <BackSpace>
  cnoremap <C-d> <Del>
  cnoremap <C-e> <End>
  cnoremap <C-n> <Down>
  cnoremap <C-p> <Up>
" control lの設定
  nnoremap <C-l> :nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-l>
" Visualモードでインデントした時の範囲解除を避ける
  vnoremap < <gv
  vnoremap > >gv
" cwin操作
  nnoremap <silent><Leader>op :copen<CR>
  nnoremap <silent><Leader>cl :cclose<CR>
" タブ操作
  nnoremap <silent><Leader>tn gt
  nnoremap <silent><Leader>tN gT
" ペーストした部分を選択する
  nnoremap gp `[v`]
"}}}

" ----------------------------------------
"  local .vimrc setting
" ----------------------------------------
"{{{
  let s:dir = getcwd()
  let s:ans = findfile(".vimrc.local", fnameescape(s:dir).";")

  if len(s:ans) > 1
    let s:rc = fnamemodify(s:ans, ":p:h")."/.vimrc.local"
    call feedkeys(";source".s:rc."\<CR>")
  endif
"}}}

" ----------------------------------------
"  window setting
" ----------------------------------------
"{{{
  if has('nvim')
    function! s:focus_floating() abort
      if !empty(nvim_win_get_config(win_getid()).relative)
        wincmd p
        return
      endif
      for winnr in range(1, winnr('$'))
        let winid = win_getid(winnr)
        let conf = nvim_win_get_config(winid)
        if conf.focusable && !empty(conf.relative)
          call win_gotoid(winid)
          return
        endif
      endfor
      execute "normal! \<C-w>\<C-w>"
    endfunction
    nnoremap <silent> <C-w><C-w> :call <SID>focus_floating()<CR>
  endif
"}}}

" ----------------------------------------
"  au settings
" ----------------------------------------
"{{{
  augroup diffWrap
    au!
    au FilterWritePre * if &diff | setlocal wrap | endif
  augroup END
  au FileType {json,yaml,vim,markdown} setlocal fdo& fcl& fdm=manual
"}}}

" ----------------------------------------
"  set commands
" ----------------------------------------
"{{{
  " 現在開いているファイルのディレクトリに移動(バッファ限定)
    function SetLcd()
      lcd %:h
    endfunction
    command! -nargs=0 Lcd :call SetLcd()
  " Rename {新しいファイル名}
    command! -nargs=1 -complete=file Rename file <args> | call delete(expand('#'))
"}}}

" ----------------------------------------
"  textobj-multiblock setting
" ----------------------------------------
"{{{
  omap ab <Plug>(textobj-multiblock-a)
  omap ib <Plug>(textobj-multiblock-i)
  xmap ab <Plug>(textobj-multiblock-a)
  xmap ib <Plug>(textobj-multiblock-i)
"}}}
" ----------------------------------------
"  coc setting
" ----------------------------------------
"{{{
  let g:coc_global_extensions = [
    \  'coc-lists'
    \, 'coc-json'
    \, 'coc-sh'
    \, 'coc-phpls'
    \, 'coc-html'
    \, 'coc-css'
    \, 'coc-tsserver'
    \, 'coc-solargraph'
    \, 'coc-docker'
    \, 'coc-word'
    \, 'coc-tabnine'
    \, 'coc-pairs'
    \, 'coc-styled-components'
    \, 'coc-lua'
    \, 'coc-svelte'
    \]
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gn <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  nmap <silent> gfo <Plug>(coc-format)
  " Remap for rename current word
  nmap <Leader>rn <Plug>(coc-rename)
  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')
  " Use Q for show documentation in preview window
  nnoremap <silent> Q :call <SID>show_documentation()<CR>
  " Hover表示
  nnoremap <silent> gf :call CocAction('doHover')<CR>
  function! s:show_documentation()
    if &filetype == 'vim'
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction
  " coc-pairsの設定
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<C-r>=coc#on_enter()\<CR>"
  " coc-css の設定
  autocmd FileType css setlocal iskeyword+=-
  autocmd FileType scss setlocal iskeyword+=@-@
  " CocList grepを実行する
  function CocGrep()
    CocList grep
  endfunction
  command! -nargs=0 Grep :call CocGrep()
  nnoremap <ESC><ESC>g :Grep<CR>
"}}}

" ----------------------------------------
"  fuzzy-moiton setting
" ----------------------------------------
"{{{
  nnoremap ss :FuzzyMotion<CR>
  let g:fuzzy_motion_labels = [
        \ 'A', 'O', 'E', 'U', 'I', 'D', 'H', 'T', 'N', 'S', 'P', 'Y', 'F', 'G', 'C', 'R', 'L', 'Q', 'J', 'K', 'X', 'B', 'M', 'W', 'V', 'Z'
        \ ]
"}}}

" ----------------------------------------
"  fzf setting
" ----------------------------------------
"{{{
  set rtp+=/opt/homebrew/opt/fzf
  nnoremap <silent>: :Buffers<CR>'
  nnoremap <silent>q: :History:<CR>'
  nnoremap <silent><Leader>? :GFiles?<CR>'
  nnoremap <silent><Leader>u :GFiles<CR>'
  nnoremap <silent><Leader>d :History<CR>'
  nnoremap <silent><Leader>r :Tags<CR>
  " Insert mode completion
  imap <C-x><C-k> <Plug>(fzf-complete-word)
  imap <C-x><C-f> <Plug>(fzf-complete-path)
  imap <C-x><C-j> <Plug>(fzf-complete-file-ag)
  imap <C-x><C-l> <Plug>(fzf-complete-line)
"}}}

" ----------------------------------------
"  columnskip setting
" ----------------------------------------
"{{{
  nmap <silent>\h <Plug>(columnskip:nonblank:next)
  omap <silent>\h <Plug>(columnskip:nonblank:next)
  xmap <silent>\h <Plug>(columnskip:nonblank:next)
  vmap <silent>\h <Plug>(columnskip:nonblank:next)
  nmap <silent>\t <Plug>(columnskip:nonblank:prev)
  omap <silent>\t <Plug>(columnskip:nonblank:prev)
  xmap <silent>\t <Plug>(columnskip:nonblank:prev)
  vmap <silent>\t <Plug>(columnskip:nonblank:prev)
"}}}

" ----------------------------------------
"  color setting
" ----------------------------------------
"{{{
" カラースキーム決定
  set t_Co=256
  syntax on
  let g:nvcode_termcolors=256
  hi clear
  colorscheme kanagawa
  set cursorline
"}}}

" ----------------------------------------
"  treesitter setting
" ----------------------------------------
"{{{
  luafile ~/.config/lua/treesitter.lua
"}}}

" ----------------------------------------
"  copilot setting
" ----------------------------------------
"{{{
  imap <silent><expr><script><C-Space> copilot#Accept("\<CR>")
  imap <silent><C-l> <Plug>(copilot-next)
  imap <silent><C-k> <Plug>(copilot-previous)
"}}}

" ----------------------------------------
"  gitsigns setting
" ----------------------------------------
"{{{
  luafile ~/.config/lua/gitsigns.lua
"}}}

" ----------------------------------------
"  hop setting
" ----------------------------------------
"{{{
  luafile ~/.config/lua/hop.lua
"}}}

" ----------------------------------------
"  oil setting
" ----------------------------------------
"{{{
  luafile ~/.config/lua/oil.lua
"}}}

" ----------------------------------------
"  hlchunk setting
" ----------------------------------------
"{{{
  luafile ~/.config/lua/hlchunk.lua
"}}}

" ----------------------------------------
"  CopilotChat setting
" ----------------------------------------
"{{{
  luafile ~/.config/lua/copilotc.lua
"}}}

" ----------------------------------------
"  plugin setting
" ----------------------------------------
"{{{
  let g:lightline = {'colorscheme': 'wombat'}
  vmap <Enter> <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
  nmap ldo <Plug>(gina-diffget-l)
  nmap rdo <Plug>(gina-diffget-r)
  nnoremap gL :JpFormatAll<CR>
  let JpFormatMarker="  "
  let g:user_emmet_install_global = 0
  autocmd FileType html,css,php,markdown,javascript,javascriptreact,typescriptreact,eruby,astro EmmetInstall
  let g:fzf_preview_window = ''
  let g:fzf_buffers_jump = 1
  let g:fzf_layout = { 'down': '40%' }
  cnoremap <CR> <Plug>(kensaku-search-replace)<CR>
  nmap ^ <Plug>(operator-replace)
"}}}

" ----------------------------------------
"  Dvorak setting
" ----------------------------------------
"{{{
  nnoremap H J
  nnoremap J E
  nnoremap K B
  nnoremap e d
  nnoremap E D
  nnoremap ee dd
  nnoremap j e
  nnoremap k b
  nnoremap l <Nop>
  nnoremap z; zr
  nnoremap z+ zR

  nnoremap <silent><nowait>d h
  nnoremap <silent><nowait>gh j
  nnoremap <silent><nowait>h gj
  nnoremap <silent><nowait>gt k
  nnoremap <silent><nowait>t gk
  nnoremap <silent><nowait>n l

  vnoremap H J
  vnoremap J E
  vnoremap K B
  vnoremap e d
  vnoremap j e
  vnoremap k b
  vnoremap l <Nop>

  vnoremap <silent><nowait>d h
  vnoremap <silent><nowait>gh j
  vnoremap <silent><nowait>h gj
  vnoremap <silent><nowait>gt k
  vnoremap <silent><nowait>t gk
  vnoremap <silent><nowait>n l

  nnoremap r n
  nnoremap R N
  nnoremap zh zj
  nnoremap zt zk
"}}}

" vim: set ts=2 sw=2 fdm=marker fcl& fdo& :
