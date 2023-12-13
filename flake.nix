{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs }@inputs: {

    nixosConfigurations = {
      "nixos" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./desktop-hardconf.nix
          ./looking-glass.nix
          ./vfio.nix
          ./onepass.nix
          ./gnome.nix
        ];
      };
    };
  };
}
