require 'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = {
        "javascript",
        "typescript",
        "elm",
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query"
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    highlight = {
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}

-- make .roc files have the correct filetype
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.roc" },
    command = "set filetype=roc",
})

-- add roc tree-sitter
local parsers = require("nvim-treesitter.parsers").get_parser_configs()

parsers.roc = {
    install_info = {
        url = "https://github.com/faldor20/tree-sitter-roc",
        files = { "src/parser.c", "src/scanner.c" },
    },
}
