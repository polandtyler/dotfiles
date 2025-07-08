--- Check if a file or directory exists in this path
function exists(file)
   local ok, err, code = os.rename(file, file)
   if not ok then
      if code == 13 then
         -- Permission denied, but it exists
         return true
      end
   end
   return ok, err
end

--- Check if a directory exists in this path
function isdir(path)
   -- "/" works on both Unix and Windows
   return exists(path.."/")
end

local root_markers = { '.git', '.vim', 'Makefile' , 'README.md', 'venv'}

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

  local venv_dir = root_dir .. "venv"
  if exists(venv_dir) then
    vim.fn['coc#config']("python.pythonPath", venv_dir .. "/bin/python3")
    vim.fn['coc#config']("python.venvPath", venv_dir)
  end

  if exists(root_dir .. "pyproject.toml") then
    local poetry_venv = vim.fn.trim(vim.fn.system("poetry env info -p"))
    vim.env.VIRTUAL_ENV = poetry_venv
    vim.fn['coc#config']("python.pythonPath", poetry_venv .. "/bin/python3")
    vim.fn['coc#config']("python.venvPath", poetry_venv)
  end
end

vim.api.nvim_create_autocmd('VimEnter', {
  group = vim.api.nvim_create_augroup('Rooter', {}),
  desc = 'Find project root on BufEnter and cd there',
  callback = set_project_root
})
