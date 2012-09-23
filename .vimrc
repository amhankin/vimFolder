"----------------------------------
" 		Vim startup file
"----------------------------------


"Standard Settings
	set nocompatible	"Not compatible vi
	set history=100		"history length
	set undolevels=200	"number of undoes allowed
	set showmode		"show current mode
	set number			"number lines
	"set scr=10			"scroll speed
	"set ttyscroll=10	"gui scroll speed
	set tabstop=4		"tab length
	set autoindent		"auto indenting
	set showcmd			"show partial command
	set shiftwidth=4	"shift for arrow guy
	"set textwidth=0
	"set formatoptions+=l
	set lbr
	"set backspace&		"don't let macvim change default backspace behavior
	set wrap					"wrap lines
	set autochdir			" sets directory to current working dirctory
	set noeb vb t_vb=

"Key mappings
	" Enclose selected text in secific symbol
	vmap \p <Esc>`>a)<Esc>`<i(<Esc>`>3l
	vmap \c <Esc>`>a}<Esc>`<i{<Esc>`>3l
	vmap \q <Esc>`>a"<Esc>`<i"<Esc>`>3l
	vmap \4 <Esc>`>a$<Esc>`<i$<Esc>`>3l
	vmap \b <Esc>`>a]<Esc>`<i[<Esc>`>3l
	map \j :edit ++enc=euc-jp<CR>


	"Allow paste to paste over highlighted text in visual mode
	vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>


	"Enable synax highlighting when colors avaiable
	syntax on
	colorscheme developer
	
" Save sessions (save sessions)
set sessionoptions+=winpos,resize
nnoremap <leader>ss :CMiniBufExplorer<CR>:wa<CR>:mksession! .this_session1<CR>:wqa<CR>
nnoremap <leader>so :CMiniBufExplorer<CR>:wa<CR>:bufdo bdelete<CR>:source .this_session1<CR>:CMiniBufExplorer<CR>:TMiniBufExplorer<CR>


" Use pathogen to load all plugins in bundle folder
	filetype off
	call pathogen#runtime_append_all_bundles()
	call pathogen#helptags()

"" Plugin settings (sorted alphabetically)

	" Ack settings (grep type fuzzy search)
	nmap <leader>a <Esc>:Ack!

	" Command-T settings (quick file search with '\t')
	let CommandTMaxFiles = 20000 			"default = 10000
	let g:CommandTMaxCachedDirectories = 0 	"default = 1
	let g:CommandTMaxDepth = 8
	nnoremap <silent> <Leader>tt :CommandT<CR>

	" Gundo settings (records change history)
	nnoremap \g :GundoToggle<CR>

	" Minibufexpl settings (tab like buffer tracking)
    let g:miniBufExplMapCTabSwitchBufs = 1 
	let g:miniBufExplMapWindowNavVim = 1 
  	let g:miniBufExplMapWindowNavArrows = 1 
	let g:miniBufExplModSelTarget = 1 

	" Pyflakes settings (error detection for python files)
	"let g:pyflakes_use_quickfix = 0
	
	"Py.test
	" Execute the tests
	 nmap <silent><Leader>tf <Esc>:Pytest file<CR>
	 nmap <silent><Leader>tc <Esc>:Pytest class<CR>
	 nmap <silent><Leader>tm <Esc>:Pytest method<CR>
	 " Execute test with debug
	 nmap <silent><Leader>df <Esc>:Pytest file --pdb<CR>
	 nmap <silent><Leader>dc <Esc>:Pytest class --pdb<CR>
	 nmap <silent><Leader>dm <Esc>:Pytest method --pdb<CR>
	 " cycle through test errors
	 nmap <silent><Leader>tn <Esc>:Pytest next<CR>
	 nmap <silent><Leader>tp <Esc>:Pytest previous<CR>
	 nmap <silent><Leader>te <Esc>:Pytest error<CR>


	" Taglist settings (
	nnoremap <silent> <leader>c :TlistToggle<CR>

	" Tasklist settings
	map <leader>k <Plug>TaskList

" Filetype settings
	filetype plugin on
	filetype indent on
	
"Filetype stuff
	" Shell header
	function! <SID>ShellHeader()
		:call setline(1, "#!/bin/bash")
		:call append(1, "")
		exe 2
	endfunction

	" Bash header
	function! <SID>BashHeader()
		:call setline(1, "#!/bin/bash")
		:call append(1, "")
		exe 2
	endfunction

	" Gnuplot header
	function! <SID>GnuplotHeader()
		:call setline(1, "#!/opt/local/bin/gnuplot")
		:call append(1, "")
		exe 2
	endfunction

	" Writes files headers for shell and gnuplot files
	au BufEnter *.sh if getline(1) == "" | call s:ShellHeader() | endif
	au BufEnter *.bash if getline(1) == "" | call s:BashHeader() | endif
	au BufEnter *.plt if getline(1) == "" | call s:GnuplotHeader() | endif

	" Define a function that can tell me if a file is executable
	function! FileExecutable (fname)
		execute "silent! ! test -x" a:fname
		return v:shell_error
	endfunction

	" Automatically make Perl and Shell scripts executable if they aren't already
	au BufWritePost *.sh,*.bash,*.cgi if FileExecutable("%:p") | :silent !chmod a+x %   endif

	" Makes a file with '#!/bin/sh' at the top of it executable
	function! ModeChange()
		if FileExecutable("%:p")
				if getline(1) =~ "^#!/bin/sh"
						silent !chmod a+x % 
				endif
			endif
	endfunction
	au BufWritePost * call ModeChange()

	" Makes a file with '#!/bin/bash' at the top of it executable
	function! BashModeChange()
		if FileExecutable("%:p")
				if getline(1) =~ "^#!/bin/bash"
						silent !chmod a+x % 
				endif
			endif
	endfunction
	au BufWritePost * call BashModeChange()

	" Latex setting
	set grepprg=grep\ -nH\ $*
	let g:tex_flavor = 'latex'

	" C++ settings
	let g:C_Libs = "-lgsl -lgslcblas -lm"
	let g:C_CFlags = '-Wall -g -O3 -c'
	let s:C_LFlags = '-Wall -g -O3'

	"au BufRead,BufNewFile *.txt set spell 

	" External editor settings
	au BufRead,BufNewFile *.safari,*.mail set spell "| map j gj | map k gk "| set tw=78 | set wm=2

"Others
	"Creates backup file if not in VMS mode
	if has("vms")
		set nobackup
	else
		set backup
		set backupdir=~/.vim/backup
	endif
	 
	
	" Save folds for the filetypes listed below
	"autocmd BufWinLeave .* mkview
	"autocmd BufWinEnter .* silent loadview 
	"au BufWinLeave *.sh,.vimrc,*.vim mkview
	"au BufWinEnter *.sh,.vimrc,*.vim silent loadview
	"set foldmethod=indent
	"set foldnestmax=1
	
