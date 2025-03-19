{
  # Import all your configuration modules here
  imports = [ ./bufferline.nix ./keybinds.nix ./telescope.nix ./autoclose.nix ./cmp.nix ./toggleterm.nix ];

  colorschemes.gruvbox.enable = true;

  plugins = {
  # TODO: configure bufferline
    # TODO: configure autopairs
    lualine.enable = true; # TODO: configure
    transparent.enable = true;
    luasnip.enable = true; # TODO: configure
    friendly-snippets.enable = true; # TODO: more snippets?
    gitsigns.enable = true; # TODO: configure
    todo-comments.enable = true;
    oil.enable = true; # TODO: configure
    rustaceanvim.enable = true; # TODO: configure
    # TODO: setup dap stuff
    # obsidian.enable = true; # TODO: configure
    marks.enable = true; # TODO:configure
    # TODO try nvim.bacon

    # TODO: add nix language server


    treesitter = {
      enable = true;

      settings = {
        highlight.enable = true;
        indent.enable = true;

      };
    };

    lsp = { # TODO: add langauges
      enable = true;
      servers = {
        lua_ls.enable = true;
        jdtls.enable = true;
        pyright.enable = true;
        jsonls.enable = true;
        clangd.enable = true;
        ts_ls.enable = true;
        html.enable = true;
        cssls.enable = true;
        cmake.enable = true;
        nil_ls.enable = true;
        #rust-analyzer.enable = true;
        rust-analyzer = {
          installCargo = false;
          installRustc = false;
        };
      };
    };

    # TODO: look into sources
    #cmp-buffer.enable = true;
    #cmp-path.enable = true;
    #cmp-latex-symbols.enable = true;
    #cmp-treesitter.enable = true;
    #cmp_luasnip.enable = true;
    #cmp-cmdline.enable = true;

    # TODO: look into window configuration options
  };





  clipboard.register = "unnamedplus"; # use system clipboard
  clipboard.providers.wl-copy.enable = true;

  opts = {

    conceallevel = 0; # show all characters in markdown
    fileencoding = "utf-8";
    showmode = true;
    showtabline = 2; # what do
    autoindent = true;
    smartindent = true; # what do
    undofile = true;
    updatetime = 300; # speeds up completion
    expandtab = true; # convert tabs to spaces
    shiftwidth = 2; # spaces per indentation
    tabstop = 2; # spaces per tab
    cursorline = true; # higlight current line
    wrap = true;
    scrolloff = 8;
    sidescrolloff = 0;
    splitbelow = true; # new windows go under

    # line numbers
    number = true;
    relativenumber = true;
    numberwidth = 3;
    signcolumn = "yes";

    # search
    hlsearch = true; # highlight results
    ignorecase = true;

    hidden = true;

  };

  diagnostics = {
    virtual_lines.only_current_line = true;
    virtual_text = false;
  };

  autoCmd = [
    { # DO NOT remove this or lsp completion completely breaks for god knows why
      event = [ "LspAttach" ];
      callback = {
        __raw = "function(ev) vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc' end ";
      };
    }
  ];

}
