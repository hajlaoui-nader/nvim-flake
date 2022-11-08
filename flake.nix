{
  description = "Nader's Neovim Configuration";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
  };

  outputs = inputs @ { self, nixpkgs, flake-utils, ... }:
    let
      system = "x86_64-linux";

      # Plugin must be same as input name
      plugins = [
      ];

      lib = import ./lib { inherit pkgs inputs plugins; };

      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
        overlays = [  ];
      };

      neovimBuilder = lib.neovimBuilder;

      neovim-ide-full = import ./lib/neovim-ide-full.nix {
        inherit pkgs neovimBuilder;
      };
    in
    rec {
      nixosModules.hm = {
        imports = [
          ./lib/hm.nix
          { nixpkgs.overlays = [ self.overlays.default ]; }
        ];
      };

      packages.${system} = rec {
        default = neovim-ide;
        neovim-ide = neovim-ide-full;
      };
    };
}
