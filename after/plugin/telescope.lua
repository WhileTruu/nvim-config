local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>/', function()
    builtin.grep_string({ search = vim.fn.input("global-search:") });
end)
vim.keymap.set('n', '<leader>pr', builtin.lsp_references, {})

vim.keymap.set('n', '<leader>G', function()
    builtin.grep_string({ search = vim.fn.expand("<cword>") });
end)
