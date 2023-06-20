-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Set filename and it's modified status
vim.opt.winbar = "%=%m %f"

-- Add any additional file type mappings here
-- These need to be configured early on for the filetype to be properly registered it seems
vim.filetype.add({
  pattern = {
    [".*%.json%.tpl"] = "json",
  },
})
