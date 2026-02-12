{
  plugins = {
    web-devicons.enable = true;
    bufferline = {
      enable = true;
      settings = {
        options = {
          indicator.style = "none";
          color_icons = true;
          show_close_icon = false;
          show_buffer_close_icons = false;
          show_buffer_icons = false;
          offsets = [ { separator = false; } ];
        };
      };
    };
  };
}
