{ ... }:

{
  programs.helix = {
    enable = true;
    settings = {
      theme = "dracula";
      editor = {
        "line-number" = "relative";
        "cursor-shape" = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides.render = true;
        bufferline = "always";
        soft-wrap.enable = true;
      };
    };
  };

  home.sessionVariables = {
    EDITOR = "hx";
  };
}
