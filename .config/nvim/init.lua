vim.cmd([[set noswapfile]])
vim.opt.winborder = "rounded"
vim.opt.number = true
vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.swapfile = false
vim.opt.smartindent = true

vim.pack.add( {
		  { src = "https://github.com/sainnhe/gruvbox-material" },
		  { src = "https://github.com/stevearc/oil.nvim" },
		  { src = "https://github.com/echasnovski/mini.nvim" },
		  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
		  { src = 'https://github.com/neovim/nvim-lspconfig' },
		  { src = "https://github.com/mason-org/mason.nvim" },
		  { src = "https://github.com/L3MON4D3/LuaSnip" },
		  { src = "https://github.com/chomosuke/typst-preview.nvim" },
})

require "mason".setup()
require "mini.pick".setup()
require "mini.bufremove".setup()
require "oil".setup()

vim.api.nvim_create_autocmd('LspAttach', {
		  group = vim.api.nvim_create_augroup('my.lsp', {}),
		  callback = function(args)
					 local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
					 if client:supports_method('textDocument/completion') then
								-- Optional: trigger autocompletion on EVERY keypress. May be slow!
								local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
								client.server_capabilities.completionProvider.triggerCharacters = chars
								vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
					 end
		  end,
})

-- colors
vim.cmd("colorscheme gruvbox-material")
vim.cmd(":hi statusline guibg=NONE")

-- lsp
vim.lsp.enable(
		  {
					 "lua_ls",
					 "svelte",
					 "tinymist",
					 "emmetls",
					 "clangd",
					 "ruff",
					 "glsl_analyzer",
					 "hlint"
		  }
)
vim.cmd [[set completeopt+=menuone,noselect,popup]]

-- snippets    (snippets is some code that you can add with a shortcut)
require("luasnip").setup({ enable_autosnippets = true })
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
local ls = require("luasnip")

-- Quick way to jump to editing this file:
local init = vim.fs.normalize(vim.fn.stdpath("config") .. "/init.lua")

vim.api.nvim_create_user_command("Config", function()
  vim.cmd.edit(vim.fn.fnameescape(init))
end, { desc = "Open init.lua" })

vim.g.mapleader = " "
vim.keymap.set('n', '<C-q>', ':q<CR>')
vim.keymap.set('n', '<C-s>', ':w<CR>')
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set({ "n" }, "<leader>e", "<cmd>Oil<CR>")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<leader>pt", ":TypstPreview<CR>", { noremap = true, silent = true })
