{ config, pkgs, ... }:

{
  home.username = "dane";
  home.homeDirectory = "/Users/dane";

  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    # lazy.vim dependencies
    lazygit
    tree-sitter
    ripgrep
    fd

    # install devenv
    cachix
    (import (fetchTarball https://install.devenv.sh/latest)).default
    
    # misc
    coreutils-full
    pv
  ];

  home.file = {
    # cursed way of setting up nix env in fish
    ".zshrc".text = "fish";

    # cursed way of installing lazy.vim plugins
    "vim-smoothie.lua" = {
      target = ".config/nvim/lua/plugins/vim-smoothie.lua";
      text = "return {{'psliwka/vim-smoothie'}}";
    };
    "nerdcommenter.lua" = {
      target = ".config/nvim/lua/plugins/nerdcommenter.lua";
      text = "return {{'preservim/nerdcommenter'}}";
    };
  };

  home.sessionVariables = {};

  programs.home-manager.enable = true;

  programs.fish = {
    enable = true;
    plugins = with pkgs.fishPlugins; [
      { name = "z"; src = z.src; }
      { name = "fzf"; src = fzf.src; }
      { name = "sponge"; src = sponge.src; }
      { name = "puffer"; src = puffer.src; }
      { name = "hydro"; src = hydro.src; }
      { name = "colored-man-pages"; src = colored-man-pages.src; }
    ];
    shellInit = ''
      set fish_greeting
    '';
  };

  programs.git = {
    enable = true;
    userName = "Dane Rieber";
    userEmail = "danerieber@gmail.com";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
  };

  programs.exa = {
    enable = true;
    enableAliases = true;
    git = true;
    icons = true;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}
