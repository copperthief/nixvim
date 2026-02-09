



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

local function diagnostics()
  local num_errors = vim.tbl_count(vim.diagnostic.get(0,
    {severity = vim.diagnostic.severity.ERROR }));
  local num_warnings = vim.tbl_count(vim.diagnostic.get(0,
    {severity = vim.diagnostic.severity.WARN }));
  local num_infos = vim.tbl_count(vim.diagnostic.get(0,
    {severity = vim.diagnostic.severity.INFO }));
  local num_hints = vim.tbl_count(vim.diagnostic.get(0,
    {severity = vim.diagnostic.severity.HINT }));

  local display = ""

  if num_errors ~= 0 then
    display = display .. " " .. num_errors
  end
  if num_warnings ~= 0 then
    display = display .. " " .. num_warnings
  end
  if num_infos ~= 0 then
    display = display .. " " .. num_infos
  end
  if num_hints ~= 0 then
    display = display .. "󰌶 " .. num_hints
  end

  return display
end

local function branch()
  if not vim.b.gitsigns_status_dict then return "" end

  local hlgroup = "%#StatusLineGitBranch#"
  return hlgroup .. " " .. vim.b.gitsigns_status_dict.head
end

local function changes()
  if not vim.b.gitsigns_status_dict then return "" end
  local gitsigns = vim.b.gitsigns_status_dict

  local display = ""

  if gitsigns.added ~= 0 then
    display = display .. "%#StatusLineGitAdded#" .. "󰐕" .. gitsigns.added
  end
  if gitsigns.changed ~= 0 then
    display = display .. "%#StatusLineGitChanged#" .. "󰇂 " .. gitsigns.changed
  end
  if gitsigns.removed ~= 0 then
    display = display .. "%#StatusLineGitRemoved#" .. "󰍴" .. gitsigns.removed
  end

  return display
end

function Statusline()
  return table.concat {
    "%#StatusLineGitBranch#",
    "%#StatusLineFileType#",
    "%y",
    "%#StatusLineFileName#",
    "%f",
    "%#StatusLineCursorPos#",
    "%l:%c (%P)",
    "%#StatusLineGap#",
    "%=",
    "%#Normal#",
    branch(),
    changes(),
    diagnostics(),
    "%#Comment#",
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
