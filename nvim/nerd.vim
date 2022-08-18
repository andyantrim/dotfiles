" Start nerdtree on launch, and go to other window
autocmd VimEnter * NERDTree | wincmd p

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Key bindings

map <C-n> :NERDTreeToggle<CR>
nnoremap <leader>ft :GoRun<CR>
