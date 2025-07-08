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
-- " Setup Custom Telescope Functions
-- """"""""""""""""""
-- " Additional functions for custom shortcuts
local actions = require("telescope.actions")
local action_state = require('telescope.actions.state')

local telescope_custom_actions = {}

function telescope_custom_actions._multiopen(prompt_bufnr, open_cmd)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local selected_entry = action_state.get_selected_entry()
    local num_selections = #picker:get_multi_selection()
    if not num_selections or num_selections <= 1 then
        actions.add_selection(prompt_bufnr)
    end
    actions.send_selected_to_qflist(prompt_bufnr)
    vim.cmd("cfdo " .. open_cmd)
end
function telescope_custom_actions.multi_selection_open_vsplit(prompt_bufnr)
    telescope_custom_actions._multiopen(prompt_bufnr, "vsplit")
end
function telescope_custom_actions.multi_selection_open_split(prompt_bufnr)
    telescope_custom_actions._multiopen(prompt_bufnr, "split")
end
function telescope_custom_actions.multi_selection_open_tab(prompt_bufnr)
    telescope_custom_actions._multiopen(prompt_bufnr, "tabe")
end

-- """"""""""""""""""
-- " Setup Telescope
-- """"""""""""""""""
-- " Find files using Telescope command-line sugar.


local telescope = require('telescope')

-- telescope.load_extension("import")
telescope.load_extension('frecency')

function smart_send_to_qflist(...)
  actions.smart_send_to_qflist(...)
  actions.open_qflist(...)
end

local custom_mappings = {
    ["<C-q>"] = smart_send_to_qflist,

    ["<S-DOWN>"] = require('telescope.actions').cycle_history_next,
    ["<S-UP>"] = require('telescope.actions').cycle_history_prev,
}

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
      i = merge({
      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,

        -- ["<C-j>"] = actions.cycle_history_next,
        -- ["<C-k>"] = actions.cycle_history_prev,
        -- ["<CR>"] = actions.select_default,
      }, custom_mappings),
      n = merge({
        ["<C-V>"] = actions.toggle_selection,
        ["<C-J>"] = actions.toggle_selection + actions.move_selection_next,
        ["<C-K>"] = actions.toggle_selection + actions.move_selection_previous,
        ["<C-O>"] = telescope_custom_actions.multi_selection_open_tab,
      }, custom_mappings),
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

