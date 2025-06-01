--
-- indentations
--
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

-- Leader Key
vim.g.mapleader = " "

--
-- Lines
--
vim.opt.number = true             -- activate lines
-- vim.opt.relativenumber = true  -- relative lines

--
-- Colors from terminal
--
vim.opt.termguicolors = true

--
-- Syntax highlighting
--
vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")
