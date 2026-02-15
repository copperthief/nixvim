local deep = "#020c12"
local murky = "#145252"
local weed = "#145242"
local searchlight = "#3b5214"
local coral_heart = "#bf404d"
local light = "#bf8a40"
local tired_light = "#604520"
local deepish = "#041725"
local thought = "#13373f"
local submerged = "#143d52"
local rest = "#19404d"
local indigo_pearl = "#143852"
local emerald_cerulean = "#144752"
local deeper = "#02090e"
local shallow = "#093453"
local shallowish = "#062337"
local deepest = "#010609"
local heat = "#bf7740"

-- highlight groups
local g = {}

local function extend(original, modified)
  local t = {}
  for key, val in pairs(original) do t[key] = val end
  for key, val in pairs(modified) do t[key] = val end
  return t
end

g.Normal = { fg = murky, bg = deep }

g.Cursor = { bg = tired_light }
g.iCursor = g.Cursor
g.rCursor = g.Cursor

g.CursorLine = { bg = deepish }
g.CursorColumn = g.CursorLine

g.Identifier = { fg = weed }
g.Function = { fg = murky }
g.Keyword = { fg = submerged }
g.Type = { fg = emerald_cerulean }
g.Operator = { fg = rest }
g.Delimiter = g.Operator
g.Special = g.Operator
g.Constant = { fg = indigo_pearl }
g.String = g.Constant
g.Comment = { fg = thought }

g["@variable"] = g.Identifier
g["@punctuation.bracket"] = g.Operator
g["@lsp.mod.declaration"] = { fg = searchlight, italic = true }

g.Visual = { fg = g.Normal.bg, bg = g.Normal.fg }
g.Search = { fg = light, bold = true }
g.IncSearch = g.Search
g.LineNr = extend(g.Comment, { italic = true })
g.CursorLineNr = extend(g.LineNr, { bold = true })
g.ColorColumn = { bg = deeper }
g.WinSeparator = g.Comment
g.VertSplit = g.WinSeparator

g.Underlined = { underdotted = true }

g.Error = { fg = coral_heart }
g.Warning = { fg = heat }
g.Info = g.Comment
g.Hint = g.Comment

g.Added = g.Identifier
g.Changed = g.Function
g.Removed = g.Constant

g.TodoFgTODO = g.Comment
g.TodoBgTODO = { fg = g.Normal.bg, bg = g.TodoFgTODO.fg }

g.StatusLine = g.Normal
g.StatusLineNC = g.StatusLine
g.StatusLineTermNC = g.StatusLineNC
g.StatusLineGit = { bg = shallow, fg = deep }
g.StatusLineGitBranch = g.StatusLineGit
g.StatusLineGitChanges = { bg = shallowish }
g.StatusLineGitAdded = extend(g.StatusLineGitChanges, { fg = g.Added.fg })
g.StatusLineGitChanged = extend(g.StatusLineGitChanges, { fg = g.Changed.fg })
g.StatusLineGitRemoved = extend(g.StatusLineGitChanges, { fg = g.Removed.fg })
g.StatusLineFile = { bg = deepish, fg = searchlight }
g.StatusLineFileType = g.StatusLineFile
g.StatusLineFileName = g.StatusLineFile
g.StatusLineDiagnostics = g.StatusLineFile
g.StatusLineErrorCount = extend(g.StatusLineDiagnostics, { fg = g.Error.fg })
g.StatusLineWarningCount = extend(g.StatusLineDiagnostics, { fg = g.Warning.fg })
g.StatusLineInfoCount = extend(g.StatusLineDiagnostics, { fg = g.Info.fg })
g.StatusLineHintCount = extend(g.StatusLineDiagnostics, { fg = g.Hint.fg })
g.StatusLinePos = g.StatusLineGitChanges

g.BufferLineFill = { bg = deepest }
g.BufferLineBufferSelected = { fg = searchlight, bg = deep }
g.BufferLineBackground = extend(g.BufferLineFill, { fg = thought })
g.BufferLineSeparator = g.BufferLineFill
g.BufferLineModifiedSelected = g.BufferLineBufferSelected
g.BufferLineModifiedVisible = g.BufferLineBackground
g.BufferLineDuplicate = g.BufferLineBackground

g.ErrorMsg = g.Error
g.WarningMsg = g.Warning
g.DiagnosticError = g.Error
g.DiagnosticWarn = g.Warning
g.DiagnosticInfo = g.Info
g.DiagnosticHint = g.Hint

g.DiffAdd = g.Added
g.DiffChange = g.Changed
g.DiffDelete = g.Removed


local M = {}

function M.colorscheme()
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end
  vim.o.background = "dark"
  vim.g.colors_name = "deepsea"

  for group, attrs in pairs(g) do
    vim.api.nvim_set_hl(0, group, attrs)
  end
end

return M
