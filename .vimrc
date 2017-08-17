" ~/.vimrc (configuration file for vim only)

" Description {{{
" This vimrc can load computer specific vimrcs before and after it actually
" loads.
"
" The first vimrc loaded should be named:
"   ~/.<HOSTNAME>.before.vimrc
"
"   This file should set the following optional variables:
"   g:workspace            The environmental variable containing the current
"                          workspace. The variable should include the dollar
"                          sign in it's definition.
"   g:developmentUsername  The username of the development account.
"   g:javaCompiler         The build tool used for java.
"   g:charLimit            The amount of characters allowed per line
"
"   Example File Contents:
"
"   let g:workspace="$WORKSPACE"
"   let g:developmentUsername="matt"
"   let g:javaCompiler="gradle"
"   let g:charLimit=80
"
" The last vimrc loaded should be named:
"   ~/.<HOSTNAME>.after.vimrc
"
"   This file should be predominantly used to undo settings or define
"   functions useful in that environment.
"
" }}}
"
" TODO: Separate all features based on the vim version.
" TODO: Improve comments on the functions.
" TODO: get rid of all abbreviated commands

" Uncomment to debug this vimrc
" set verbose=15
" set verbosefile=~/vimLog.txt

" Get the hostname
let s:hostname = substitute(system('hostname'), '\n', '', '')

" To toggle open/close a fold type 'za'
" To open all folds type 'zR'
" To close all folds type 'zM'

" Before vimrc {{{
    let s:beforeFile="~/." . s:hostname . ".before.vimrc"
    if filereadable(expand(s:beforeFile))
        execute "source " . s:beforeFile
    endif

    if !exists("g:developmentUsername")
        let g:developmentUsername = $USER
    endif
    if !exists("g:charLimit")
        let g:charLimit = 80
    endif
" }}}
" Color Scheme {{{
" ========================================================================
" =                           Description
" ========================================================================
" This section is to set any settings that effect the color scheme of a generic
" file. File type specific schemes should be in syntax files.
" ========================================================================
    syntax on
    " Normal settings {{{
        highlight Normal term=none cterm=none ctermfg=White ctermbg=Black gui=none guifg=White guibg=Black
    " }}}
    " VimDiff settings {{{
        highlight DiffAdd cterm=none ctermfg=Black ctermbg=DarkGreen gui=none guifg=fg guibg=Green
        highlight DiffDelete cterm=none ctermfg=Black ctermbg=DarkRed gui=none guifg=fg guibg=Red
        highlight DiffChange cterm=none ctermfg=Black ctermbg=DarkYellow  gui=none guifg=fg guibg=Orange
        highlight DiffText cterm=none ctermfg=Black ctermbg=White gui=none guifg=bg guibg=White
    " }}}
    " Tab settings {{{
        highlight TabLineSel cterm=none ctermfg=Black ctermbg=White gui=none guifg=fg guibg=Green
        highlight TabLineFill cterm=none ctermfg=White ctermbg=Black gui=none guifg=fg guibg=Green
    " }}}
