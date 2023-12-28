{ pkgs, ... }:

{
  # nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    (final: prev: {
      llama-cpp = prev.llama-cpp.overrideAttrs (old: {
        src = pkgs.fetchFromGitHub {
          owner = "ggerganov";
          repo = "llama.cpp";
          rev = "mixtral";
          hash = "sha256-h4+llM6zrYz9E17GThBO6iery16VyHvR0ymkjkFkn5c=";
        };
      }); 
    })
    # (final: prev: {
    #   llama-cpp = prev.llama-cpp.override ({
    #     openblasSupport = false;
    #   }); 
    # })
  ];

  home.packages = [ pkgs.llama-cpp ];
}
