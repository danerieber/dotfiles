{ pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    # (final: prev: {
    #   llama-cpp = prev.llama-cpp.overrideAttrs (old: {
    #     src = pkgs.fetchFromGitHub {
    #       owner = "ggerganov";
    #       repo = "llama.cpp";
    #       rev = "mixtral";
    #       hash = "sha256-h4+llM6zrYz9E17GThBO6iery16VyHvR0ymkjkFkn5c=";
    #     };
    #   }); 
    # })
    (final: prev: rec {
      llama-cpp = prev.llama-cpp.override ({
        # openblasSupport = true;
        # openclSupport = true;
        # cudaSupport = true;
        # rocmSupport = true;
        blasSupport = false;
        openclSupport = true;
      });
      # ollama = prev.ollama.override ({
      #   llama-cpp = llama-cpp;
      # });
    })
  ];

  home.packages = [ pkgs.llama-cpp pkgs.ollama ];
}
