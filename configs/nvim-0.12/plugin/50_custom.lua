local later = Config.later

vim.o.clipboard = 'unnamedplus'

-- Init correctly when using `nvim some/folder`
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local path = vim.fn.expand("%")
    if vim.fn.isdirectory(path) == 1 then
      vim.cmd("cd " .. vim.fn.fnameescape(path))
      -- Fix leader key after closing mini.files
      vim.cmd("bwipeout " .. vim.api.nvim_get_current_buf())
    end
  end,
})

-- Keybindings

later(function()
  vim.keymap.set('i', 'jk', '<ESC>')
  vim.keymap.set('n', '<leader>\'', '<cmd>Pick resume<CR>')
  -- Clear search highlights with ESC
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR><Esc>')
  -- <C-o> / <C-i> navigate the jump list
  vim.keymap.set('n', '<C-s>', 'm`')
  -- Replace with repeat (https://vonheikemen.github.io/devlog/tools/how-to-survive-without-multiple-cursors-in-vim/)
  vim.keymap.set('v', 'gR', 'y<cmd>let @/=escape(@", \'/\')<cr>"_cgn', { desc = 'Replace with repeat' })

  -- Emacs bindings
  vim.keymap.set('i', '<C-f>', '<right>')
  vim.keymap.set('i', '<C-b>', '<left>')
  vim.keymap.set('i', '<C-n>', '<down>')
  vim.keymap.set('i', '<C-p>', '<up>')
end)

-- Config for specific filetypes

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'en_us,de_de'
  end,
})
vim.filetype.add {
  filename = {
    ['docker-compose.yml'] = 'yaml.docker-compose',
    ['docker-compose.yaml'] = 'yaml.docker-compose',
  },
}

-- Additional plugins

vim.pack.add({ 'https://github.com/AndrewRadev/switch.vim' })
vim.g.switch_custom_definitions = {
  { -- Cycle markdown checkboxes
    ['^\\(\\s*\\)- \\[ \\] \\(.*\\)'] = '\\1- [-] \\2',
    ['^\\(\\s*\\)- \\[-\\] \\(.*\\)'] = '\\1- [x] \\2',
    ['^\\(\\s*\\)- \\[x\\] \\(.*\\)'] = '\\1- \\2',
    ['^\\(\\s*\\)- \\(.*\\)'] = '\\1- [ ] \\2',
  },
  vim.keymap.set('n', '<C-return>', ':Switch<CR>'),
  vim.keymap.set('i', '<C-return>', '<ESC>:Switch<CR>A'),
}
