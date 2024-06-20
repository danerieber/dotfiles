{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # glslls
    helix-gpt
    nil
    nodePackages.typescript-language-server
    vscode-langservers-extracted
  ];

  programs.helix = {
    enable = true;
    themes = {
      dracula_nobg = {
        inherits = "dracula";
        "ui.background" = "{}";
      };
    };
    settings = {
      theme = "dracula_nobg";
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
      eslint = {
        command = "vscode-eslint-language-server";
        args = [ "--stdio" ];
        config = {
          validate = "on";
          experimental.useFlatConfig = false;
          rulesCustomizations = [ ];
          run = "onType";
          problems.shortenToSingleLine = false;
          nodePath = "";
          codeAction = {
            disableRuleComment = {
              enable = true;
              location = "separateLine";
            };
            showDocumentation = { enable = true; };
          };
          codeActionOnSave = {
            enable = true;
            mode = "fixAll";
          };
          workingDirectory = { mode = "location"; };
        };
      };
      typescript-language-server.config = { documentFormatting = false; };
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
      {
        name = "svelte";
        auto-format = true;
        formatter = {
          command = "prettier";
          args = [ "--parser" "svelte" ];
        };
      }
    ] ++ (map (lang: {
      name = lang.name;
      formatter = {
        command = "prettier";
        args = [ "--parser" lang.parser ];
      };
      auto-format = true;
      # language-servers = [ "typescript-language-server" "gpt" ];
      language-servers = [ "typescript-language-server" "eslint" ];
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
