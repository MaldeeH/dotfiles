vim.cmd([[set noswapfile]])
vim.opt.winborder = "rounded"
vim.opt.number = true
vim.opt.wrap = true
vim.opt.tabstop = 2
vim.opt.swapfile = false
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.laststatus = 2
vim.opt.winblend = 0


vim.pack.add( {
		  { src = "https://github.com/sainnhe/gruvbox-material" },
		  { src = "https://github.com/stevearc/oil.nvim" },
		  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
		  { src = 'https://github.com/neovim/nvim-lspconfig' },
		  { src = "https://github.com/mason-org/mason.nvim" },
		  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
			{ src = "https://github.com/nvim-telescope/telescope.nvim",          version = "0.1.8" }, 
			{ src = "https://github.com/nvim-lua/plenary.nvim" },
})

vim.diagnostic.config({
				virtual_text = true,
				signs = false,
				underline = true,
				update_in_insert = false,
})

require "mason".setup()
require("telescope").setup()

require("mason-lspconfig").setup({
				ensure_installed = { "tinymist" },
				automatic_installation = true,
})

local telescope = require("telescope")
telescope.setup({
	defaults = {
		preview = { treesitter = false },
		color_devicons = true,
		sorting_strategy = "ascending",
		path_displays = { "smart" },
		layout_config = {
			height = 100,
			width = 400,
			prompt_position = "top",
			preview_cutoff = 10,
		}
	}
})

require("oil").setup({
				skip_confirm_for_simple_edits=true,
				delete_to_trash = true,
})


-- colors
vim.cmd("colorscheme gruvbox-material")
vim.g.gruvbox_material_background = 'medium'
vim.g.gruvbox_material_foreground = 'material'
local function set_diag_colors()
  local light_red = "#ff6b6b"
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = light_red, bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualLinesError", { fg = light_red, bg = "NONE" })
end
set_diag_colors()
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })

--statusline
vim.o.statusline = table.concat({
  "%f",           -- file path
  "%=",
  "%{&modified ? '✱' : ''}", -- lil star when buffer is modified
  "%=",           
  "%{printf('%4d:%-3d', line('.'), col('.'))} "
})

vim.lsp.config('tinymist', {
  cmd = { 'tinymist' },
  filetypes = { 'typst' },
  root_markers = { 'typst.toml', '.git' }, -- workspace detection
  settings = {
    exportPdf = "never",
    formatterMode = "typstyle"
  },
})

vim.lsp.enable(
		  {
					 "lua_ls",
					 "tinymist",
					 "emmetls",
					 "clangd",
					 "glsl_analyzer",
					 "hlint"
		  }
)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",
  callback = function(event)
    vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", {
      buffer = event.buf,
      desc = "Save Oil buffer",
    })
  end,
})

vim.cmd [[set completeopt+=menuone,noselect,popup]]

-- Quick way to jump to editing this file:
local init = vim.fs.normalize(vim.fn.stdpath("config") .. "/init.lua")
vim.api.nvim_create_user_command("Config", function()
  vim.cmd.edit(vim.fn.fnameescape(init))
end, { desc = "Open init.lua" })

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>q", ':q<CR>')
vim.keymap.set("n", "<leader>w", ':w<CR>')
vim.keymap.set("n", "<leader>c", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>e", "<cmd>Oil<CR>")
vim.keymap.set("n", "<leader>tp", "<cmd>w<CR><cmd>!typst compile %<CR>")
vim.keymap.set("n", "<leader>r", ":e<CR>")
vim.keymap.set("n", "<leader>f", ":Telescope find_files <CR>")
vim.keymap.set("n", "<leader>d", function()
				vim.diagnostic.open_float(nil, { border = "rounded", source = "always", scope = "cursor" })
end)
vim.keymap.set("v", "<C-c>", '"+y')
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR><Esc>", {
  silent = true,
  desc = "Clear search highlight",
})

vim.opt.linebreak = true
vim.opt.breakindent = true

-- The number on the bottom most row should show the length of the file in line numbers
--
-- Need to learn lsp for this:
-- view function definitions on hover
--
-- ( CTRL + R + " ) to paste while in insert mode
-- ctrl + o to jump back
-- ctrl + i to rejump forward
--
-- Deep tools:
-- lldb, valgrind, buildling with fsanitizer. This is the approach for the future for c++
