{ pkgs, ... }@specialArgs:
{ 
  # Import all your configuration modules here
  imports = [ ./bufferline.nix ./keybinds.nix ./telescope.nix ./autoclose.nix ./cmp.nix ./toggleterm.nix ];

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
    markview.enable = true;
    image.enable = true;
    neorg.enable = true; # TODO: configure

    trouble = {
      enable = true;

      settings = {

        auto_refresh = true;

      };
    };

    # TODO: add nix language server

    which-key = {
      enable = true;

      settings = {
        preset = "modern";
      };
    };


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
        rust_analyzer = {
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

    # TODO: yazi wtf vim-be-good timerly which-key specs trouble rest nvim-surround peek smear-cursor prescence octo neorg oil lean papis oil-git-status
    # kulala jupytext neotest nerdy markdown-preview vim-julia-cell vim-nix image.nvim helpview goyo firenvim distant direnv committia commentary vim-sandwich
    # remote-nvim render-markdown web-tools wilder 

  };





  clipboard.register = "unnamedplus"; # use system clipboard
  clipboard.providers.wl-copy.enable = true;

  colorscheme = "ashen";

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

  diagnostic.settings = {
    virtual_lines = false;
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

  colorschemes = {
    #cyberdream.enable = true;
    #everforest.enable = true;
    #modus.enable = true;
    #rose-pine.enable = true;
    #oxocarbon.enable = true;
    #gruvbox.enable = true;
    #melange.enable = true;

  };

  extraPlugins = [

    (pkgs.vimUtils.buildVimPlugin {
      name = "live-preview";
      src = pkgs.fetchFromGitHub {
        owner = "turbio";
        repo = "bracey.vim";
        rev = "4e1a22acc01787814819df1057d039d4ecf357eb";
        hash = "sha256-As4k31PSSmrSkUemcnkxzrHd9nWXyGJguH9MKTpEnxU=";
      };
    })

    (pkgs.vimUtils.buildVimPlugin {
      name = "ashen";
      src = pkgs.fetchFromGitHub {
          owner = "ficcdaf";
          repo = "ashen.nvim";
          rev = "4d161f812f558b5ecde002d80e483a3122ab60f4";
          hash = "sha256-xfEPDHaVmddfK2jBex34MH8y9p5HrNPaPK18mExdRMQ=";
      };
    })

    (pkgs.vimUtils.buildVimPlugin {
      name = "lackluster";
      src = pkgs.fetchFromGitHub {
          owner = "slugbyte";
          repo = "lackluster.nvim";
          rev = "662fba7e6719b7afc155076385c00d79290bc347";
          hash = "sha256-oZca/MfsYBW0Fa/yBUGXFZKxJ05DfDNeWj5XaOoU4Mo=";
      };
    })

    (pkgs.vimUtils.buildVimPlugin {
      name = "reddish";
      src = pkgs.fetchFromGitHub {
          owner = "paulfrische";
          repo = "reddish.nvim";
          rev = "82fa574fc58a980143c6094526edd7da76f05f7c";
          hash = "sha256-qMFE09FSYTCMZ+kktNUSkpuTZmkQEqCfwIw2us/lUos=";
      };
    })
  ];

}
