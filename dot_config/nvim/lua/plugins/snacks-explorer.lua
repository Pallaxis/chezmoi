if true then return {} end
return {
  'folke/snacks.nvim',
  opts = {
    explorer = {},
    picker = {
      sources = {
        explorer = {
          auto_close = true,
        },
      },
    },
  },
  keys = {
    {
      '<leader>fe',
      function()
        Snacks.explorer.open()
      end,
      desc = 'Explorer Snacks (cwd)',
    },
    { '\\', '<leader>fe', desc = 'Explorer Snacks (cwd)', remap = true },
  },
}
