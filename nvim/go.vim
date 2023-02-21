let g:go_auto_sameids = 1
let g:go_fmt_command = "goimports"
let g:go_code_completion_icase = 1
let g:go_doc_popup_window = 1
let g:go_alternate_mode = "vsplit"
let g:go_addtags_transform = 'camelcase'
let g:go_addtags_skip_unexported = 1

nnoremap <leader>gd :GoDef<CR>
nnoremap <leader>gh :GoDoc<CR>
nnoremap <leader>gx :GoRefferrers<CR>
nnoremap <leader>gi :GoImplements<CR>
nnoremap <leader>gfs :GoFillStruct<CR>
nnoremap <leader>grt :GoTest<CR>
nnoremap <leader>grm :GoRun<CR>
xnoremap <leader>jj <S-V>:! python -m json.tool<CR>
