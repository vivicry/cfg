-- LSP config

local gh = require("helpers.pack").gh

vim.pack.add({
    gh('neovim/nvim-lspconfig'),
    gh('williamboman/mason.nvim'),
    gh('williamboman/mason-lspconfig.nvim'),
    {
        src = gh('j-hui/fidget.nvim'),
        version = 'v1.6.1',
    },
    gh('RRethy/vim-illuminate'),
    gh('hrsh7th/cmp-nvim-lsp'),
})

-- Init mason
require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = {
        'lua_ls',
    },
    automatic_installation = true,
})

-- Keybind to mason
require('helpers.keys').map('n', '<leader>M', '<cmd>Mason<cr>', "Show Mason")

-- Turn on LSP status information
require('fidget').setup()

-- TODO: Fix signs
-- Diagnostics signs
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Diagnostics config
local config = {
    virtual_text = false,
    signs = {
        active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        focusable = true,
        style = 'minimal',
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
}
vim.diagnostic.config(config)

-- Function to run when LSP connects to a buffer
local on_attach = function(client, bufnr)
    local lsp_map = require('helpers.keys').lsp_map

    lsp_map('<leader>lr', vim.lsp.buf.rename, bufnr, 'Rename symbol')
    lsp_map('<leader>la', vim.lsp.buf.code_action, bufnr, 'Code action')
    lsp_map('<leader>ld', vim.lsp.buf.type_definition, bufnr, 'Type definition')
    -- TODO telescope

    lsp_map('gd', vim.lsp.buf.definition, bufnr, 'Goto definition')
    -- TODO telescope
    lsp_map('gI', vim.lsp.buf.implementation, bufnr, 'Goto implementation')
    lsp_map('K', vim.lsp.buf.hover, bufnr, 'Hover documentation')
    lsp_map('gD', vim.lsp.buf.declaration, bufnr, 'Goto declaration')

    -- Local command for the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })

    lsp_map('<leader>ff', '<cmd>Format<cr>', bufnr, 'Format')

    require('illuminate').on_attach(client)
end

-- Set up Lua LSP
vim.lsp.config('lua', {
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            workspace = {
                library = {
                    vim.env.VIMRUNTIME,
                },
            },
        },
    },
})


-- Lua
-- require('lspconfig')['lua_ls'].setup({
--     on_attach = on_attach,
--     capabilities = capabilities,
--     settings = {
--         Lua = {
--             completion = {
--                 callSnippet = 'Replace',
--             },
--             diagnostics = {
--                 globals = { 'vim' },
--             },
--             workspace = {
--                 library = {
--                     [vim.fn.expand('$VIMRUNTIME/lua')] = true,
--                     [vim.fn.stdpath('config') .. '/lua'] = true,
--                 },
--             },
--         },
--     },
-- })
