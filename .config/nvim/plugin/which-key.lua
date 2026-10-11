-- which-key - keybind help menu

local gh = require("helpers.pack").gh

vim.pack.add({
    gh('nvim-tree/nvim-web-devicons'), -- dependency
    {
        src = gh('folke/which-key.nvim'),
        name = 'which-key',
        version = 'main'
    }
})

require('which-key').setup()

require('which-key').add({
    { "<leader>f", group = "File" },
    { "<leader>d", group = "Delete/Close" },
    { "<leader>q", group = "Quit" },
    { "<leader>s", group = "Search" },
    { "<leader>l", group = "LSP" },
    { "<leader>u", group = "UI" },
    { "<leader>b", group = "Debugging" },
    { "<leader>g", group = "Git" },
})
