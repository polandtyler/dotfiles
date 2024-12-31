vim.cmd([[ source $HOME/.vim/vimrc_functions ]])
vim.cmd([[ source $HOME/.vim/vimrc_plugin_definitions ]])
vim.cmd([[ source $HOME/.vim/vimrc_settings ]])
vim.cmd([[ source $HOME/.vim/vimrc_mappings ]])
vim.cmd([[ source $HOME/.vim/vimrc_autocmds ]])

vim.cmd([[
  if &loadplugins
    source $HOME/.vim/vimrc_plugin_settings
  endif
]])

require("configs.settings")
require('faster').setup()

-- Test telescope + trouble integration:

local actions = require("telescope.actions")
local open_with_trouble = require("trouble.sources.telescope").open

-- Use this to add more results without clearing the trouble list
local add_to_trouble = require("trouble.sources.telescope").add

local telescope = require("telescope")

telescope.setup({
  defaults = {
    mappings = {
      i = { ["<c-t>"] = open_with_trouble },
      n = { ["<c-t>"] = open_with_trouble },
    },
  },
})
