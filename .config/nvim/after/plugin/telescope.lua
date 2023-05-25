local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.git_files, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fa', builtin.find_files, {})
vim.keymap.set('n', '<leader>fw', builtin.live_grep, {})

require('telescope').setup{
    defaults = {
        vimgrep_arguments = {
            'rg',
            '--color=never',
      '--no-heading',
      '--line-number',
      '--column',
      '--smart-case',
      '--no-ignore', -- **This is the added flag**
      '--hidden' -- **Also this flag. The combination of the two is the same as `-uu`**
        }
    }
}
