-- multi-line cursor config

vim.api.nvim_exec(
  [[
let g:VM_mouse_mappings = 1
nnoremap <A-LeftMouse> <Plug>(VM-Mouse-Cursor)
xnoremap <A-LeftMouse> <Plug>(VM-Mouse-Cursor)
inoremap <A-LeftMouse> <Plug>(VM-Mouse-Cursor)
]],
  false
)
