-- Autocompletion

local gh = require("helpers.pack").gh

vim.pack.add({
    -- Completion sources and dependencies
    gh('hrsh7th/cmp-nvim-lsp'),  -- LSP
    gh('hrsh7th/cmp-nvim-lua'),  -- Lua API
    gh('hrsh7th/cmp-buffer'),    -- Buffer 
    gh('hrsh7th/cmp-path'),      -- Paths
    gh('hrsh7th/cmp-cmdline'),   -- Command line
    -- Completion engine
    {
        src = gh('hrsh7th/nvim-cmp'),
        name = "cmp",
        source = "main",
    },
})

local cmp = require("cmp")

-- TODO: Fix icons
local kind_icons = {
	Text = "T",
	Method = "m",
	Function = "f",
	Constructor = "c",
	Field = "f",
	Variable = "v",
	Class = "c",
	Interface = "I",
	Module = "M",
	Property = "p",
	Unit = "u",
	Value = "v",
	Enum = "E",
	Keyword = "k",
	Snippet = "S",
	Color = "c",
	File = "f",
	Reference = "R",
	Folder = "F",
	EnumMember = "e",
	Constant = "C",
	Struct = "S",
	Event = "e",
	Operator = "o",
	TypeParameter = "t",
}

cmp.setup({
    mapping = cmp.mapping.preset.insert({
    	["<C-k>"] = cmp.mapping.select_prev_item(),
    	["<C-j>"] = cmp.mapping.select_next_item(),
    	["<C-d>"] = cmp.mapping.scroll_docs(-4),
    	["<C-f>"] = cmp.mapping.scroll_docs(4),
    	["<CR>"] = cmp.mapping.confirm({
    		behavior = cmp.ConfirmBehavior.Replace,
    		select = false,
    	}),
    	["<Tab>"] = cmp.mapping(function(fallback)
    		if cmp.visible() then
    			cmp.select_next_item()
    		else
    			fallback()
    		end
    	end, { "i", "s" }),
    	["<S-Tab>"] = cmp.mapping(function(fallback)
    		if cmp.visible() then
    			cmp.select_prev_item()
    		else
    			fallback()
    		end
    	end, { "i", "s" }),
    }),
    formatting = {
	    fields = { "kind", "abbr", "menu" },
    	format = function(entry, vim_item)
    		-- Kind icons
    		vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
    		vim_item.menu = ({
    			nvim_lsp = "[LSP]",
    			buffer = "[Buffer]",
    			path = "[Path]",
    		})[entry.source.name]
    		return vim_item
    	end,
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'buffer' },
        { name = 'path' },
    }),
})

-- Command line has to be set up in two separate steps
cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { 
            name = 'cmdline',
            option = {
                ignore_cmds = { "Man", "!" }
            }
        }
    })
})

