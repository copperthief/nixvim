
local function insert_if_exists(t, e)
  if e then table.insert(t, e) end
end

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

  local segments = {}

  if num_errors ~= 0 then
    table.insert(segments, "%#StatusLineErrorCount#" .. " " .. num_errors)
  end
  if num_warnings ~= 0 then
    table.insert(segments, "%#StatusLineWarningCount#" .. " " .. num_warnings)
  end
  if num_infos ~= 0 then
    table.insert(segments, "%#StatusLineInfoCount#" .. " " .. num_infos)
  end
  if num_hints ~= 0 then
    table.insert(segments, "%#StatusLineHintCount#" .. "󰌶 " .. num_hints)
  end

  return table.concat(segments, " ")
end

local function file()
  local icon = filetype_to_icon[vim.o.filetype]
  if not icon then icon = filetype_to_icon["default"] end
  return "%#StatusLineFileType#" .. icon .. " %f"
end

local function git()
  local gitsigns = vim.b.gitsigns_status_dict
  if not gitsigns then return "" end

  local segments = {}

  table.insert(segments, "%#StatusLineGitBranch#" .. " " .. vim.b.gitsigns_status_dict.head)

  if gitsigns.added and gitsigns.added ~= 0 then
    table.insert(segments, "%#StatusLineGitAdded#" .. " " .. gitsigns.added)
  end
  if gitsigns.changed and gitsigns.changed ~= 0 then
    table.insert(segments, "%#StatusLineGitChanged#" .. "󰇂 " .. gitsigns.changed)
  end
  if gitsigns.removed and gitsigns.removed ~= 0 then
    table.insert(segments, "%#StatusLineGitRemoved#" .. " " .. gitsigns.removed)
  end

  return table.concat(segments, " ")

end

function Statusline()

  local git_ = git()
  local diagnostics_ = diagnostics()

  local segments = {}

  table.insert(segments, file())
  if git_ ~= "" then table.insert(segments, git_) end
  if diagnostics_ ~= "" then table.insert(segments, diagnostics_) end
  table.insert(segments, "%l:%c (%P)")

  local gap = "%#StatusLineGap#%="

  return git_ .. " " .. file() .. gap .. " " .. diagnostics_ .. " " .. "%l:%c (%P)"

  --return table.concat(segments, "%#StatusLineGap#%=")
end


vim.api.nvim_create_augroup("statusline", { clear = true })
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, { -- InsertLeave ?
  group = "statusline",
  callback = function()
    vim.opt_local.statusline = "%!v:lua.Statusline()"
  end

})
