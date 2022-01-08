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
Plug 'rking/ag.vim'
Plug 'cespare/vim-toml'
Plug 'itchyny/lightline.vim'
  let g:lightline = { 
  \   'colorscheme': 'wombat'
  \}
Plug 'vim-scripts/surround.vim'
Plug 'Yggdroot/indentLine'
  let g:indentLine_char = '|'
Plug 'junegunn/vim-easy-align'
  vmap <Enter> <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'vim-denops/denops.vim'
Plug 'vim-denops/denops-helloworld.vim'
Plug 'yuki-yano/fuzzy-motion.vim'
Plug 'hrsh7th/vim-searchx'
Plug 'fuenor/JpFormat.vim'
  nnoremap gL :JpFormatAll!<CR>
Plug 'mattn/emmet-vim'
  let g:user_emmet_install_global = 0
  autocmd FileType html,css,php,markdown,javascript,javascriptreact,eruby EmmetInstall
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
  let g:fzf_preview_window = ''
  let g:fzf_buffers_jump = 1
  let g:fzf_layout = { 'down': '40%' }
Plug 'terryma/vim-expand-region'
  vmap v <Plug>(expand_region_expand)
  vmap <C-v> <Plug>(expand_region_shrink)
Plug 'neoclide/coc.nvim'
Plug 'tomtom/tcomment_vim'
  if !exists('g:tcomment_types')
    let g:tcomment_types = {}
  endif
  let g:tcomment_types['blade'] = '{{-- %s --}}'
  let g:tcomment_types['eruby'] = '<%# %s %>'
Plug 'haya14busa/vim-migemo'
Plug 'tyru/columnskip.vim'
Plug 'christianchiarulli/nvcode-color-schemes.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'digitaltoad/vim-pug', { 'for': 'pug' }
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
    autocmd BufWritePre *.html,*.css,*.scss,*.sass,*.less,*.php,*.rb,*.js,*.haml,*.erb,*.txt,*.ejs,*.jade,*.pug,*.ts call <SID>remove_dust()
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
"  cocの設定
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
    \, 'coc-fzf-preview'
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
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"}}}

" ----------------------------------------
"  window
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
"  キーマッピング設定
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
" 半ページ移動(中央維持
  " noremap H <C-u>zz
  " noremap L <C-d>zz
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
  nnoremap <Leader>Q :q!<CR>
" 同単語検索設定
  nnoremap * *N
" 全角で書かないようにする
  inoremap （ (
  inoremap ） )
  inoremap ｛ {
  inoremap ｝ }
  inoremap ； ;
  inoremap ： :
  inoremap ｜ \|
  inoremap ＜ <
  inoremap ＞ >
  inoremap ＊ *
  inoremap ＠ @
  inoremap － -
  inoremap ％ %
  inoremap ＃ #
  inoremap ” "
  inoremap ’ '
  inoremap ＋ +
  inoremap ０ 0
  inoremap １ 1
  inoremap ２ 2
  inoremap ３ 3
  inoremap ４ 4
  inoremap ５ 5
  inoremap ６ 6
  inoremap ７ 7
  inoremap ８ 8
  inoremap ９ 9
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
  " nnoremap <Leader>l :nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-l>
" ctagsのタグジャンプ
  nnoremap <C-]> g<C-]>
" screenコマンドとタグジャンプがバッティングするので変更
  nnoremap <silent><C-b> :pop<CR>
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
"  augroup settings
" ----------------------------------------
"{{{
  augroup diffWrap
    au!
    au FilterWritePre * if &diff | setlocal wrap | endif
  augroup END
"}}}

" ----------------------------------------
"  fuzzy-moitonの設定
" ----------------------------------------
"{{{
  nnoremap ss :FuzzyMotion<CR>
  let g:fuzzy_motion_labels = [
        \ 'A', 'O', 'E', 'U', 'I', 'D', 'H', 'T', 'N', 'S', 'P', 'Y', 'F', 'G', 'C', 'R', 'L', 'Q', 'J', 'K', 'X', 'B', 'M', 'W', 'V', 'Z' 
        \ ]
"}}}

