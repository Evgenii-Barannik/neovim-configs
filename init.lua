-- Disable Netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("neo-tree").setup({
    filesystem = {
	hijack_netrw_behavior = "open_default",
    }
})

require("subfolder")
