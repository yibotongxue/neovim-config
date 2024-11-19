local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
      {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "glsl" }, -- 安装 GLSL 支持
        highlight = {
          enable = true,
        },
      }
    end,
  },
    'airblade/vim-gitgutter',
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({
                -- 这里可以配置一些选项
                check_ts = true,  -- 是否通过 Treesitter 判断语言结构来进行匹配
            })
        end
    },
    -- 安装 Bufferline.nvim 插件
    {
        'akinsho/nvim-bufferline.lua',
        config = function()
            -- Bufferline 配置
            require("bufferline").setup{
                options = {
                    numbers = "none",  -- 不显示缓冲区编号
                    show_buffer_close_icons = false,  -- 不显示关闭图标
                    show_buffer_icons = false,  -- 不显示图标
                    separator_style = "thin",  -- 分隔符样式
                    always_show_bufferline = true,  -- 总是显示缓冲区
                    offsets = {{
                        filetype = "NvimTree",
                        text = "File Explorer",
                        highlight = "Directory",
                        text_align = "left"
                    }}
                }
            }
            -- 键位绑定，快速切换缓冲区
            vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
            vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
            -- vim.keymap.set('n', '<Leader>1', ':BufferLineGoToBuffer 1<CR>', { noremap = true, silent = true })
            -- vim.keymap.set('n', '<Leader>2', ':BufferLineGoToBuffer 2<CR>', { noremap = true, silent = true })
            -- 可以根据需要继续添加更多快捷键
        end
    },
    -- comment
    "tpope/vim-commentary",
    -- file tree
    "preservim/nerdtree",
    -- function and variable tree
    "simrat39/symbols-outline.nvim",
    -- LSP manager
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
   	-- Vscode-like pictograms
	{
		"onsails/lspkind.nvim",
		event = { "VimEnter" },
	},
	-- Auto-completion engine
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"lspkind.nvim",
			"hrsh7th/cmp-nvim-lsp", -- lsp auto-completion
			"hrsh7th/cmp-buffer", -- buffer auto-completion
			"hrsh7th/cmp-path", -- path auto-completion
			"hrsh7th/cmp-cmdline", -- cmdline auto-completion
		},
		config = function()
			require("config.nvim-cmp")
		end,
	},
	-- Code snippet engine
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
	},
    "tanvirtin/monokai.nvim",
    -- "folke/tokyonight.nvim",
})
