if !exists('g:vscode')
    call plug#begin('~/.vim/plug')
    Plug 'iCyMind/NeoSolarized'
    Plug 'vim-syntastic/syntastic'
    Plug 'posva/vim-vue'
    Plug 'digitaltoad/vim-pug'
    Plug 'leafgarland/typescript-vim'
    Plug 'genoma/vim-less'
    Plug 'captbaritone/better-indent-support-for-php-with-html'
    Plug 'scrooloose/nerdtree'
    Plug 'itchyny/lightline.vim'
    Plug 'scrooloose/nerdcommenter'
    Plug 'majutsushi/tagbar'
    Plug 'google/vim-searchindex'
    Plug 'tpope/vim-surround'
    Plug 'junegunn/vim-slash'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'ryanoasis/vim-devicons'
    " Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    call plug#end()

    if !has('nvim')
        if has("gui_running")
            " GUI is running or is about to start.
            set guioptions-=m  "remove menu bar
            set guioptions-=T  "remove toolbar
            set guioptions-=r  "remove right-hand scroll bar
            set guioptions-=L  "remove left-hand scroll bar
            set lines=999 columns=999 " Maximize gvim window (for an alternative on Windows, see simalt below).
        else
            " This is console Vim.
            if exists("+lines")
                set lines=50
            endif

            if exists("+columns")
                set columns=100
            endif
        endif
    endif

    set termguicolors
    colorscheme NeoSolarized
    set background=dark
    set encoding=utf8 "default encoding
    set fileencoding=utf-8 "set file encoding after saving
    set nobomb "no BOM encoding
    set backspace=indent,eol,start "allow backspacing over everything in insert mode
    set tabstop=4       " number of columns for a tab
    set shiftwidth=4    " number of columns for reindent operations
    set softtabstop=4   " affects what happens when you press the <TAB> or <BS> keys
    set shiftround      " use multiple of shiftwidth when indenting with '<'
    set smarttab        " smarttab
    set expandtab       " convert tabs to spaces
    retab "replace tabs with spaces
    set autoindent      " copy the indentation from the previous line, when starting a new line
    set smartindent     " automatically inserts one extra level of indentation in some cases, and works for C-like files
    set number          " show line numbers
    set incsearch       " show search matches as you type
    set noswapfile      " disable swp files
    set cursorcolumn

    " http://vim.wikia.com/wiki/Indenting_source_code
    autocmd FileType css,javascript,json,html,htmldjango,less,pug,sass,scss,typescript,vue,yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd FileType markup,markdown setlocal tabstop=3 shiftwidth=3 softtabstop=3

    " http://vim.wikia.com/wiki/Alternative_tab_navigation
    nnoremap <C-t> :tabnew<CR>
    inoremap <C-t> <Esc>:tabnew<CR>
    nnoremap <C-x> :tabclose<CR>
    inoremap <C-x> <Esc>:tabclose<CR>

    " https://github.com/vim-syntastic/syntastic#3-recommended-settings
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0

    " https://github.com/posva/vim-vue#my-syntax-highlighting-stops-working-randomly
    autocmd FileType vue syntax sync fromstart

    " https://github.com/posva/vim-vue#vim-slows-down-when-using-this-plugin-how-can-i-fix-that
    let g:vue_pre_processors = ['pug', 'sass', 'scss', 'typescript']

    " Add spaces after comment delimiters by default
    let g:NERDSpaceDelims = 1
    " Use compact syntax for prettified multi-line comments
    let g:NERDCompactSexyComs = 1
    " Enable trimming of trailing whitespace when uncommenting
    let g:NERDTrimTrailingWhitespace = 1

    " https://github.com/posva/vim-vue#nerdcommenter
    let g:ft = ''
    function! NERDCommenter_before()
      if &ft == 'vue'
        let g:ft = 'vue'
        let stack = synstack(line('.'), col('.'))
        if len(stack) > 0
          let syn = synIDattr((stack)[0], 'name')
          if len(syn) > 0
            exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
          endif
        endif
      endif
    endfunction
    function! NERDCommenter_after()
      if g:ft == 'vue'
        setf vue
        let g:ft = ''
      endif
    endfunction

    " open NERDTree with Ctrl+n
    map <C-n> :NERDTreeToggle<CR> 
    " open a NERDTree automatically when vim starts up if no files were specified
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    let NERDTreeShowLineNumbers=1 " Show line numbers

    " https://github.com/itchyny/lightline.vim#colorscheme-configuration
    let g:lightline = { 'colorscheme': 'solarized' }

    " Tagbar
    nmap <F8> :TagbarToggle<CR>

    " Ctags
    "autocmd FileType javascript,php,python,typescript call ctags#find()

    " Prettier
    command! -nargs=0 Prettier :CocCommand prettier.formatFile

    let g:python3_host_prog = expand('/usr/bin/python3')
endif
