-- lualine.nvim - statusline

local gh = require("helpers.pack").gh

vim.pack.add({
    gh('nvim-tree/nvim-web-devicons'), -- dependency
    {
        src = gh('nvim-lualine/lualine.nvim'),
        name = 'lualine',
        version = 'master'
    }
})

require('lualine').setup {
    options = {
        theme = 'modus-vivendi',
        icons_enabled = true,
        globalstatus = true,
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'lsp_status', 'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'},
    },
    tabline = {
        lualine_a = {
            {
                'tabs',
                mode = 2,
            },
        },
        lualine_b = {
            {
                'buffers',
                mode = 2,
            },
        },
    }
}