" ----------------------------------------
"  searchxの設定
" ----------------------------------------
"{{{
  " Overwrite / and ?.
  nnoremap ? <Cmd>call searchx#start({ 'dir': 0 })<CR>
  nnoremap / <Cmd>call searchx#start({ 'dir': 1 })<CR>
  xnoremap ? <Cmd>call searchx#start({ 'dir': 0 })<CR>
  xnoremap / <Cmd>call searchx#start({ 'dir': 1 })<CR>
  " cnoremap \ <Cmd>call searchx#select()<CR>

  " Move to next/prev match.
  nnoremap R <Cmd>call searchx#prev_dir()<CR>
  nnoremap r <Cmd>call searchx#next_dir()<CR>
  xnoremap R <Cmd>call searchx#prev_dir()<CR>
  xnoremap r <Cmd>call searchx#next_dir()<CR>
  nnoremap <C-k> <Cmd>call searchx#prev()<CR>
  nnoremap <C-j> <Cmd>call searchx#next()<CR>
  xnoremap <C-k> <Cmd>call searchx#prev()<CR>
  xnoremap <C-j> <Cmd>call searchx#next()<CR>
  cnoremap <C-k> <Cmd>call searchx#prev()<CR>
  cnoremap <C-j> <Cmd>call searchx#next()<CR>

  " Clear highlights
  nnoremap <C-l> <Cmd>call searchx#clear()<CR>

  let g:searchx = {}

  " Auto jump if the recent input matches to any marker.
  let g:searchx.auto_accept = v:true

  " The scrolloff value for moving to next/prev.
  let g:searchx.scrolloff = &scrolloff

  " To enable scrolling animation.
  let g:searchx.scrolltime = 300

  " Marker characters.
  let g:searchx.markers = split('ABCDEFGHIJKLMNOPQRSTUVWXYZ', '.\zs')

  " Convert search pattern.
  function g:searchx.convert(input) abort
    if a:input !~# '\k'
      return '\V' .. a:input
    endif
    return join(split(a:input, ' '), '.\{-}')
  endfunction
"}}}

" ----------------------------------------
"  vim-surroundの設定
" ----------------------------------------
"{{{
  let g:surround_no_mappings = 1
  nmap es  <Plug>Dsurround
  nmap cs  <Plug>Csurround
  nmap ys  <Plug>Ysurround
  nmap yS  <Plug>YSurround
  nmap yss <Plug>Yssurround
  nmap ySs <Plug>YSsurround
  nmap ySS <Plug>YSsurround
  xmap S   <Plug>VSurround
  xmap gS  <Plug>VgSurround
  if !exists("g:surround_no_insert_mappings") || ! g:surround_no_insert_mappings
    if !hasmapto("<Plug>Isurround","i") && "" == mapcheck("<C-S>","i")
      imap <C-S> <Plug>Isurround
    endif
    imap <C-G>s <Plug>Isurround
    imap <C-G>S <Plug>ISurround
  endif
"}}}

" ----------------------------------------
"  fzfの設定
" ----------------------------------------
"{{{
  set rtp+=/opt/homebrew/opt/fzf
  nnoremap <silent>: :Buffers<CR>'
  nnoremap <silent>q: :History:<CR>'
  nnoremap <silent><Leader>? :GFiles?<CR>'
  nnoremap <silent><Leader>u :GFiles<CR>'
  nnoremap <silent><Leader>d :History<CR>'
  " Insert mode completion
  imap <c-x><c-k> <plug>(fzf-complete-word)
  imap <c-x><c-f> <plug>(fzf-complete-path)
  imap <c-x><c-j> <plug>(fzf-complete-file-ag)
  imap <c-x><c-l> <plug>(fzf-complete-line) 
  nnoremap <silent>r :Tags<CR>
"}}}

" ----------------------------------------
"  columnskipの設定
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
" CocList grepを実行する
  function CocGrep()
    CocList grep
  endfunction
  command! -nargs=0 Grep :call CocGrep()
  nnoremap <ESC><ESC>g :Grep<CR>
" git blameコマンド実行
  function Gblame()
    Git blame
  endfunction
  command! Gblame :call Gblame()
"}}}

" ----------------------------------------
"  色設定
" ----------------------------------------
"{{{
" カラースキーム決定
  set t_Co=256
  syntax on
  let g:nvcode_termcolors=256
  colorscheme nvcode
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
"  treesitterの設定
" ----------------------------------------
"{{{
lua << EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    }
  }
EOF
"}}}

" Dovorak 設定
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

" vim: set ts=2 sw=2 :
