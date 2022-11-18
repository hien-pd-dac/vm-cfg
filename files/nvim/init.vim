" Reload ~/.config/nvim/init.vim and :PlugInstall to install plugins.
" PlugInstall [name ...]: install plugins with name.
" PlugUpdate [name ...]: install or update plugins.
" PlugClean[!]: remove unlisted plugins.
" PlugStatus: Check the status of plugins.
" PlugDiff: examine changes from the previous update and the pending changes.
" PlugSnapshot[!] [output path]: generate script for restoring the current
" snapshot of the plugins.

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.config/nvim/plugged')

Plug 'preservim/nerdtree'

Plug 'morhetz/gruvbox'

" Use vim-fugitive provide git command for vim
Plug 'tpope/vim-fugitive'

" Use nerdcommenter for code comment and toggle.
Plug 'preservim/nerdcommenter'

" Use ale for formatter and linter.
Plug 'dense-analysis/ale'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

Plug 'preservim/tagbar'

" Use coc-nvim for LSP client.
" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Use fzf for file/text fuzzy searching.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'luochen1990/rainbow'



Plug 'SirVer/ultisnips' " Track the engine.
Plug 'honza/vim-snippets' " Snippets are separated from the engine. Add this if you want them:
" Plug 'quangnguyen30192/cmp-nvim-ultisnips'

" Vim motions on speed, fast move to a characters or word.
Plug 'easymotion/vim-easymotion'

" Magit-like Git client
Plug 'TimUntersberger/neogit'

" Telescope use
" Plug 'nvim-telescope/telescope.nvim'

" Neovim builtin LSP config
" Plug 'neovim/nvim-lspconfig'

" nvim-cmp
" Plug 'hrsh7th/cmp-nvim-lsp'
" Plug 'hrsh7th/cmp-buffer'
" Plug 'hrsh7th/cmp-path'
" Plug 'hrsh7th/cmp-cmdline'
" Plug 'hrsh7th/nvim-cmp'

" For vsnip users.
" Plug 'rafamadriz/friendly-snippets' " various snippets for many languages
" Plug 'hrsh7th/cmp-vsnip' " config vsnip engine with nvim-cmp
" Plug 'hrsh7th/vim-vsnip' " snippet engine

" For luasnip user
" Plug 'saadparwaiz1/cmp_luasnip'
" Plug 'L3MON4D3/LuaSnip'

" nvim lsp_signature support
" Plug 'ray-x/lsp_signature.nvim'

" Git integration for buffers
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-lua/plenary.nvim'


Plug 'liuchengxu/vim-which-key'

" NOT IN USE
" post install (yarn install | npm install) then load plugin only for editing supported files
" Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" plugin for javascript syntax and indentation
" Plug 'pangloss/vim-javascript'

" plugin for vim-jsx-typescript
" Plug 'leafgarland/typescript-vim'
" Plug 'peitalin/vim-jsx-typescript'

" plugin for displaying icons on NerdTree
" Plug 'ryanoasis/vim-devicons'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

filetype plugin indent on    " required

" MY CUSTOM CONFIG
" Set directory for .swp file
set directory^=$HOME/.config/nvim/tmp//

set ignorecase
set smartcase

set autowrite
set autoread
" au FocusGained * :checktime
au BufEnter * checktime

" File type indentation behaviour
set smartindent
set autoindent

set tabstop=4
set shiftwidth=4
" set softtabstop=4
set expandtab

" for go files
autocmd Filetype go setlocal tabstop=4 shiftwidth=4 noexpandtab

" for C/C++ files
autocmd Filetype c setlocal tabstop=2 shiftwidth=2 noexpandtab
autocmd Filetype cpp setlocal tabstop=2 shiftwidth=2 noexpandtab

" for yaml files
autocmd Filetype yaml setlocal tabstop=2 shiftwidth=2 expandtab

" for sh files
autocmd Filetype sh setlocal tabstop=2 shiftwidth=2 expandtab

