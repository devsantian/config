return {
  "okuuva/auto-save.nvim",
  command = "ASToogle",
  event = { "InsertLeave", "TextChanged" },
  opts = {
    enable = true,
    trigger_events = {
      immediate_save = { "BufLeave", "FocusLost" }, -- Save immediately when switching apps
      defer_save = { "InsertLeave", "TextChanged" }, -- Save after delay when typing
    },
    debounce_delay = 700, -- Your 700ms delay
  },
}
