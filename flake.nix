{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, fenix, ... }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
    rustToolchain = fenix.packages.${system}.toolchainOf {
      channel = "nightly";
      date = "2025-04-27";
      sha256 = "sha256-DnyK5MS+xYySA+csnnMogu2gtEfyiy10W0ATmAvmjGg=";
    };
  in {
    devShell."${system}" = pkgs.mkShell {
      name = "servo";
      buildInputs = with pkgs; [
        espflash
        esp-generate
        (rustToolchain.withComponents [
          "cargo"
          "rustc"
          "rust-src"
          "clippy"
        ])
      ];
    };
  };
}
