local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({ buffer = bufnr })
end)

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'tsserver',
        'elmls',
    },
    handlers = {
        lsp_zero.default_setup,
        elmls = function()
            require('lspconfig').elmls.setup({
                settings = { elmLS = { onlyUpdateDiagnosticsOnSave = true } }
            })
        end,
    },
})

require('lspconfig.configs').roc_lsp = {
    default_config = {
        name = 'roc_lsp',
        cmd = { 'roc_lang_server' },
        filetypes = { 'roc' },
        root_dir = require('lspconfig.util').root_pattern("*.roc", ".git")
    }
}

require('lspconfig').roc_lsp.setup({})

-- Fix Undefined global 'vim'
local lua_opts = lsp_zero.nvim_lua_ls()
require('lspconfig').lua_ls.setup(lua_opts)

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        -- `Enter` key to confirm completion
        ['<CR>'] = cmp.mapping.confirm({ select = false }),

        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),

        -- Navigate between snippet placeholder
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),

        -- Scroll up and down in the completion documentation
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
    })
})

-- lsp.set_preferences({ suggest_lsp_servers = false, sign_icons = { error = 'E', warn = 'W', hint = 'H', info = 'I' } })
lsp_zero.set_sign_icons({
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = '»'
})

lsp_zero.format_on_save({
    format_opts = {
        async = false,
        timeout_ms = 1000,
    },
    servers = {
        ['lua_ls'] = { 'lua' },
        ['elmls'] = { 'elm' },
        ['roc_lsp'] = { 'roc' },
        -- if you have a working setup with null-ls
        -- you can specify filetypes it can format.
        -- ['null-ls'] = {'javascript', 'typescript'},
    }
})

vim.diagnostic.config({
    virtual_text = true
})
