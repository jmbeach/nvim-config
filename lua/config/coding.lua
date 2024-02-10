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

-- Lazy vim sets clipboard to unnamedplus, but I want it to be empty
vim.opt.clipboard = ""

-- Use the right clipboard when on WSL
local function is_wsl()
  local wsl_check = os.getenv("WSL_DISTRO_NAME") ~= nil
  return wsl_check
end

-- Install win32yank with cargo and then run:
-- sudo ln -s /mnt/c/Users/jared/.cargo/bin/win32yank.exe /usr/local/bin/win32yank
if is_wsl() then
  vim.g.clipboard = {

    name = "win32yank-wsl",
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf",
    },

    paste = {
      ["+"] = "win32yank.exe -o --lf",
      ["*"] = "win32yank.exe -o --lf",
    },
    cache_enabled = 1,
  }
end
