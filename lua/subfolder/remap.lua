vim.g.mapleader = " "

local map = vim.keymap.set

-- Line moving (from LazyVim)
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- Save file (from LazyVim)
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Clear search with <esc> (from LazyVim)
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Quit (from LazyVim)
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- Explorer (similar to LazyVim)
map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Explorer NeoTree" })

-- Function to show hidden files
function ShowHiddenFilesInNeoTree()
    require('neo-tree').setup {
	filesystem = {
	    filtered_items = {
		visible = true,
		hide_dotfiles = false,
		hide_gitignored = false,
	    }
	}
    }
end

-- Registering this function
vim.api.nvim_create_user_command(
'ShowHiddenFilesInNeoTree',
function()
    ShowHiddenFilesInNeoTree()
end,
{ desc = "Show hidden files in NeoTree" } )

-- Binding this function
map("n", "<leader>E", "<cmd>:execute 'ShowHiddenFilesInNeoTree' | Neotree reveal<cr>", { desc = "Explorer NeoTree" })

-- Telescope mappings under <leader>f (from LazyVim)
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files"})
map("n", "<leader>fg", "<cmd>Telescope git_files<cr>", { desc = "Git Files" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find Buffers" })
map("n", "<leader>/",  "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
map("n", "<leader>fr", function() require('telescope.builtin').oldfiles({ only_cwd = true }) end, { desc = "Recent Files" })
map("n", "<leader>fc", "<cmd>Telescope find_files cwd=~/.config/nvim<cr>", { desc = "Find Config File" })

local function get_git_root()
    local filepath = vim.fn.expand('%:p:h')
    local git_dir = vim.fn.finddir('.git', filepath .. ';')
    if git_dir == '' then
	return nil
    end
    return vim.fn.fnamemodify(git_dir, ':h')
end

-- Git mappings under <leader>g (like in LazyVim)
-- Improved version of
-- map("n", "<leader>gf", "<cmd>Telescope git_bcommits<cr>", { desc = "File History" })
map("n", "<leader>gf", function()
    local git_root = get_git_root()
    if not git_root then
	print("Not inside a Git repository")
	return
    end
    require('telescope.builtin').git_bcommits({ cwd = git_root })
end, { desc = "File History" })
-- Improved version of
-- map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Git Commits" })
map("n", "<leader>gc", function()
    local git_root = get_git_root()
    if not git_root then
	print("Not inside a Git repository")
	return
    end
    require('telescope.builtin').git_commits({ cwd = git_root })
end, { desc = "Git Commits" })

-- UI toggles under <leader>u (from LazyVim)
map("n", "<leader>uw", "<cmd>set wrap!<cr>", { desc = "Toggle Wrap" })

-- Show all normal mode keymaps under <leader>? (from LazyVim)
map("n", "<leader>?", function() require("which-key").show("", { mode = "n" }) end, { desc = "Show All Keymaps" })

-- Window commands in Hydra mode under <C-w><space> (from LazyVim)
map("n", "<C-w><space>", function()
    require("which-key").show({ keys = "<c-w>", loop = true })
end, { desc = "Window Hydra Mode" })

_G.my_terminal_bufnr = nil

-- Function to toggle terminal
local function toggle_terminal()
    if _G.my_terminal_bufnr and vim.api.nvim_buf_is_valid(_G.my_terminal_bufnr) then
	local win_ids = vim.fn.win_findbuf(_G.my_terminal_bufnr)
	if #win_ids > 0 then
	    for _, win_id in ipairs(win_ids) do
		vim.api.nvim_win_close(win_id, true)
	    end
	else
	    -- Open terminal buffer in a split below
	    vim.cmd("belowright split | buffer " .. _G.my_terminal_bufnr)
	    vim.cmd("startinsert")
	end
    else
	-- Create terminal buffer in a split below
	vim.cmd("belowright split | terminal")
	_G.my_terminal_bufnr = vim.api.nvim_get_current_buf()
	vim.cmd("startinsert")
    end
end

-- Map Alt+h to toggle terminal (from NvChad)
vim.keymap.set({ "n", "t" }, "<M-h>", toggle_terminal, { desc = "Toggle Terminal" })
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { desc = "Terminal to Normal Mode" })

-- Line beginning and end jumps. Does not rebind anything useful
map({'n', 'v', 'i'}, '<D-Left>', '<Home>', { noremap = true, silent = true})
map({'n', 'v', 'i'}, '<D-Right>', '<End>', { noremap = true, silent = true })

-- Black Hole register usage
map("v", "<leader>p", "\"_dP", { silent = true, desc = "Paste over selection without yanking" })
map({ "v", "n" }, "<leader>d", "\"_d", { silent = true, desc = "Delete to black hole register" })
