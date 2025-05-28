return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.6", -- oder die neueste Version
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
  },
  config = function()
    require("telescope").setup({
      defaults = {
        layout_config = {
          horizontal = { width = 0.9 },
        },
      },
    })
  end,
}
