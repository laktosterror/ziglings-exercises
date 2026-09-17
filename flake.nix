{
  description = "Ziglings dev shell with Zig 0.17.0-dev (master) + matching zls";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    zig-overlay.url = "github:mitchellh/zig-overlay";
    zls.url = "github:zigtools/zls";
  };

  outputs = { self, nixpkgs, flake-utils, zig-overlay, zls, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        zig = zig-overlay.packages.${system}.master;
        zls-pkg = zls.packages.${system}.zls;
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [ zig zls-pkg ];
        };
      });
}
