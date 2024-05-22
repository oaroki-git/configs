vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- Example using a list of specs with the default options
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = "\\" -- Same for `maplocalleader`

require("lazy").setup({
    { "rose-pine/neovim", name = "rose-pine" },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 }, 
    { "neovim/nvim-lspconfig", name = "lspconfig" },
    { "nvim-tree/nvim-tree.lua", version = "*", dependencies = {"nvim-tree/nvim-web-devicons"}},
    { "nvim-lualine/lualine.nvim", name = "lualine" },
})

--require("lspconfig").pyright.setup({
--    filetypes = {"python"}
--})

require("nvim-tree").setup{}
--vim.keymap.set('n', "<C-x>", function() vim.cmd("NvimTreeToggle") end, {expr = true})

require("lualine").setup({
    options = {
        theme = 'auto',
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch', 'diff'},
            lualine_c = {'filename', 'filetype'},
            lualine_x = {},
            lualine_y = {'progress'},
            lualine_z = {'location'},
        },
    }
})


vim.cmd("colorscheme catppuccin-frappe")
vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
vim.cmd("highlight NormalNC guibg=NONE ctermbg=NONE")
