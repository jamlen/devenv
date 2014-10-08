" put this line first in ~/.vimrc
set nocompatible | filetype indent plugin on | syn on

fun! SetupVAM()
	let c = get(g:, 'vim_addon_manager', {})
	let g:vim_addon_manager = c
	let c.plugin_root_dir = expand('$HOME', 1) . '/.vim/vim-addons'
	" most used options you may want to use:
	" let c.log_to_buf = 1
	" let c.auto_install = 0
	let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
	if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
		execute '!git clone --depth=1 https://github.com/MarcWeber/vim-addon-manager '
					\       shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
	endif
	call vam#ActivateAddons([], {'auto_install' : 0})
    call vam#ActivateAddons(['powerline'])
endfun

let g:vim_addon_manager = {'scms': {'git': {}}}
fun! MyGitCheckout(repository, targetDir)
	let a:repository.url = substitute(a:repository.url, '^git://github', 'http://github', '')
	return vam#utils#RunShell('git clone --depth=1 $.url $p', a:repository, a:targetDir)
endfun
let g:vim_addon_manager.scms.git.clone=['MyGitCheckout']

call SetupVAM()
VAMActivate The_NERD_tree jellybeans vim-addon-commenting github:geekjuice/vim-spec vim-autoformat github:sickill/vim-monokai tlib vim-snippets snipmate matchit.zip github:airblade/vim-gitgutter Tagbar powerline fugitive github:editorconfig/editorconfig-vim github:tpope/vim-cucumber github:digitaltoad/vim-jade github:terryma/vim-multiple-cursors


colorscheme jellybeans

set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set smarttab

set number
set showcmd
set cursorline
set wildmenu
set lazyredraw
set showmatch

set incsearch
set hlsearch

nnoremap <leader><space> :nohlsearch<CR>

set foldenable
set foldlevelstart=10
set foldnestmax=10
nnoremap <space> za
set foldmethod=indent


syntax on

filetype plugin indent on

noremap <F7> :Autoformat<CR><CR>
nmap <silent> <C-D> :NERDTreeToggle<CR>
nmap <silent> <C-E> :TagbarToggle<CR>
let g:NERDTreeDirArrows=0

"map <Leader>t :call RunCurrentSpecFile()<CR>
"map <Leader>s :call RunNearestSpec()<CR>
"map <Leader>l :call RunLastSpec()<CR>
"map <Leader>a :call RunAllSpecs()<CR>

