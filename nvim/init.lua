vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.linebreak = true

-- lazy
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
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup({
    { "rose-pine/neovim", name = "rose-pine" },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 }, 
    { "neovim/nvim-lspconfig", name = "lspconfig" },
    { "startup-nvim/startup.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", 
                     "nvim-lua/plenary.nvim", 
                     "nvim-telescope/telescope-file-browser.nvim" },
    config = function()
      require "startup".setup()
    end
    },
    { "nvim-lualine/lualine.nvim", name = "lualine" },
})


require("lualine").setup({
    options = {
        theme = 'auto',
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch', 'diff'},
            lualine_c = {'filename'},
            lualine_x = {},
            lualine_y = {'progress'},
            lualine_z = {'location'},
        },
    }
})

require("rose-pine").setup({
    styles = {transparency = true,},
})

vim.cmd("colorscheme rose-pine-moon")
vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
vim.cmd("highlight NormalNC guibg=NONE ctermbg=NONE")
