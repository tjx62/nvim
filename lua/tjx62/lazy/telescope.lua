return{
  {
    'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim', 'BurntSushi/ripgrep' },
  config = function()
    require('telescope').setup({})
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    --vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    -- vim.keymap.set('n', ';', builtin.buffers, {})
    -- vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
  end
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      require("telescope").setup {
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
            }
          }
        }
      }
      -- To get ui-select loaded and working with telescope, you need to call
      -- load_extension, somewhere after setup function:
      require("telescope").load_extension("ui-select")
    end
  }
}
