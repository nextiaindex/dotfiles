require("lazy").setup({
	spec = {
		{ 'Shatur/neovim-ayu' },
		{ 'IogaMaster/neocord', event = "VeryLazy" },
		{ 'norcalli/nvim-colorizer.lua' },
		{ 
			'neovim/nvim-lspconfig',
			dependencies = { 'saghen/blink.cmp' },
		},
		{
			'saghen/blink.cmp',
			dependencies = { 'rafamadriz/friendly-snippets' },
			version = '1.*',
			opts = {
				keymap = { preset = 'default' },
				appearance = {
					nerd_font_variant = 'mono'
				},
				completion = { documentation = { auto_show = false } },
				sources = {
					default = { 'lsp', 'path', 'snippets', 'buffer' },
				},
				fuzzy = { implementation = "prefer_rust_with_warning" }
			},
			opts_extend = { "sources.default" }
		},
		{ 'lukas-reineke/indent-blankline.nvim' },
		{
			'goolord/alpha-nvim',
		         config = function ()
				local alpha = require'alpha'
				local dashboard = require'alpha.themes.dashboard'
				local section = dashboard.section
				local fn = vim.fn
				local config = dashboard.config
				dashboard.section.header.val = {
				[[ __   __     __   __   __     __    __]],
				[[/\ "-.\ \   /\ \ / /  /\ \   /\ "-./  \]],
				[[\ \ \-.  \  \ \ \'/   \ \ \  \ \ \-./\ \]],
				[[ \ \_\\"\_\  \ \__|    \ \_\  \ \_\ \ \_\]],
				[[  \/_/ \/_/   \/_/      \/_/   \/_/  \/_/]],
				}
				dashboard.section.header.opts.hl = "Exception"
				dashboard.section.buttons.val = {
					 dashboard.button( "e", "  New file" , ":ene <BAR> startinsert <CR>"),
					 dashboard.button( "Space + ff", "󰈞  Find file", ":Telescope find_files<CR>" ),
					 dashboard.button ("Space + fo", "󰈢  Recently opened files", ":Telescope oldfiles<CR>"),
					 dashboard.button( "q", "󰅚  Quit NVIM" , ":qa<CR>"),
				}
				local handle = io.popen('fortune')
				local fortune = handle:read("*a")
				handle:close()
				dashboard.section.footer.val = fortune

				dashboard.config.opts.noautocmd = true

				vim.cmd[[autocmd User AlphaReady echo 'ready']]
				local marginTopPercent = 0.3
				local headerPadding = fn.max({2, fn.floor(fn.winheight(0) * marginTopPercent) })

				config.layout = {
					{ type = 'padding', val = headerPadding },
					section.header,
					{ type = 'padding', val = 2 },
					section.buttons,
					section.footer,
				}
				alpha.setup(dashboard.config)
			end
		},
		{
			'nvim-telescope/telescope.nvim', tag = '0.1.8',
			dependencies = { 'nvim-lua/plenary.nvim' }
		},
		{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
		{
			'windwp/nvim-autopairs',
			event = "InsertEnter",
			config = true
		},
	},
	install = { colorscheme = { "habamax" } },
	checker = { enabled = true },
})
