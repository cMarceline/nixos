{
  description = "Marci NixOS Flake";
  inputs = {
    # There are many ways to reference flake inputs
    # The most widely used is `github:owner/name/reference`,
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helix.url = "github:helix-editor/helix/23.05";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      #   sudo nixos-rebuild switch --flake .#nixos-test
      "nixos" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [
          ./configuration.nix
          ./device/vfio.nix
          #./device/looking-glass.nix
          ./dewm/hyprland.nix
          #./onepass.nix
          #./home.nix
          ./hardware-configuration.nix
        ];
      };
    };
  };
}