" for tf(terraform) files
autocmd Filetype tf setlocal tabstop=2 shiftwidth=2 expandtab

" for javascript files
autocmd Filetype javascript setlocal tabstop=2 shiftwidth=2 expandtab

set showcmd
set ruler
set number relativenumber
set cursorline                  "Highlight current line"
set noswapfile                  " Don't use swapfile
set nobackup                    " Don't create annoying backup files
set splitright                  " Vertical windows should be split to right
set splitbelow                  " Horizontal windows should split to bottom

set undofile    " Enable undo between session"
set undodir=~/.config/nvim/undodir


nnoremap / /\v
vnoremap / /\v
set incsearch
set hlsearch
set showmatch

" Set leader shortcut to a <Space> key. By default it's the backslash
" let mapleader = " "
" nnoremap <Space> <Nop>
let g:mapleader = "\<Space>"
let g:maplocalleader = '-'

" PLUGIN vim-which-key
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

nnoremap <silent> <localleader> :<c-u>WhichKey  '-'<CR>
vnoremap <silent> <localleader> :<c-u>WhichKeyVisual  '-'<CR>


" Define prefix dictionary
call which_key#register('<Space>', "g:leader_key_map_dict")
let g:leader_key_map_dict =  {}

" END vim-which-key

" nnoremap <tab> %
" vnoremap <tab> %
map <Leader>ay "+y
map <Leader>ap "+p
let g:leader_key_map_dict['a'] = {
      \ 'name' : '+action' ,
      \ 'y' : ['"+y'     , 'copy-to-sys-clipboard']          ,
      \ 'p' : ['"+p'       , 'paste-from-sys-clipboard']          ,
      \ }
" turn off highlight search
nmap <ESC> :noh<CR>

" Allow y and p to connect with sys-clipboard
" set clipboard=unnamedplus

" resize panes
nnoremap <silent> <C-w>> :vertical resize +20<cr>
nnoremap <silent> <C-w>< :vertical resize -20<cr>
nnoremap <silent> <C-w>+ :resize +10<cr>
nnoremap <silent> <C-w>- :resize -10<cr>

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

inoremap jk <ESC>


" clear all of another buffers
" command! BufOnly execute '%bdelete|edit #|normal `"'
" auto remove trailing spaces
" autocmd BufWritePre * :%s/\s\+$//e

" CUSTOMIZE PLUGINS

" " ----- Plugin coc.nvim -----
" Disable warning about version of neovim that coc.nvim works the best.
" let g:coc_disable_startup_warning = 1

" Install missing extensions
" let g:coc_global_extensions = ['coc-json', 'coc-go', 'coc-git', 'coc-sh', 'coc-snippets']
let g:coc_global_extensions = ['coc-tsserver', 'coc-java', 'coc-snippets']
" May use for js
" let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier']

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" " Use `[g` and `]g` to navigate diagnostics
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)

" " GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" " Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" " Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" " Symbol renaming.
nmap <Leader>crk <Plug>(coc-rename)
" Apply AutoFix to problem on the current line.
nmap <Leader>cf <Plug>(coc-fix-current)

" Add `:Format` command to format current buffer.
" autocmd BufWrite *.go :call CocAction('format')
" " Add (Neo)Vim's native statusline support.
" " NOTE: Please see `:h coc-status` for integrations with external plugins that
" " provide custom statusline: lightline.vim, vim-airline.

" Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap <expr><C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <expr><C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <expr><C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<Right>"
inoremap <expr><C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<Left>"

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <leader>cd  :<C-u>CocList diagnostics<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <leader>co  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <leader>cs  :<C-u>CocList -I symbols<cr>

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" comment because it slowdowns my neovim.
" autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')


" ----- Plugin NERDCommenter -----
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'javascript': { 'left': '{/*','right': '*/}' } }

