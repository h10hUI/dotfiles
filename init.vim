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
  Plug 'Yggdroot/indentLine'
  Plug 'cespare/vim-toml'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'fuenor/JpFormat.vim'
  Plug 'github/copilot.vim'
  Plug 'hrsh7th/vim-eft'
  Plug 'itchyny/lightline.vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/vim-easy-align'
  Plug 'kana/vim-operator-replace'
  Plug 'kana/vim-operator-user'
  Plug 'lambdalisue/gina.vim'
  Plug 'lambdalisue/kensaku-search.vim'
  Plug 'lambdalisue/kensaku.vim'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'machakann/vim-sandwich'
  Plug 'mattn/emmet-vim'
  Plug 'neoclide/coc.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'phaazon/hop.nvim'
  Plug 'rebelot/kanagawa.nvim'
  Plug 'rking/ag.vim'
  Plug 'stevearc/oil.nvim'
  Plug 'thinca/vim-qfreplace'
  Plug 'tomtom/tcomment_vim'
  Plug 'tyru/columnskip.vim'
  Plug 'vim-denops/denops.vim'
  Plug 'yuki-yano/fuzzy-motion.vim'
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
  set fdm=marker
  set fencs=utf-8,sjis,euc-jp
  set formatoptions+=t
  set hidden
  set history=1000
  set hlsearch
  set ignorecase
  set inccommand=split
  set incsearch
  set laststatus=2
  set lazyredraw
  set list
  set listchars=tab:»-,trail:-,eol:↲,extends:>,precedes:<,nbsp:%
  set matchtime=1
  set modeline
  set modifiable
  set mouse=
  set nrformats-=octal
  set nu
  set pumheight=10
  set pumblend=30
  set ruler
  set sh=bash
  set shiftwidth=2
  set shortmess+=c
  set showcmd
  set showmatch
  set signcolumn=yes
  set smartcase
  set smartindent
  set smarttab
  set so=7
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
  " netrwは常にtree view
    let g:netrw_liststyle=3
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
  "ステータスラインに情報を表示する
    set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
  " undo記憶、undoファイルの生成
    if has('persistent_undo')
      set undodir=~/.config/nvim/undo
      set undofile
    endif
  " vimdiffの設定
    function! s:vimdiff_in_newtab(...)
      if a:0 == 1
        tabedit %:p
        exec 'rightbelow vertical diffsplit ' . a:1
      else
        exec 'tabedit ' . a:1
        for l:file in a:000[1 :]
          exec 'rightbelow vertical diffsplit ' . l:file
        endfor
      endif
    endfunction
    command! -bar -nargs=+ -complete=file Diff  call s:vimdiff_in_newtab(<f-args>)
  " grep後にcwinを表示
    autocmd QuickFixCmdPost make,grep,grepadd,vimgrep,vimgrepadd cwin
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
" insertモードから抜ける
  inoremap <silent><C-j> <ESC>
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
" xとsの挙動
  nnoremap x "_x
  vnoremap x "_x
  nnoremap X "_X
  vnoremap X "_X
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
" ctagsのタグジャンプ
  nnoremap <C-]> g<C-]>
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
"  local setting
" ----------------------------------------
"{{{
  let s:dir = getcwd()
  let s:ans = findfile(".vimrc.local", fnameescape(s:dir).";")

  if len(s:ans) > 1
    let s:rc = fnamemodify(s:ans, ":p:h")."/.vimrc.local"
    call feedkeys(";source".s:rc."\<cr>")
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
"  augroup settings
" ----------------------------------------
"{{{
  augroup diffWrap
    au!
    au FilterWritePre * if &diff | setlocal wrap | endif
  augroup END
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
    \]
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  nmap <silent> gfo <Plug>(coc-format)
  " Remap for rename current word
  nmap <leader>rn <Plug>(coc-rename)
  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')
  " Use K for show documentation in preview window
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
  inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
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
  imap <c-x><c-k> <plug>(fzf-complete-word)
  imap <c-x><c-f> <plug>(fzf-complete-path)
  imap <c-x><c-j> <plug>(fzf-complete-file-ag)
  imap <c-x><c-l> <plug>(fzf-complete-line)
"}}}

" ----------------------------------------
"  columnskip setting
" ----------------------------------------
"{{{
  nmap <silent>\h <Plug>(columnskip:nonblank:next)
  omap <silent>\h <Plug>(columnskip:nonblank:next)
  xmap <silent>\h <Plug>(columnskip:nonblank:next)
  nmap <silent>\t <Plug>(columnskip:nonblank:prev)
  omap <silent>\t <Plug>(columnskip:nonblank:prev)
  xmap <silent>\t <Plug>(columnskip:nonblank:prev)
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
" カーソルライン設定
  set cursorline
  augroup cch
    au!
    autocmd WinLeave * set nocursorline
    autocmd WinEnter,BufRead * set cursorline
  augroup END
  if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
  endif
"}}}

" ----------------------------------------
"  treesitter setting
" ----------------------------------------
"{{{
lua << EOF
  require'nvim-treesitter.configs'.setup {
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    }
  }
EOF
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
"  gitsigns setting
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
"  plugin setting
" ----------------------------------------
"{{{
  let g:lightline = {'colorscheme': 'wombat'}
  let g:indentLine_char = '|'
  vmap <Enter> <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
  nmap ldo <Plug>(gina-diffget-l)
  nmap rdo <Plug>(gina-diffget-r)
  nnoremap gL :JpFormatAll!<CR>
  let g:user_emmet_install_global = 0
  autocmd FileType html,css,php,markdown,javascript,javascriptreact,typescriptreact,eruby EmmetInstall
  let g:fzf_preview_window = ''
  let g:fzf_buffers_jump = 1
  let g:fzf_layout = { 'down': '40%' }
  if !exists('g:tcomment_types')
    let g:tcomment_types = {}
  endif
  let g:tcomment_types['blade'] = '{{-- %s --}}'
  let g:tcomment_types['eruby'] = '<%# %s %>'
  cnoremap <CR> <Plug>(kensaku-search-replace)<CR>
  nmap __ <Plug>(operator-replace)
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

" vim: set ts=2 sw=2 fdm=marker :
