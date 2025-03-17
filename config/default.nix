{
  # Import all your configuration modules here
  imports = [ ./bufferline.nix ./keybinds.nix ];

  colorschemes.gruvbox.enable = true;

  plugins = {
    lualine.enable = true;
    transparent.enable = true;
    toggleterm.enable = true; # TODO: configure
    luasnip.enable = true; # TODO: configure
    friendly-snippets.enable = true; # TODO: more snippets?
    gitsigns.enable = true; # TODO: configure
    todo-comments.enable = true;
    telescope.enable = true; # TODO: configure
    oil.enable = true; # TODO: configure
    rustaceanvim.enable = true; # TODO: configure
    # TODO: setup dap stuff
    # obsidian.enable = true; # TODO: configure
    marks.enable = true; # TODO:configure




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
      };
    };

    # TODO: look into sources
    cmp-buffer.enable = true;
    cmp-path.enable = true;
    cmp-latex-symbols.enable = true;
    cmp-treesitter.enable = true;
    cmp_luasnip.enable = true;
    cmp-cmdline.enable = true;

    # TODO: look into window configuration options
    cmp = {
      enable = true;
      autoEnableSources = true;
      settings.sources = [
        { name = "nvim-lsp"; }
        { name = "path"; }
        { name = "buffer"; }
        { name = "latex_symbols"; }
        { name = "treesitter"; }
        { name = "cmdline"; }
      ];

      cmdline = {
        "/" = {
          mapping = {
            __raw = "cmp.mapping.preset.cmdline()";
          };
          sources = [
            {
              name = "buffer";
            }
          ];
        };
        ":" = {
          mapping = {
            __raw = "cmp.mapping.preset.cmdline()";
          };
          sources = [
            {
              name = "path";
            }
            {
              name = "cmdline";
              option = {
                ignore_cmds = [
                  "Man"
                  "!"
                ];
              };
            }
          ];
        };
      };

    };
  };


  plugins.cmp.settings.mapping = {
    
    "<C-b>" = "cmp.mapping.scroll_docs(-4)";
    "<C-f>" = "cmp.mapping.scroll_docs(4)";
    "<C-Space>" = "cmp.mapping.complete()";
    "<C-e>" = "cmp.mapping.abort()";
    "<CR>" = "cmp.mapping.confirm({ select = false })";
  }



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
    wrap = false;
    scrolloff = 8;
    sidescrolloff = 0;

    # line numbers
    number = true;
    relativenumber = true;
    numberwidth = 3;
    signcolumn = "yes";

    # search
    hlsearch = true; # highlight results
    ignorecase = true;


  };

}
