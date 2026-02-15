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

local function with(orig, new_elems)
  local t = {}
  for key, val in pairs(orig) do t[key] = val end
  for key, val in pairs(new_elems) do t[key] = val end
  return t
end

g.Normal = { fg = murky }

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
g.LineNr = g.Comment:with { italic = true }
g.CursorLineNr = g.LineNr:with { bold = true }
g.ColorColumn = { bg = deeper }
g.WinSeparator = g.Comment
g.VertSplit = g.WinSeparator

g.Underlined = { underdot = true }

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
g.StatusLineGitAdded = g.StatusLineGitChanges:with { fg = g.Added.fg }
g.StatusLineGitChanged = g.StatusLineGitChanges:with { fg = g.Changed.fg }
g.StatusLineGitRemoved = g.StatusLineGitChanges:with { fg = g.Removed.fg }
g.StatusLineFile = { bg = deepish, fg = searchlight }
g.StatusLineFileType = g.StatusLineFile
g.StatusLineFileName = g.StatusLineFile
g.StatusLineDiagnostics = g.StatusLineFile
g.StatusLineErrorCount = g.StatusLineDiagnostics:with { fg = g.Error.fg }
g.StatusLineWarningCount = g.StatusLineDiagnostics:with { fg = g.Warning.fg }
g.StatusLineInfoCount = g.StatusLineDiagnostics:with { fg = g.Info.fg }
g.StatusLineHintCount = g.StatusLineDiagnostics:with { fg = g.Hint.fg }
g.StatusLinePos = g.StatusLineGitChanges

g.BufferLineFill = { bg = deepest }
g.BufferLineBufferSelected = { fg = searchlight, bg = deep }
g.BufferLineBackground = g.BufferLineFill:with { fg = thought }
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



local function set_highlight_group(group, attrs)
  vim.api.nvim_set_hl(0, group, attrs)
end

local function set_highlight_groups(groups)
  for name, attrs in pairs(groups) do
    -- populate child groups with the attrs of their parent
    if attrs.inherit then
      if not attrs.inherit then
        error("Highlight group " .. attrs.inherit .. " does not exist.")
      end
      for key, val in pairs(groups[attrs.inherit]) do
        if not attrs[key] then
          attrs[key] = val
        end
      end
      attrs.inherit = nil
    end

    -- evaluate attrs
    for key, val in pairs(attrs) do
      if val == "true" then
        val = true
      elseif val == "false" then
        val = false
      elseif key ~= "inherit" and val:sub(1, 1) ~= "#" then
        --local split = {}
        -- for str in val:gmatch("([a-zA-Z]|\\.)+") do
        --  split:insert(str)
        -- end
        -- if #split ~= 2 then error("Invalid highlight group attribute: " .. val) end
        local index = val:find(":")
        if not index then error("Invalid highlight group attribute: " .. key .. ": " .. val) end
        local parent_group = val:sub(1, index - 1)
        local inherited_attr = val:sub(index + 1, #val)
        val = groups[parent_group][inherited_attr]
      end
    end

    set_highlight_group(name, attrs)
  end
end

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.o.background = "dark"
vim.g.colors_name = "deepsea"

for group, attrs in pairs(g) do
  vim.api.nvim_set_hl(0, group, attrs)
end
