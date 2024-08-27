require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

vim.opt.colorcolumn = "100"
-- vim.opt.autochdir = true
vim.wo.relativenumber = true

vim.o.guicursor = table.concat({
  "n-v-c:block-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100",
  "i-ci:ver25-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100",
  "r:hor50-Cursor/lCursor-blinkwait100-blinkon100-blinkoff100"
}, ",")


vim.api.nvim_create_autocmd('VimEnter', {
  command = [[highlight CursorLine gui=underline cterm=underline]]
})

vim.api.nvim_create_autocmd('VimEnter', {
  command = "highlight ExtraWhitespace ctermbg=red guibg=#663333" ..
            "| match ExtraWhitespace /\\s\\+$/"
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "cpp",
	command = "setlocal shiftwidth=4 tabstop=4"
})

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 99

vim.api.nvim_create_autocmd("FileType", {
	pattern = "xml",
	command = "setlocal foldmethod=indent"
})
