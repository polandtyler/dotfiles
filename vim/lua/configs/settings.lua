local hop = require('hop')
hop.setup({
  quit_key = '<SPC>',
})

local directions = require('hop.hint').HintDirection
vim.keymap.set('', '<leader>f', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
end, {remap=true})
vim.keymap.set('', '<leader>F', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
end, {remap=true})
vim.keymap.set('', '<leader>t', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false, hint_offset = -1 })
end, {remap=true})
vim.keymap.set('', '<leader>T', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, hint_offset = 1 })
end, {remap=true})

vim.keymap.set('', '<leader>w', function()
  hop.hint_words({ direction = directions.AFTER_CURSOR })
end, {remap=true})
vim.keymap.set('', '<leader>W', function()
  hop.hint_words({ direction = directions.BEFORE_CURSOR })
end, {remap=true})
vim.keymap.set('', '<leader>p', function()
  hop.hint_patterns()
end, {remap=true})
