local lsp = require('lsp-zero')
lsp.preset('recommended')

require'lspconfig'.clangd.setup{}
require'lspconfig'.rust_analyzer.setup{}

require'lspconfig'.lua_ls.setup {
    on_init = function(client)
	client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
	    runtime = {
		-- Tell the language server which version of Lua you're using
		version = 'LuaJIT'
	    },
	    -- Make the server aware of Neovim runtime files
	    workspace = {
		checkThirdParty = false,
		library = {
		    vim.env.VIMRUNTIME
		}
	    }
	})
    end,
    settings = {
	Lua = {}
    }
}

local map = vim.keymap.set

lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}
    map("n", "<leader>xx", "<cmd>lua vim.diagnostic.setloclist()<cr>", { desc = "Diagnostics Location List" }) -- (Like in LazyVim, but without using Trouble)
    map("n", "<leader>cr", function() vim.lsp.buf.rename() end, opts) -- (LazyVim)
    map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", { desc = "Go to Definition" }) -- (LazyVim and LspZero defaults)
    map("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", { desc = "References" })  -- (LazyVim and LspZero defaults)
    map("n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<cr>", { desc = "Type Definition" }) -- (LazyVim)
    map("n", "[d", function() vim.diagnostic.goto_next() end, opts) -- (LazyVim)
    map("n", "]d", function() vim.diagnostic.goto_prev() end, opts) -- (LazyVim)
    map("i", "<C-k>", function() vim.lsp.buf.signature_help() end, opts) -- (LazyVim)
    map("n", "K", function() vim.lsp.buf.hover() end, opts) -- (Lazyvim)
end)

lsp.setup()

local cmp = require('cmp')
cmp.setup({
    mapping = cmp.mapping.preset.insert({
	-- `Enter` key to confirm completion
	['<CR>'] = cmp.mapping.confirm({select = false}),

	-- Ctrl+Space to trigger completion menu
	['<C-Space>'] = cmp.mapping.complete(),
    }),
    snippet = {
	expand = function(args)
	    require('luasnip').lsp_expand(args.body)
	end,
    },
})