map <leader>cc <plug>NERDCommenterComment
map <leader>ci <plug>NERDCommenterInvert
" END NERDCommenter
"
let g:leader_key_map_dict['c'] = {
      \ 'name' : '+code' ,
      \ 'r'   : ['<Plug>(coc-rename)'              , 'rename'],
      \ 'f'       : ['CocFix'                      , 'quick-fix'],
      \ 'd'       : ['CocDiagnostics'              , 'diagnostic']          ,
      \ 'o'       : ['<C-u>CocList outline'        , 'outline']          ,
      \ 's'       : ['<C-u>CocList -I symbols'     , 'list-symbols']          ,
      \ 'c'       : {
          \ 'name': "+comment",
          \ 'c': ['<plug>(NERDCommenterComment)', 'comment'],
          \ 'i': ['<plug>(NERDCommenterInvert)', 'invert-comment'],
          \},
      \ }
" TODO: let <leader>cc show +comment in vim-which-key
" ----- end coc.nvim -----

" ----- Plugin tagbar -----
" show relative line numbers.
let g:tagbar_show_linenumbers = 2
" open vertically
let g:tagbar_position = 'rightbelow vertical'
let g:tagbar_indent = 2
nnoremap <silent> <Leader>tt :TagbarToggle<CR>
"----- end tagbar -----

" ----- Plugin NERDTree -----
" enable line numbers
let NERDTreeShowLineNumbers=1
" make sure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber

" Dont use <C-m> because it will the same when press <Enter>=<C-m>
nnoremap <C-t> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" let g:NERDTreeIndicatorMapCustom = {
    " \ "Modified"  : "✹",
    " \ "Staged"    : "✚",
    " \ "Untracked" : "✭",
    " \ "Renamed"   : "➜",
    " \ "Unmerged"  : "═",
    " \ "Deleted"   : "✖",
    " \ "Dirty"     : "✗",
    " \ "Clean"     : "✔︎",
    " \ 'Ignored'   : '☒',
    " \ "Unknown"   : "?"
    " \ }
let NERDTreeShowHidden=1
" ----- end NERDTree -----



" ----- Plugin vim-airline -----
"
" enable beautiful tab format with vim-airline
let g:airline#extensions#tabline#enabled = 0
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.colnr = ' ㏇:'
let g:airline_symbols.colnr = ' ℅:'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = ' ␊:'
let g:airline_symbols.linenr = ' ␤:'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'
" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
" let g:airline_symbols.colnr = ' :'
let g:airline_symbols.colnr = ' C:'
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ' :'
let g:airline_symbols.maxlinenr = '☰ '
let g:airline_symbols.dirty='⚡'
" old vim-powerline symbols
" let g:airline_left_sep = '⮀'
" let g:airline_left_alt_sep = '⮁'
" let g:airline_right_sep = '⮂'
" let g:airline_right_alt_sep = '⮃'
" let g:airline_symbols.branch = '⭠'
" let g:airline_symbols.readonly = '⭤'
" let g:airline_symbols.linenr = '⭡'
let g:airline_symbols.linenr = ' L:'

" ----- Plugin vim-airline-theme -----
" let g:airline_powerline_fonts = 1
" let g:airline_theme='dark'
" let g:airline_solarized_bg='dark'

" ----- Plugin Ale -----
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
let g:ale_linters = {
\  'go': ['golint', 'go vet'],
\  'tf': ['tflint'],
\  'json': ['jsonlint'],
\}
let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'go': ['gofmt', 'goimports'],
\  'cpp': ['clang-format'],
\  'tf': ['terraform'],
\  'terraform': ['terraform'],
\  'json': ['fixjson'],
\  'sh': ['shfmt'],
\  'javascript': ['prettier'],
\  'css': ['prettier'],
\}
" To install shfmt: $ sudo apt update & sudo apt install -y snapd & sudo snap install -y shfmt

" let g:ale_completion_enabled = 1
" set omnifunc=ale#completion#OmniFunc
let g:ale_completion_autoimport = 1
let g:ale_disable_lsp = 1

" " Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1

