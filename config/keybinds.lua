vim.g.mapleader = ' '
vim.g.maplocalleader = ','


  function bind(lhs, rhs, modes, opts)
  modes = modes or { 'n', 'v' }
  opts = opts or { noremap = true, silent = false }
  if type(modes) == 'table' then
    for _, mode in ipairs(modes) do
      vim.keymap.set(mode, lhs, rhs, opts)
    end
  else
    vim.keymap.set(modes, lhs, rhs, opts)
  end
end

function bindn(lhs, rhs, opts)
  bind(lhs, rhs, 'n', opts)
end

-- bind string to expression
function bindx(lhs, rhs, modes, opts)
  if not opts then
    opts = { noremap = true, silent = false }
  end
  opts['expr'] = true
  bind(lhs, rhs, modes, opts)
end

bind('h', 'h')     -- left
bind('H', '^')     -- beginning of line
bind('t', 'j')     -- down
bind('n', 'k')     -- up

bind('s', 'l')     -- right
bind('S', '$')     -- end of line

bind('o', 'b')     -- back a word
bind('O', 'B')     -- back a WORD
bind('e', 'w')     -- start of next word
bind('E', 'W')     -- start of next WORD
bind('u', 'e')     -- forward a word
bind('U', 'E')     -- forward a WORD

bind('{', '{')     -- prev paragraph
bind('}', '}')     -- next paragraph

bind('l', 'o')     -- insert line

bind('/', '/')     -- search buffer
bind('<C-f>', 'n') -- next occurence TODO: change
bind('<C-F>', 'N') -- previous occurence

-- f F t T # *

bind('*', '*')                            -- next occurence of word under cursor
bind('#', '#')                            -- previous occurence of word under cursor

bind('z', 'u')                            -- undo
bind('Z', ':redo<CR>')                    --redo

bind('<Leader><ESC>', '<C-\\><C-n>', 't') -- escape terminal mode

bind('<C-j>', ':enew<CR>')                -- new buffer
bind('j', ':bn<CR>')                      -- next buffer
bind('J', ':bp<CR>')                      -- prev buffer

--bind('<C-k>', ':tabedit .<CR>') -- new tab
--bind('K', ':tabp<CR>') -- prev tab
--bind('k', ':tabn<CR>') -- next tab

bind('<C-x>', ':vsplit<CR>')  -- open new vertical split
bind('<C-S-x>', ':split<CR>') -- open new horizontal split
bind('x', '<C-w>w')           -- next split
bind('X', '<C-w>W')           -- prev split

bind('ks', '<C-w>>')          -- increase width of focused split
bind('kh', '<C-w><')          -- decrease width of focused split
bind('kn', '<C-w>+')          -- increase height of focused split
bind('kt', '<C-w>-')          -- decrease height of focused split

bind('<C-n>', '<C-w><w>')     -- move to next window
-- ex. from main editor to toggleterm
--
bind('q', 'za') -- toggle fold

-- these wont work with my keyboard
--bind('<Leader>>', '<C-w>>') -- increase width of focused split
--bind('<Leader><', '<C-w><') -- decrease width of focused split
--bind('<Leader>+', '<C-w>+') -- increase height of focused split
--bind('<Leader>-', '<C-w>-') -- decrease height of focused split
--bind('<Leader>=', '<C-w>=') -- make all splits equal size

-- look into all telescope built-in commands
bind('<C-s>', ':Telescope<CR> builtin theme=dropdown<CR>') -- telescope all functions
bind('<C-s>g', ':Telescope live_grep theme=dropdown<CR>')  -- live grep
bind('<C-s>f', ':Telescope find_files theme=dropdown<CR>') -- file search

-- look into tabs, symbols, marks
bind('m', '`')              -- goto mark
bind('M', 'm')              -- create mark
bind('<C-m>', ':marks<CR>') -- list marks
-- :delmark/ :delm to delete mark
-- m: to preview mark
-- m[ goto prev mark
-- m] goto next mark

-- lsp stuff


bind('<Leader>c', '<cmd>lua vim.lsp.buf.declaration()<CR>')
bind('<Leader>d', '<cmd>lua vim.lsp.buf.definition()<CR>')
bind('<Leader>h', '<cmd>lua vim.lsp.buf.hover()<CR>')
bind('<Leader>i', '<cmd>lua vim.lsp.buf.implementation()<CR>')
bind('<Leader>s', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
bind('<Leader>t', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
bind('<Leader>r', '<cmd>lua vim.lsp.buf.references()<CR>')
bind('<Leader>n', '<cmd>lua vim.lsp.buf.rename()<CR>')
bind('<Leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>')
bind('<Leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>')
bind('<Leader>p', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
bind('<Leader>j', '<cmd>lua vim.diagnostic.goto_next()<CR>')
bind('<C-f>', '<cmd>lua vim.lsp.buf.format()<CR>')


-- plugin stuff

bind('<C-t>', ':ToggleTerm<CR>')


-- neorg

bind('<CR>', '<Plug>(neorg.esupports.hop.hop-link)')
bind(',', '<LocalLeader>')





local keybinds = {

  -- keybinds to add:
  -- find next/prev, next/prev tab/window, telescope, goto def, word keymaps, word under cursor, stuff in telescope
  --

  -- dvorak (going to need to change extra mappings and add a ton)
  -- normal mode
  -- vim.api.nvim_set_keymap('n', 't', 'j', opts), -- cursor down
  -- vim.api.nvim_set_keymap('n', 'n', 'k', opts), -- cursor up
  -- vim.api.nvim_set_keymap('n', 's', 'l', opts), -- cursor right
  -- vim.api.nvim_set_keymap('n', 'h', 'h', opts), -- cursor left


  -- visual mode
  -- vim.api.nvim_set_keymap('v', 't', 'j', opts), -- cursor down
  -- vim.api.nvim_set_keymap('v', 'n', 'k', opts), -- cursor up
  -- vim.api.nvim_set_keymap('v', 's', 'l', opts), -- cursor right
  -- vim.api.nvim_set_keymap('v', 'h', 'h', opts), -- cursor left

  -- lspconfig
}
