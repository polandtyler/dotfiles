local root_markers = { '.git', '.vim', 'Makefile' }

-- Return directory path to start search from
local set_project_root = function()
  -- local cwd = vim.fn.getcwd()
  local current_file = vim.fn.expand('%:p')

  local root_marker = vim.fs.find(root_markers, {
    path = current_file,
    upward = true
  })[1]

  if not root_marker then return end

  -- otherwise you get root_dir as '/foo/bar/.git', '/foo/bar'
  local root_dir = vim.fs.dirname(root_marker)

  vim.fn.chdir(root_dir)
end

vim.api.nvim_create_autocmd('VimEnter', {
  group = vim.api.nvim_create_augroup('Rooter', {}),
  desc = 'Find project root on BufEnter and cd there',
  callback = set_project_root
})
