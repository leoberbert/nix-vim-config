syntax on                             
filetype plugin indent on             

" Search and encoding settings

set noincsearch                        " Disables incremental search; matches are only highlighted after pressing Enter
set ignorecase                         " Ignores case in search patterns for easier matching
set encoding=utf8                      " Sets file encoding to UTF-8 for better compatibility
set laststatus=2                       " Always displays the status line at the bottom of the screen
set hlsearch                           " Highlights all matches for search results to improve visibility
set showmatch                          " Briefly highlights matching parentheses, brackets, or braces
set cursorline                         " Highlights the entire line where the cursor is positioned for better focus
set nocompatible                       " Ensures Vim is not in Vi mode

"Color Scheme
colorscheme codedark

" Enables mouse support if available
if has("mouse")
    set mouse=v
endif


" Configures indentation settings specifically for HTML files
function HtmlConfig()
        set tabstop=2 softtabstop=2 expandtab shiftwidth=2
        " Sets tab, soft tab, and indentation width to 2 spaces for HTML files
endfunction

" Configures indentation settings specifically for Python files
function PythonConfig()
        set tabstop=4 softtabstop=4 expandtab shiftwidth=4
        " Sets tab, soft tab, and indentation width to 4 spaces for Python files
endfunction

" Configures indentation settings specifically for YAML files
function YamlConfig()
        set tabstop=2 softtabstop=2 expandtab shiftwidth=2 indentkeys-=0# indentkeys-=<:>
        " Sets tab, soft tab, and indentation width to 2 spaces for YAML files,
        " with custom indent keys
endfunction

" Autocommands for automatic behavior
autocmd CursorHoldI * stopinsert       " Exits Insert mode if cursor is idle for updatetime duration
autocmd FileType html call HtmlConfig()   " Applies HtmlConfig() for HTML files
autocmd FileType python call PythonConfig() " Applies PythonConfig() for Python files
autocmd FileType yaml,yml call YamlConfig() " Applies YamlConfig() for YAML files

" Status line configuration to show paste mode status, file information, working directory, 
" and cursor position details
set statusline=\ File:\ %F%m%r%h\ %w\ \ Working\ Directory:\ %r%{getcwd()}%h\ -\ Line:\ %l\ -\ Column:\ %c
" Prevents defaults.vim from overwriting these settings
let g:skip_defaults_vim = 1
