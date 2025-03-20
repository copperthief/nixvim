{

  plugins = {
    # completion sources
    cmp-buffer.enable = true;
    cmp-nvim-lsp.enable = true;
    #cmp-cmdline.enable = true;
    #cmp-latex-symbols.enable = true;
    #cmp_luasnip.enable = true; # TODO
    #cmp-nvim-lua.enable = true;
    #cmp-path.enable = true;
    #cmp-treesitter.enable = true;
    # add other two nvim lsps and lspkind

    cmp = {
      enable = true;
      autoEnableSources = true;

      settings = {

        sources = [
          { name = "nvim_lsp"; }
          { name = "buffer"; }
          #{ name = "cmdline"; }
          #{ name = "latex_symbols"; }
          #{ name = "nvim-lua"; }
          #{ name = "path"; }
          #{ name = "treesitter"; }
        ];
   
        mapping = { 
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.abort()";
          "<CR>" = "cmp.mapping.confirm({ select = false })";
        };

        #completion.keyword_length = 2;

      };

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
}
