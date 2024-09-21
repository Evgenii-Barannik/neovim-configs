require("subfolder.remap")
require("subfolder.packer")

local function augroup(name)
    return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Briefly highlight on yanking (from LazyVim)
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function()
	vim.highlight.on_yank()
    end,
})

-- Resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
    group = augroup("resize_splits"),
    callback = function()
	local current_tab = vim.fn.tabpagenr()
	vim.cmd("tabdo wincmd =")
	vim.cmd("tabnext " .. current_tab)
    end,
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = {
	"help",
	"lspinfo",
	"qf",
	"checkhealth",
    },
    callback = function(event)
	vim.bo[event.buf].buflisted = false
	vim.keymap.set("n", "q", "<cmd>close<cr>", {
	    buffer = event.buf,
	    silent = true,
	    desc = "Quit buffer",
	})
  end,
})

-- Use 4 spaces to indent
vim.cmd[[set shiftwidth=4]]

-- Set russian language mapping
vim.api.nvim_command('set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz')

-- Set system clipboard
vim.api.nvim_command('set clipboard=unnamedplus')

-- Set multline comments in C to use // 
vim.api.nvim_create_autocmd("FileType", {
    pattern = "c",
    command = "setlocal commentstring=//\\ %s"
})

vim.g.nord_italic = false
color = color or "nord"
vim.cmd('colorscheme nord')

vim.api.nvim_command('set number')
