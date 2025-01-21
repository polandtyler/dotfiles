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

require("configs.autoroot")

if vim.o.loadplugins then
  require("plugins.beacon")
  require("plugins.hop")
  require("plugins.telescope")
  -- require("plugins.treesitter")
  require('faster').setup()
end