" }}}
" Shell Correction {{{
    " Making Ctrl+arrow keys handle like Ctrl+arrow keys in putty.
    map <ESC>[D <C-Left>
    map <ESC>[C <C-Right>
    map <ESC>[A <C-Up>
    map <ESC>[B <C-Down>

    map! <ESC>[D <C-Left>
    map! <ESC>[C <C-Right>
    map! <ESC>[A <C-Up>
    map! <ESC>[B <C-Down>
" }}}
" Tab Management {{{
    if v:version >= 700 " {{{
        " Ctrl-Left goes to previous tab
        nnoremap <C-Left> :tabprevious<CR>
        " Ctrl-Right goes to next tab
        nnoremap <C-Right> :tabnext<CR>
        " Ctrl-Up moves tab left
        nnoremap <silent> <C-Up> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
        " Ctrl-Down moves tab right
        nnoremap <silent> <C-Down> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>
    endif " }}}
" }}}
" Settings {{{
    " Set leader to ,
    let mapleader = ","

    " Don't be compatible with vi
    set nocompatible

    " Fixes backspace on certain systems
    set backspace=2

    " Set to auto read when a file is changed from the outside
    set autoread

    " Visual autocomplete for command menu
    set wildmenu

    " Visual autocomplete for command menu
    set enc=utf-8

    " Open man files with ':Man [command name]'
    source $VIMRUNTIME/ftplugin/man.vim

    " Detect filetype
    filetype indent on

    " Search modifiers {{{
        set hlsearch
        set incsearch
    " }}}

    " Visual Settings {{{
        " Number the lines
        set number

        " Always show current position in the bottom right
        set ruler

        " Spell check
        set spell

        if v:version >= 700 " {{{
            " Highlight current line
            set cursorline
        endif " }}}

        " Don't resize windows on close
        set noequalalways
    " }}}
    " Indentation modifiers {{{
        set tabstop=4
        set shiftwidth=4
        set softtabstop=4
    " }}}
" }}}
" Mappings {{{
    " Ctrl-Space initiates auto-complete {{{
        inoremap <Nul> <C-n>
    " }}}
    " Resizing windows {{{
        nnoremap <C-o> <C-w>>
        nnoremap <C-p> <C-w><
    " }}}
    " Traversing wrapped lines as if they were separate lines {{{
        " Moving up
        nnoremap <Up> gk
        " Moving down
        nnoremap <Down> gj
    " }}}
    " Insert lines without going into insert mode {{{
        " Insert a line below the current line and then go back to the current
        " line.
        nmap <leader>o o<Esc>k
        " Insert a line above the current line and then go back to the current
        " line.
        nmap <leader>p O<Esc>
    " }}}
    " Switch buffers {{{
        nnoremap <C-n> :bn<CR>
        nnoremap <C-p> :bp<CR>
    " }}}
" }}}
" Aliases {{{
    " Aliases for spelling correction purposes {{{
        cnoreabbrev W w
        cnoreabbrev Q q
        cnoreabbrev QA qa
        cnoreabbrev Qa qa
        cnoreabbrev q!! q!
    " }}}
    " Aliases to save typing {{{
        cnoreabbrev te tabedit
        cnoreabbrev vs vsplit
        exe "cnoreabbrev so so /home/" . g:developmentUsername . "/.vimrc"
        if v:version >= 700 " {{{
            cnoreabbrev te tabedit
            exe "cnoreabbrev mod tabedit /home/" . g:developmentUsername . "/.vimrc"
        " }}}
        else " {{{
            cnoreabbrev te edit
            exe "cnoreabbrev mod edit /home/" . g:developmentUsername . " /.vimrc"
        endif " }}}
    " }}}
    " Aliases to User Functions {{{
        cnoreabbrev FL) FL0
    " }}}
" }}}
" FileType specific functions {{{
    " Vimrc {{{
        autocmd FileType vim call VimrcSettings()
        function! VimrcSettings()
            execute 'match Error /\%' . string(g:charLimit+1) . 'v.\+/'
            setlocal autoindent
            setlocal expandtab
            setlocal smarttab
            " Is the reason all the stupid triple curly braces exist in this
            " file.
            setlocal foldmethod=marker
            " shows the fold levels on the right of the file
            setlocal foldcolumn=3
            " Don't wrap the lines
            setlocal wrap!
            setlocal autoindent
            execute 'noremap <buffer> <leader>k oecho "' . g:developmentUsername . ':" <Esc>'
            execute 'noremap <buffer> <leader>l oecho "' . g:developmentUsername . ':" <Esc>i'
        endfunction
    " }}}
    " C and C++ {{{
        autocmd FileType c call CSettings()
        function! CSettings()
            execute 'match Error /\%' . string(g:charLimit+1) . 'v.\+/'
            setlocal foldlevel=99
            setlocal autoindent
            setlocal expandtab
            setlocal smarttab
            setlocal foldmethod=syntax
            if exists("g:workspace")
                exe "cd " . g:workspace . " /src"
                exe "setlocal tags=" . g:workspace . " /tags"
            endif
            setlocal cindent
            " traces
            execute 'noremap <buffer> <leader>k ostd::cout << "' . g:developmentUsername . ':" <<__PRETTY_FUNCTION__ << " :" << std::endl;<Esc>'
            execute 'noremap <buffer> <leader>l ostd::cout << "' . g:developmentUsername . ':" <<__PRETTY_FUNCTION__ << " :" << std::endl;<Esc>14hi'
        endfunction
    " }}}
    " Python {{{
        autocmd FileType python call PythonSettings()
        function! PythonSettings()
            setlocal expandtab
            setlocal autoindent
            " traces
            setlocal foldmethod=indent
            execute 'noremap <buffer> <leader>k oprint "' . g:developmentUsername . ':" <Esc>'
            execute 'noremap <buffer> <leader>l oprint "' . g:developmentUsername . ':" <Esc>hi'
        endfunction
    " }}}
    " Java {{{
        autocmd FileType java call JavaSettings()
        function! JavaSettings()
            execute 'match Error /\%' . string(g:charLimit+1) . 'v.\+/'
            setlocal foldlevel=99
            setlocal autoindent
            setlocal expandtab
            setlocal smarttab
            if exists("g:workspace")
                execute "cd " . g:workspace
            endif
            setlocal foldmethod=syntax
            if exists("g:javaCompiler")
                execute "compiler! " . g:javaCompiler
            endif
            let &errorformat =
                \ '%E%\m:%\%%(compileJava%\|compileTarget%\)%f:%l: error: %m,' .
                \ '%E%f:%l: error: %m,' .
                \ '%Z%p^,' .
                \ '%-G%.%#'
            " traces
            execute 'noremap <buffer> <leader>k oSystem.out.println("' . g:developmentUsername . ':" + " ");<Esc>'
            execute 'noremap <buffer> <leader>l oSystem.out.println("' . g:developmentUsername . ':" + " ");<Esc>2hi'
        endfunction
    " }}}
    " Xml {{{
        autocmd BufNewFile,BufRead *.xml call XmlSettings()
        function! XmlSettings()
            setlocal foldlevel=99
            setlocal expandtab
            setlocal autoindent
            setlocal foldmethod=syntax
        endfunction
    " }}}
    " Bash {{{
        autocmd FileType sh call BashSettings()
        function! BashSettings()
            setlocal autoindent
            setlocal expandtab
            setlocal smarttab
            " traces
            execute 'noremap <buffer> <leader>k oecho "' . g:developmentUsername . ': " <Esc>'
            execute 'noremap <buffer> <leader>l oecho "' . g:developmentUsername . ': " <Esc>i'
            " new comment above the line where the command takes place
            noremap <buffer> <leader>c :setlocal noautoindent<Enter>O#    <Esc>:setlocal autoindent<Enter>i
            setlocal foldmethod=syntax
        endfunction
    " }}}
" }}}
" After vimrc {{{
    let s:afterFile="~/." . s:hostname . ".after.vimrc"
    if filereadable(expand(s:afterFile))
        execute "source " . s:afterFile
    endif
" }}}
" ~/.vimrc ends here
