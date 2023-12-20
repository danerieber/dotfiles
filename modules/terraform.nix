{ pkgs, ... }:

{
  home.packages = with pkgs; [
    terraform
    terraform-ls
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [ "terraform" ];
}
