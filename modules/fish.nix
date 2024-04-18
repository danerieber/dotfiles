{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    plugins = with pkgs.fishPlugins; [
      {
        name = "fzf";
        src = fzf.src;
      }
      {
        name = "sponge";
        src = sponge.src;
      }
      {
        name = "puffer";
        src = puffer.src;
      }
      {
        name = "tide";
        src = tide.src;
      }
      {
        name = "autopair";
        src = autopair.src;
      }
      {
        name = "colored-man-pages";
        src = colored-man-pages.src;
      }
    ];
    shellAliases = {
      fuckmeup =
        "sudo -i sh -c 'nix-channel --update && nix-env --install --attr nixpkgs.nix && launchctl remove org.nixos.nix-daemon && launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist'";
      snowsql = "/Applications/SnowSQL.app/Contents/MacOS/snowsql";
    };
    shellInit = ''
      set fish_greeting
    '';
  };

  home.file = {
    # cursed way of setting up nix env in fish
    ".zshrc".text = ''
      export PATH="$PATH:/opt/homebrew/bin"
      exec fish
    '';
  };
}
