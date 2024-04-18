{ pkgs, ... }:

{
  home.packages = with pkgs; [
    glslls
    helix-gpt
    nil
    nodePackages.typescript-language-server
  ];

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
        true-color = true;
      };
    };
    languages.language-server = {
      glslls = {
        command = "glslls";
        args = [ "--stdin" ];
      };
      gpt = {
        command = "helix-gpt";
        args =
          [ "--handler" "ollama" "--ollamaEndpoint" "http://10.0.3.121:11434" ];
      };
    };
    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
      }
      {
        name = "glsl";
        auto-format = true;
        file-types = [ "glsl" "fsh" "vsh" "csh" ];
        language-servers = [ "glslls" ];
      }
    ] ++ (map (lang: {
      name = lang.name;
      formatter = {
        command = "prettier";
        args = [ "--parser" lang.parser ];
      };
      auto-format = true;
      language-servers = [ "ts" "gpt" ];
    }) [
      {
        name = "typescript";
        parser = "typescript";
      }
      {
        name = "javascript";
        parser = "typescript";
      }
      {
        name = "tsx";
        parser = "typescript";
      }
      {
        name = "jsx";
        parser = "typescript";
      }
      {
        name = "html";
        parser = "html";
      }
      {
        name = "json";
        parser = "json";
      }
      {
        name = "css";
        parser = "css";
      }
    ]);
  };

  home.sessionVariables = { EDITOR = "hx"; };
}
