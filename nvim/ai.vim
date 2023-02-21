let g:ai_timeout=20
let g:ai_completions_model="code-cushman-001"

nnoremap <C-z> :AI
vnoremap <C-z> :AI
inoremap <C-z> <ESC>:AI<CR>a

imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
        let g:copilot_no_tab_map = v:true
