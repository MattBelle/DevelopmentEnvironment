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
"   This file should be predominantly used to undo settings or define functions useful in that
"   environment.
"
" }}}

" Uncomment to debug this vimrc
" set verbose=15
" set verbosefile=~/vimLog.txt

" Get the hostname
let s:hostname = substitute(system('hostname'), '\n', '', '')

" To toggle open/close a fold type 'za'.
" To open all folds type 'zR'.
" To close all folds type 'zM'.

" Before vimrc {{{
    let s:beforeFile="~/." . s:hostname . ".before.vimrc"
    if filereadable(expand(s:beforeFile))
        execute "source " . s:beforeFile
    endif

    " Set default values for all expected global variables.
    if !exists("g:developmentUsername")
        let g:developmentUsername = $USER
    endif

    if !exists("g:charLimit")
        let g:charLimit = 80
    endif
" }}}
" Color Scheme {{{
    " This section is to set any settings that effect the color scheme of a generic file. File type
    " specifics schemes should be in syntax files.
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
    " Custom Categories {{{
        highlight CharLimit ctermbg=Red guibg=Red
        highlight TrailingWhitespace ctermbg=Red guibg=Red
    " }}}
        if version >= 702
            " This should fix performance issues caused by a memory leak in vim. This should not
            " negatively effect experience since matches are made every time BufWinEnter is called
            " which is called every time a buffer is displayed.
            autocmd BufWinLeave * call clearmatches()
        endif
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
        " Ctrl-Left switches to previous tab.
        nnoremap <C-Left> :tabprevious<CR>
        " Ctrl-Right switches to next tab.
        nnoremap <C-Right> :tabnext<CR>
        " Ctrl-Up moves tab left.
        nnoremap <silent> <C-Up> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
        " Ctrl-Down moves tab right.
        nnoremap <silent> <C-Down> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>
    endif " }}}
" }}}
" Settings {{{
    " Set leader to ','.
    let mapleader = ","

    " Don't be compatible with vi.
    set nocompatible

    " Fixes backspace on certain systems.
    set backspace=2

    " Auto read when a file is changed from the outside.
    set autoread

    " Enable visual autocomplete for command menu.
    set wildmenu

    " Enable utf-8 encoding.
    set encoding=utf-8

    " Open man files with ':Man [command name]'.
    source $VIMRUNTIME/ftplugin/man.vim

    " Enable file type detection as well as the loading of file type specific indent files.
    filetype indent on

    " Search modifiers {{{
        " Highlight all matches to the last search pattern.
        set hlsearch
        " Jump to the first match of the search pattern being typed as it is typed.
        set incsearch
    " }}}

    " Visual Settings {{{
        " Display the line number.
        set number

        " Always show the current cursor position in the bottom right corner of the screen.
        set ruler

        " Enable spell check.
        set spell

        if v:version >= 700 " {{{
            " Highlight the current line that the cursor is on.
            set cursorline
        endif " }}}

        " Don't resize windows on close.
        set noequalalways
    " }}}
    " Indentation modifiers {{{
        " Set a tab to being visually identical to 4 spaces.
        set tabstop=4
        " Set the number of spaces to use when auto-indenting.
        set shiftwidth=4
        " Set the number of spaces inserted into a file when hitting the tab key in insert mode.
        set softtabstop=4
    " }}}
" }}}
" Mappings {{{
    " Ctrl-Space initiates auto-complete {{{
        inoremap <Nul> <C-n>
    " }}}
    " Resizing windows {{{
        " Increases the window size.
        nnoremap <C-o> <C-w>>
        " Decreases the window size.
        nnoremap <C-p> <C-w><
    " }}}
    " Traversing wrapped lines as if they were separate lines {{{
        " Moving up
        nnoremap <Up> gk
        " Moving down
        nnoremap <Down> gj
    " }}}
    " Insert lines without going into insert mode {{{
        " Insert a line below the current line and then go back to the current line.
        nmap <leader>o o<Esc>k
        " Insert a line above the current line and then go back to the current line.
        nmap <leader>p O<Esc>
    " }}}
    " Switch buffers {{{
        " Switch to the next buffer.
        nnoremap <C-n> :bn<CR>
        " Switch to the previous buffer.
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
        cnoreabbrev vs vsplit
        exe "cnoreabbrev so so /home/" . g:developmentUsername . "/.vimrc"
        if v:version >= 700 " {{{
            cnoreabbrev te tabedit
            exe "cnoreabbrev mod tabedit /home/" . g:developmentUsername . "/.vimrc"
        " }}}
        else " {{{
            cnoreabbrev te edit
            exe "cnoreabbrev mod edit /home/" . g:developmentUsername . "/.vimrc"
        endif " }}}
    " }}}
    " Aliases to User Functions {{{
        cnoreabbrev FL) FL0
    " }}}
