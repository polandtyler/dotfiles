function merge(t1, t2)
	for key, value in pairs(t2) do
	   t1[key] = value
	end

	return t1
end

local get_listed_bufs = function()
    return vim.tbl_filter(function(bufnr)
       return vim.api.nvim_buf_get_option(bufnr, "buflisted")
    end, vim.api.nvim_list_bufs())
end

-- """"""""""""""""""
-- " Setup Telescope
-- """"""""""""""""""
-- " Find files using Telescope command-line sugar.

local telescope = require('telescope')

-- telescope.load_extension("import")
telescope.load_extension('frecency')

local actions = require("telescope.actions")

telescope.setup {
  defaults = {
    -- prompt_prefix = vim.icons.ui.Telescope .. " ",
    -- selection_caret = vim.icons.ui.Forward .. " ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = nil,
    layout_strategy = nil,
    layout_config = {},

    ---@usage Mappings are fully customizable. Many familiar mapping patterns are setup as defaults.
    mappings = {
      i = {
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,
        ["<C-c>"] = actions.close,
        ["<C-j>"] = actions.cycle_history_next,
        ["<C-k>"] = actions.cycle_history_prev,
        ["<C-q>"] = function(...)
          actions.smart_send_to_qflist(...)
          actions.open_qflist(...)
        end,
        ["<CR>"] = actions.select_default,
      },
      n = {
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,
        ["<C-q>"] = function(...)
          actions.smart_send_to_qflist(...)
          actions.open_qflist(...)
        end,
      },
    },
    file_ignore_patterns = {},
    path_display = { "smart" },
    winblend = 0,
    border = {},
    borderchars = nil,
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
  },
  pickers = {
    -- buffers = { theme = 'ivy' },
    -- find_files = { theme = 'dropdown' },

    -- find_files = {
    --   hidden = true,
    -- },
    live_grep = {
      --@usage don't include the filename in the search results
      only_sort_text = true,
    },
    grep_string = {
      only_sort_text = true,
    },
    buffers = {
      initial_mode = "normal",
      mappings = {
        i = {
          ["<C-d>"] = actions.delete_buffer,
        },
        n = {
          ["dd"] = actions.delete_buffer,
        },
      },
    },
    git_files = {
      hidden = true,
      show_untracked = true,
    },
    colorscheme = {
      enable_preview = true,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    },
  },
}

local builtin = require('telescope.builtin')
local search = require('search')

search.setup {
  mappings = {
    next = "<Tab>",
    prev = "<S-Tab>"
  },
  append_tabs = { -- append_tabs will add the provided tabs to the default ones
    {
      "buffers",
      function(opts)
        opts = opts or {}
        builtin.buffers(merge(opts, {
          sort_lastused = true,
          ignore_current_buffer = true,
        }))
      end,
      available = function()
        return #(get_listed_bufs()) > 1
      end
    },
    {
      "recent",
      function(opts)
        opts = opts or {}
        builtin.buffers(merge(opts, {
          sort_mru = true,
          ignore_current_buffer = true,
        }))
      end,
      available = function()
        return #(get_listed_bufs()) > 1
      end
    },

    -- {
    --   "Commits", -- or name = "Commits"
    --   builtin.git_commits, -- or tele_func = require('telescope.builtin').git_commits
    --   available = function() -- optional
    --     return vim.fn.isdirectory(".git") == 1
    --   end
    -- }
  },

  tabs = {
    {
      "files",
      function(opts)
        opts = opts or {}
        telescope.extensions.frecency.frecency(merge(opts, {
          workspace = 'CWD', -- autoset from configs/autoroot logic
        }))
      end
    },
    {
      "rg",
      function(opts)
        opts = opts or {}
        builtin.live_grep(opts)
      end
    },
  },
}

vim.keymap.set('n',  '<leader>i', function()
  telescope.extensions.import.import()
end)
vim.keymap.set('n',  '<C-Space>', function()
  search.open({tab_name = 'files'})
end, {remap=true})
vim.keymap.set('n', ',m', builtin.keymaps, {remap=true})
vim.keymap.set('n', ',,', function()
  builtin.buffers({
    sort_mru = true,
    ignore_current_buffer = true,
  })
end, {remap=true})
vim.keymap.set('n', ',?', function()
  builtin.buffers({
    sort_lastused = true,
    ignore_current_buffer = true,
  })
end, {remap=true})
vim.keymap.set('', '<leader><Space>',
               builtin.live_grep,
               {desc = 'Telescope live grep', remap=true})

