-- multi-line cursor config
vim.api.nvim_exec(
  [[
" enable mouse for multi-line cursor
let g:VM_mouse_mappings = 1

" Alt + Click adds multi-line cursor
nmap <M-LeftMouse> <Plug>(VM-Mouse-Cursor)

" \ \ Click does column select
nmap \\<LeftMouse> <Plug>(VM-Mouse-Column)
]],
  false
)
