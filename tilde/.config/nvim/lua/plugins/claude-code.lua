return {
  "greggh/claude-code.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for git operations
  },
  config = function()
    require("claude-code").setup({
      window = {
        split_ratio = 0.4,
      },
    })
  end,
  keys = {
    {
      "<leader>ac",
      "<cmd>ClaudeCode<cr>",
      desc = "Open Chat (Claude Code)",
    },
  },
}
