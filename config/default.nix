{ pkgs, ... }@specialArgs:
{

  # Import all your configuration modules here
  imports = [
    ./bufferline.nix
    ./keybinds.nix
    ./telescope.nix
    ./autoclose.nix
    ./cmp.nix
    ./toggleterm.nix
  ];

  extraConfigLua = builtins.readFile ./statusline.lua;

  lsp.servers.rust_analyzer.config = {
    cargo.features = "all";
    check.command = "clippy";

    diagnostics = {
      enable = true;
      experimental.enable = true;
      styleLints.enable = true;
    };

    hover = {
      actions.references.enable = true;
    };
  };

  plugins = {
    # TODO: configure bufferline
    # TODO: configure autopairs
    #lualine.enable = true; # TODO: configure
    transparent.enable = true;
    luasnip.enable = true; # TODO: configure
    friendly-snippets.enable = true; # TODO: more snippets?
    gitsigns.enable = true; # TODO: configure
    todo-comments.enable = true;
    oil.enable = true; # TODO: configure
    rustaceanvim.enable = true; # TODO: configure
    # TODO: setup dap stuff
    marks.enable = true; # TODO:configure
    markview.enable = true;
    image.enable = true;

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

    lsp = {
      # TODO: add langauges
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
        uiua.enable = true;
        #rust_analyzer.enable = true;
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

  colorscheme = "deepsea";

  opts = {

    conceallevel = 2; # hide markup unless in current line
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
    colorcolumn = pkgs.lib.range 101 256;

    # line numbers
    number = true;
    relativenumber = true;
    numberwidth = 3;
    signcolumn = "yes";

    # search
    hlsearch = true; # highlight results
    ignorecase = true;

    hidden = true;

    guicursor = ''n-v-c:block-blinkwait2000-blinkon1000-blinkoff1000-Cursor/lCursor,i-ci-ve:ver25-blinkwait600-blinkon300-blinkoff300-iCursor/ilCursor,r-cr:hor20-blinkwait500-blinkon200-blinkoff100-rCursor/rlCursor,o:hor50-Cursor/lCursor'';

    # remove default color schemes from menu
    wildignore = [
      "blue.vim"
      "darkblue.vim"
      "delek.vim"
      "desert.vim"
      "elflord.vim"
      "evening.vim"
      "habamax.vim"
      "industry.vim"
      "koehler.vim"
      "lunaperche.vim"
      "morning.vim"
      "murphy.vim"
      "pablo.vim"
      "peachpuff.vim"
      "quiet.vim"
      "retrobox.vim"
      "ron.vim"
      "shine.vim"
      "slate.vim"
      "sorbet.vim"
      "torte.vim"
      "wildcharm.vim"
      "zaibatsu.vim"
      "zellner.vim"
    ];

  };

  globals.zenbones_compat = 1;

  diagnostic.settings = {
    virtual_lines = false;
    virtual_text = false;
  };

  autoCmd = [
    {
      # DO NOT remove this or lsp completion completely breaks for god knows why
      event = [ "LspAttach" ];
      callback = {
        __raw = "function(ev) vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc' end ";
      };
    }
  ];

  colorschemes = {
    everforest.enable = true;
    modus.enable = true;
    oxocarbon.enable = true;
    gruvbox.enable = true;
    melange.enable = true;

  };

  extraPlugins = with pkgs.vimPlugins; [

    pkgs.texliveFull

    neorg

    neorg-telescope

    zenbones-nvim

    lush-nvim

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

    (pkgs.vimUtils.buildVimPlugin {
      name = "conifer";
      src = pkgs.fetchFromGitHub {
        owner = "lucasadelino";
        repo = "conifer.nvim";
        rev = "22da8d6bdcd802198998b478b0a8bd8353512975";
        hash = "sha256-U/fY8BsarrevU3r7C6sqhJ0kHPDrn4dPF5vjC8QJlw0=";
      };
    })

    (pkgs.vimUtils.buildVimPlugin {
      name = "nanode";
      src = pkgs.fetchFromGitHub {
        owner = "KijitoraFinch";
        repo = "nanode.nvim";
        rev = "cd85bbb5195b23adfb89a695b54e16daab259800";
        hash = "sha256-tYhJDpTjDg6NshqBknD71rmagBYkszOKxSg5HNtfKhM=";
      };
    })

    (pkgs.vimUtils.buildVimPlugin {
      name = "anderson";
      src = pkgs.fetchFromGitHub {
        owner = "tlhr";
        repo = "anderson.vim";
        rev = "77823ba30631fc1d12f443de1eeff97e9c299fdf";
        hash = "sha256-lsd8PPU1nlili9k8pMENdt5FV91N2HQvmYmD2k9piMg=";
      };
    })

    (pkgs.vimUtils.buildVimPlugin {
      name = "nordic";
      src = pkgs.fetchFromGitHub {
        owner = "AlexvZyl";
        repo = "nordic.nvim";
        rev = "6afe957722fb1b0ec7ca5fbea5a651bcca55f3e1";
        hash = "sha256-NY4kjeq01sMTg1PZeVVa2Vle4KpLwWEv4y34cDQ6JMU=";
      };
    })

    (pkgs.vimUtils.buildVimPlugin {
      name = "shades-of-teal";
      src = pkgs.fetchFromGitHub {
        owner = "kristiandupont";
        repo = "shades-of-teal";
        rev = "5bf84996df5cd34153c447385b81a78f4c9d3add";
        hash = "sha256-ZW2591pNF6TfF7lXeeeAE1aN7qumuOCkeh8Z3O2QmcM=";
      };
    })

    (pkgs.vimUtils.buildVimPlugin {
      name = "deepsea-nvim";
      src = pkgs.fetchFromGitHub {
        owner = "copperthief";
        repo = "deepsea-nvim";
        rev = "c4b6c8a151832de4d73e2761a259b2458a8925b7";
        hash = "sha256-RkXZNUgicFxJfjmoWy2C8/2+RTz2ZZwSK3G1mx35Nzc=";
      };
    })

  ];

  extraConfigLuaPost =
    # lua
    ''
      require("neorg").setup {
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                vault_of_shinies = "~/vault-of-shinies",
              },
              default_workspace = "vault_of_shinies",
            },
          },
          ["core.latex.renderer"] = {
            config = {
              render_on_enter = true;
            },
          },
        }
      }
    '';

}
