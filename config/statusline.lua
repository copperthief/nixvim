



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

local filetype_to_icon = {
  bash = "󱆃",
  c = "",
  cmake = "",
  conf = "",
  config = "",
  cpp = "",
  css = "",
  csv = "",
  default = "",
  desktop = "",
  diff = "",
  gitignore = "",
  glsl = "",
  help = "󰮥",
  html = "",
  java = "",
  javascript = "",
  json = "󰘦",
  json5 = "󰘦",
  lua = "",
  markdown = "",
  nix = "󱄅",
  python = "",
  rust = "",
  scss = "󰬀",
  text = "󰦨",
  toml = "",
  yaml = "",
  zsh = "󰰶",
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
    display = display .. "%#StatusLineErrorCount#" .. "" .. num_errors
  end
  if num_warnings ~= 0 then
    display = display .. "%#StatusLineWarningCount#" .. "" .. num_warnings
  end
  if num_infos ~= 0 then
    display = display .. "%#StatusLineInfoCount#" .. "" .. num_infos
  end
  if num_hints ~= 0 then
    display = display .. "%#StatusLineHintCount#" .. "󰌶" .. num_hints
  end

  return display
end

local function filetype_icon()
  local filetype = vim.o.filetype
  local icon = filetype_to_icon[vim.o.filetype]
  if not icon then icon = filetype_to_icon["default"] end

  return "%#StatusLineFileType#" .. icon .. " #"

  if not filetype_to_icon[filetype] then return filetype_to_icon["default"] end
  return "%#StatusLineFileType#" .. filetype_to_icon[filetype]
end

local function git()
  local gitsigns = vim.b.gitsigns_status_dict
  if not gitsigns then return "" end

  local segments = {}

  table.insert(segments, "%#StatusLineGitBranch#" .. " " .. vim.b.gitsigns_status_dict.head)

  if gitsigns.added ~= 0 then
    table.insert(segments, "%#StatusLineGitAdded#" .. "󰐕" .. gitsigns.added)
  end
  if gitsigns.changed ~= 0 then
    table.insert(segments, "%#StatusLineGitChanged#" .. "󰇂 " .. gitsigns.changed)
  end
  if gitsigns.removed ~= 0 then
    table.insert(segments, "%#StatusLineGitRemoved#" .. "󰍴" .. gitsigns.removed)
  end

  return table.concat(segments, " ")

end

function Statusline()

  local git_segment = git()

  local segments = {}


  return table.concat {
    branch(),
    changes(),
    "%#StatusLineGap#",
    "%=",
    filetype_icon(),
    "%#StatusLineFileName#",
    "%f",
    "%#StatusLineCursorPos#",
    "%l:%c (%P)",
    "%#StatusLineGap#",
    "%=",
    diagnostics(),
    "%#StatusLineMode#" .. vim.api.nvim_get_mode().mode,
  }
end


vim.api.nvim_create_augroup("statusline", { clear = true })
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, { -- InsertLeave ?
  group = "statusline",
  callback = function ()
    vim.opt_local.statusline = "%!v:lua.Statusline()"
  end

})
