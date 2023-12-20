{ config, pkgs, ... }:

{
  home.username = "dane";
  home.homeDirectory = "/home/dane";

  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    bash
    cachix
    coreutils-full
    ffmpeg
    gcc
    glow
    nil
    ollama
    p7zip
    podman
    pv
    rnix-lsp
    shell_gpt
    trash-cli
    wireguard-tools
  ];

  programs.bat.enable = true;
  programs.btop.enable = true;
  programs.gpg.enable = true;
  programs.lf.enable = true;
  programs.mpv.enable = true;
  programs.yt-dlp.enable = true;
  
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.eza = {
    enable = true;
    enableAliases = true;
    git = true;
    icons = true;
  };

  programs.git = {
    enable = true;
    userName = "Dane Rieber";
    userEmail = "danerieber@gmail.com";
  };
  
  programs.home-manager.enable = true;
}
