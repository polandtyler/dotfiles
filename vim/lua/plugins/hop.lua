local hop = require('hop')

local fixed_hop_pattern = function (opts)
  pat = hop.get_input_pattern('[hop]/ ', nil, opts)
  vim.fn.setreg('/', pat)
  if pat then
    hop.hint_patterns(opts, pat)
  end
end

-- """"""""""""""""""
-- " Setup motion plugin(s)
-- """"""""""""""""""
hop.setup({
  quit_key = '<SPC>',
  jump_on_sole_occurence = true,
})

local directions = require('hop.hint').HintDirection
-- vim.keymap.set('', 'f', function()
--   hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
-- end, {remap=true})
-- vim.keymap.set('', 'F', function()
--   hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
-- end, {remap=true})
-- vim.keymap.set('', 't', function()
--   hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
-- end, {remap=true})
-- vim.keymap.set('', 'T', function()
--   hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
-- end, {remap=true})
vim.keymap.set('', '<leader>/', fixed_hop_pattern, {remap=true})
