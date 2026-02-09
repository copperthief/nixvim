



local mode_name = {
  n = "NORMAL",
  v = "VISUAL",
  s = "SELECT",
  i = "INSERT",
  R = "REPLACE",
  c = "COMMAND",
  r = "PROMPT",
  ["!"] = "EXECUTING",
  t = "TERMINAL",
}


function Statusline()
  return table.concat {
    "[%f]%=%y",
    string.format(" %s ", mode_name[vim.api.nvim_get_mode().mode]),
    string.format(" %s ", vim.api.nvim_get_mode().mode),
    "[%P %l:%c]"
  }
end


vim.api.nvim_create_augroup("statusline", { clear = true })
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, { -- InsertLeave ?
  group = "statusline",
  callback = function ()
    vim.opt_local.statusline = "%!v:lua.Statusline()"
  end

})
