require "nvchad.options"

-- add yours here!

vim.o.cursorlineopt ='both' -- to enable cursorline!
-- stopped working for some reason:
-- vim.api.nvim_create_autocmd('VimEnter', {
--   command = [[highlight CursorLine gui=underline cterm=underline]]
-- })

vim.opt.colorcolumn = "100"
-- vim.opt.autochdir = true
vim.wo.relativenumber = true

vim.o.guicursor = table.concat({
  "n-v-c:block-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100",
  "i-ci:ver25-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100",
  "r:hor50-Cursor/lCursor-blinkwait100-blinkon100-blinkoff100"
}, ",")

-- highlight trailing spaces
vim.wo.list = true
-- vim.wo.listchars = "eol:↵,trail:·,tab:>-,nbsp:␣"
vim.wo.listchars = "trail:·,tab:⏵ ,nbsp:␣"

-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "cpp, xml",
-- 	 command = "highlight ExtraWhitespace ctermbg=red guibg=#663333" ..
--               "| match ExtraWhitespace /\\s\\+$/"
--     pattern = "*",
--     callback = function()
--         if vim.bo.modifiable then
--             vim.command( "set listchars=eol:↵,trail:·,tab:>-,nbsp:␣") -- did not work
--         end
--       end
--         do the rest of the callback
-- })

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

vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	command = "setlocal foldmethod=indent"
})

-- leap
vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