nmap <silent> ]g :ALENextWrap<CR>
nmap <silent> [g :ALEPreviousWrap<CR>
" "
" let g:ale_sign_error = '>>'
" let g:ale_sign_warning = '--'
" nnoremap ]c :cnext<CR>
" nnoremap [c :cprevious<CR>
" ----- end ale -----

" Enable true color
" if (has("termguicolors"))
  " set termguicolors
" endif


" ----- PLugin FZF.vim -----
" =Setting=
" Empty value to disable preview window altogether
" let g:fzf_preview_window = ''

" Always enable preview window on the right with 60% width
let g:fzf_preview_window = ['right:70%', 'ctrl-/']

" =Keymap=
noremap <leader>sb :Buffers<CR>
noremap <leader>sf :Files<CR>
noremap <leader>sg :GFiles?<CR>
noremap <leader>sl :BLines<CR>
noremap <leader>sr :Rg<CR>
let g:leader_key_map_dict['s'] = {
      \ 'name' : '+search' ,
      \ 'b' : ['Buffers'     , 'file-in-buffer']          ,
      \ 'f' : ['Files'       , 'file-in-project']          ,
      \ 'g' : ['GFiles'      , 'file-in-git']          ,
      \ 'l' : ['BLines'      , 'text-in-current-buffer']          ,
      \ 'r' : ['Rg'          , 'text-in-project']          ,
      \ }

let g:leader_key_map_dict['h'] = {
      \ 'name' : '+help' ,
      \ 'h' : ['Helptags'       , 'help-document']          ,
      \ }

let g:leader_key_map_dict[':'] = ['Commands', 'run-command']


" ----- end FZF.vim -----

"  ----- Plugin rainbow -----
"  =Hotkey=
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle
" ----- end rainbow -----

" ----- Plugin vim-prettier -----
" nmap <leader>py <Plug>(Prettier)

" autocmd BufWrite *.tsx,*.jsx,*.js :Prettier<CR>
" ----- end vim-prettier -----

" " ----- plugin vim-jsx-typescript -----
" set filetypes as typescript.tsx
" autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx
" autocmd BufNewFile,BufRead *.tsx,*.jsx,*.js set syntax=typescript.tsx

" " ----- end vim-jsx-pretty -----

" ------Plugin vim-snippets------------
let g:UltiSnipsExpandTrigger="<c-q>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
"  -----end vim-snippets---------------
"
"  ------- PLUGIN vim-easymotion --------------
map  <leader>mc <Plug>(easymotion-bd-f)
nmap <leader>mc <Plug>(easymotion-overwin-f)
vmap <leader>mc <Plug>(easymotion-overwin-f)

map <leader>mw <Plug>(easymotion-bd-f2)
nmap <leader>mw <Plug>(easymotion-overwin-f2)

let g:leader_key_map_dict['m'] = {
      \ 'name' : '+move' ,
      \ 'c' : ['<Plug>(easymotion-bd-f)'     , 'easymotion-1-char']          ,
      \ 'w' : ['<Plug>(easymotion-bd-f2)'     , 'easymotion-2-char']          ,
      \ }

"  ------- END vim-easymotion -----------------

" "  --- PLUGIN: telescope.nvim ---
" " Find files using Telescope command-line sugar.
" nnoremap <leader>ff <cmd>Telescope find_files<cr>
" nnoremap <leader>fr <cmd>Telescope live_grep<cr>
" nnoremap <leader>fb <cmd>Telescope buffers<cr>
" nnoremap <leader>fh <cmd>Telescope help_tags<cr>
" nnoremap <leader>fk <cmd>Telescope keymaps<cr>
" " Open :Telescope
" nnoremap <leader>fg <cmd>Telescope builtin<cr>
" nnoremap <leader>fp <cmd>Telescope project<cr>

" " diagnostic a repository
" nnoremap <space>da <cmd>Telescope lsp_workspace_diagnostics<cr>


" "  --- END telescope.nvim
"
"
" "  --- PLUGIN vim-vsnip ---
" " NOTE: You can use other key to expand snippet.

" " Expand
" imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
" smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" " Expand or jump
" imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
" smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" " Jump forward or backward
" imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
" smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
" imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
" smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" " Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" " See https://github.com/hrsh7th/vim-vsnip/pull/50
" nmap        s   <Plug>(vsnip-select-text)
" xmap        s   <Plug>(vsnip-select-text)
" nmap        S   <Plug>(vsnip-cut-text)
" xmap        S   <Plug>(vsnip-cut-text)
" "  --- END vim-vsnip ---

" For now, I'm not using neovim builtin LSP features.
" lua <<EOF
 " --- PLUGIN: nvim-lspconfig ---
" local nvim_lsp = require('lspconfig')

" -- Use an on_attach function to only map the following keys
" -- after the language server attaches to the current buffer
" local on_attach = function(client, bufnr)
  " require "lsp_signature".on_attach()
  " local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  " local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  " -- Enable completion triggered by <c-x><c-o>
  " buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  " -- Mappings.
  " local opts = { noremap=true, silent=true }

  " -- See `:help vim.lsp.*` for documentation on any of the below functions
  " buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  " buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  " buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  " buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  " -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  " buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  " buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  " buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  " buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  " buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  " buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  " buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  " buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  " buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  " buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  " buf_set_keymap('n', '<space>d', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  " buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

" end
" --- END nvim-lspconfig


" --- PLUGIN nvim-cmp
" -- Setup nvim-cmp.
" local cmp = require'cmp'

" cmp.setup({
    " snippet = {
      " -- REQUIRED - you must specify a snippet engine
      " expand = function(args)
        " vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        " -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        " -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        " -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      " end,
    " },
    " mapping = {
      " ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      " ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      " ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      " ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      " ['<C-e>'] = cmp.mapping({
        " i = cmp.mapping.abort(),
        " c = cmp.mapping.close(),
      " }),
      " ['<CR>'] = cmp.mapping.confirm({ select = true }),
    " },
    " sources = cmp.config.sources({
      " { name = 'nvim_lsp' },
      " { name = 'vsnip' }, -- For vsnip users.
      " -- { name = 'luasnip' }, -- For luasnip users.
      " -- { name = 'ultisnips' }, -- For ultisnips users.
      " -- { name = 'snippy' }, -- For snippy users.
      " { name = 'path' },
    " }, {
      " { name = 'buffer' },
    " })
" })

" -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
" cmp.setup.cmdline('/', {
    " sources = {
      " { name = 'buffer' }
    " }
" })

" -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
" cmp.setup.cmdline(':', {
    " sources = cmp.config.sources({
      " { name = 'path' }
    " }, {
      " { name = 'cmdline' }
    " })
" })

" -- Setup lspconfig.
" local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
" --- END nvim-cmp

" -- Use a loop to conveniently call 'setup' on multiple servers and
" -- map buffer local keybindings when the language server attaches
" local servers = { 'gopls' }
" for _, lsp in ipairs(servers) do
  " nvim_lsp[lsp].setup {
    " on_attach = on_attach,
    " capabilities = capabilities,
    " flags = {
      " debounce_text_changes = 150,
    " }
  " }
" end
" EOF

" --- PLUGIN gitsigns.nvim ---
lua <<EOF
require('gitsigns').setup()
EOF

"  --- END gitsigns ---

" --- PLUGIN neogit ---
nnoremap <leader>gg :Neogit<CR>
let g:leader_key_map_dict['g'] = {
      \ 'name' : '+git-operation' ,
      \ 'g' : ['Neogit'     , 'open-neogit']          ,
      \ }


"  --- END neogit ---

" Colorscheme
"syntax enable
set t_Co=256
"let g:rehash256 = 1
"let g:molokai_original = 1
"colorscheme molokai

" Colorscheme
autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
syntax enable
colorscheme gruvbox
set bg=dark
