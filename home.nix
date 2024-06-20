{ config, pkgs, ... }:

{
  home.username = "dane";
  home.homeDirectory = "/home/dane";

  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    bash
    cachix
    coreutils-full
    gcc
    glow
    # godot_4
    killall
    nil
    # obs-studio
    p7zip
    podman
    fd
    pv
    python3
    shell_gpt
    trash-cli
    tree
    wget
    wireguard-tools
    zip
    unzip
    websocat
    ffmpeg-full
  ];

  programs.bat.enable = true;
  programs.btop.enable = true;
  programs.gpg.enable = true;
  programs.lf.enable = true;
  programs.mpv.enable = true;
  programs.yt-dlp.enable = true;
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    git = true;
    icons = true;
  };

  programs.git = {
    enable = true;
    userName = "dane";
    userEmail = "danerieber@gmail.com";
  };

  programs.home-manager.enable = true;
}
