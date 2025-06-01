return {
  "preservim/nerdtree",
  cmd = "NERDTreeToggle",
  keys = {
    { "<C-b>", "<cmd>NERDTreeToggle<CR>", desc = "Toggle NERDTree" },
  },
  init = function()
    vim.g.NERDTreeChDirMode = 2

    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        local arg = vim.fn.argv(0)
        if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
          vim.cmd("cd " .. arg) -- Set the working directory
          vim.cmd("NERDTree")   -- Start NERDTree
        end
      end,
    })
  end
}



