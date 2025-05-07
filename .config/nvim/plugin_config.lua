-- Ayu Mirage
	require('ayu').setup({
		mirage = true,
		terminal = true,
		overrides = {
			LineNr = { fg = "gray" }, 
			CursorLineNr = { fg = "#f28779" },
		},
	})
	vim.cmd("colorscheme ayu-mirage")
--

require('neocord').setup({})
require('colorizer').setup()
require('ibl').setup()
-- Telescope
	require('telescope').setup({
		pickers = {
			find_files = {
				hidden = true
			}
		}
	})
	-- Telescope Keybinds
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
		vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
		vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'Telescope oldfiles' })
	--
--

