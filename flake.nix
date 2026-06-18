{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    esp = {
      url = "github:leighleighleigh/esp-rs-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, esp, ... }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    esp-toolchain = esp.packages.${system}.default;
  in {
    devShells.${system}.default = pkgs.mkShell {
      name = "garage-door-opener";
      buildInputs = with pkgs; [
        espflash
        esp-generate
        esp-toolchain
      ];
    };
  };
}