" }}}
" FileType specific functions {{{
    " Vimscript {{{
        autocmd FileType vim call VimscriptSettings()
        function! VimscriptSettings()
            call matchadd('TrailingWhitespace', '\s\+$')
            call matchadd('CharLimit', '\%' . string(g:charLimit+1) . 'v.\+')
            execute 'setlocal textwidth=' . string(g:charLimit)

            setlocal autoindent
            setlocal expandtab
            setlocal foldcolumn=3 " Shows the fold levels on the left of the buffer's window.
            setlocal foldmethod=marker " Fold on triple curly-braces.
            setlocal smarttab
            setlocal wrap! " Don't wrap the lines.

            " Hotkey generic a trace statement for easy insertion.
            execute 'noremap <buffer> <leader>k oecho "' . g:developmentUsername . ':" <Esc>'
            execute 'noremap <buffer> <leader>l oecho "' . g:developmentUsername . ':" <Esc>i'
        endfunction
    " }}}
    " C {{{
        autocmd FileType c call CSettings()
        function! CSettings()
            call matchadd('TrailingWhitespace', '\s\+$')
            call matchadd('CharLimit', '\%' . string(g:charLimit+1) . 'v.\+')
            execute 'setlocal textwidth=' . string(g:charLimit)

            setlocal autoindent
            setlocal cindent
            setlocal expandtab
            setlocal foldlevel=99
            setlocal foldmethod=syntax
            setlocal smarttab

            " Hotkey generic a trace statement for easy insertion.
            execute 'noremap <buffer> <leader>k oprintf("' . g:developmentUsername . ':");<Esc>'
            execute 'noremap <buffer> <leader>l oprintf("' . g:developmentUsername . ':");<Esc>2hi'

            if exists("g:workspace")
                exe "cd " . g:workspace . "/src"
                exe "setlocal tags=" . g:workspace . "/tags"
            endif
        endfunction
    " }}}
    " C++ {{{
        autocmd FileType cpp call CppSettings()
        function! CppSettings()
            call matchadd('TrailingWhitespace', '\s\+$')
            call matchadd('CharLimit', '\%' . string(g:charLimit+1) . 'v.\+')
            execute 'setlocal textwidth=' . string(g:charLimit)

            setlocal autoindent
            setlocal cindent
            setlocal expandtab
            setlocal foldlevel=99
            setlocal foldmethod=syntax
            setlocal smarttab

            " Hotkey generic a trace statement for easy insertion.
            execute 'noremap <buffer> <leader>k ostd::cout << "' . g:developmentUsername . ':" <<__PRETTY_FUNCTION__ << " :" << std::endl;<Esc>'
            execute 'noremap <buffer> <leader>l ostd::cout << "' . g:developmentUsername . ':" <<__PRETTY_FUNCTION__ << " :" << std::endl;<Esc>14hi'

            if exists("g:workspace")
                exe "cd " . g:workspace . "/src"
                exe "setlocal tags=" . g:workspace . "/tags"
            endif
        endfunction
    " }}}
    " Java {{{
        autocmd FileType java call JavaSettings()
        function! JavaSettings()
            call matchadd('TrailingWhitespace', '\s\+$')
            call matchadd('CharLimit', '\%' . string(g:charLimit+1) . 'v.\+')
            execute 'setlocal textwidth=' . string(g:charLimit)

            setlocal autoindent
            setlocal expandtab
            setlocal foldlevel=99
            setlocal foldmethod=syntax
            setlocal smarttab

            " Hotkey generic a trace statement for easy insertion.
            execute 'noremap <buffer> <leader>k oSystem.out.println("' . g:developmentUsername . ':" + " ");<Esc>'
            execute 'noremap <buffer> <leader>l oSystem.out.println("' . g:developmentUsername . ':" + " ");<Esc>2hi'

            if exists("g:workspace")
                execute "cd " . g:workspace
            endif

            if exists("g:javaCompiler")
                execute "compiler! " . g:javaCompiler
            endif

            let &errorformat =
                \ '%E%\m:%\%%(compileJava%\|compileTarget%\)%f:%l: error: %m,' .
                \ '%E%f:%l: error: %m,' .
                \ '%Z%p^,' .
                \ '%-G%.%#'
        endfunction
    " }}}
    " Python {{{
        autocmd FileType python call PythonSettings()
        function! PythonSettings()
            call matchadd('TrailingWhitespace', '\s\+$')

            setlocal expandtab
            setlocal autoindent
            setlocal foldmethod=indent

            " Hotkey generic a trace statement for easy insertion.
            execute 'noremap <buffer> <leader>k oprint "' . g:developmentUsername . ':" <Esc>'
            execute 'noremap <buffer> <leader>l oprint "' . g:developmentUsername . ':" <Esc>hi'
        endfunction
    " }}}
    " Bash {{{
        autocmd FileType sh call BashSettings()
        function! BashSettings()
            call matchadd('TrailingWhitespace', '\s\+$')
            execute 'setlocal textwidth=' . string(g:charLimit)

            setlocal autoindent
            setlocal expandtab
            setlocal smarttab
            setlocal foldmethod=syntax

            " Hotkey generic a trace statement for easy insertion.
            execute 'noremap <buffer> <leader>k oecho "' . g:developmentUsername . ': " <Esc>'
            execute 'noremap <buffer> <leader>l oecho "' . g:developmentUsername . ': " <Esc>i'
        endfunction
    " }}}
    " Xml {{{
        autocmd FileType xml call XmlSettings()
        function! XmlSettings()
            setlocal autoindent
            setlocal expandtab
            setlocal foldlevel=99
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
