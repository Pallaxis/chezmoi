local opt = vim.opt
-- tabs & indentation
opt.tabstop = 4 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 4 -- spaces for indent width
opt.number = true -- line numbers 
opt.relativenumber = true -- relative line numbers
opt.breakindent = true

local api = vim.api
api.nvim_set_option("clipboard", "unnamedplus")

-- Highlight when yanking
api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.filetype.add {
	extension = { rasi = 'rasi' },
	pattern = {
		['.*/waybar/config'] = 'jsonc',
		['.*/mako/config'] = 'dosini',
		['.*/kitty/*.conf'] = 'bash',
		['.*/hypr/.*%.conf'] = 'hyprlang',
	},
}
