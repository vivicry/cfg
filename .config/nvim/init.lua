-- Options
local opts = {
    shiftwidth = 4,
    tabstop = 4,
    expandtab = true,
    wrap = true,
    number = true,
    relativenumber = true,
    cursorline = true,
    signcolumn = yes,
    termguicolors = true,
    showmode = false,
}

for opt, val in pairs(opts) do
    vim.o[opt] = val
end

-- Leader key for keybinds
require("helpers.keys").set_leader(" ")

require("keys")
