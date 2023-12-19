{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {

    nixosConfigurations = {
      "nixos" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./desktopHardConf.nix
          ./looking-glass.nix
          ./vfio.nix
          ./onepass.nix
          ./gnome.nix

          # home manager module
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # TODO replace ryan with your own username
            home-manager.users.marci = import ./home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
          }
        ];
      };
      "frameNix" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./laptopSoftConf.nix
          ./laptopHardConf.nix
          ./onepass.nix
          ./gnome.nix

          # home manager module
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # TODO replace ryan with your own username
            home-manager.users.marci = import ./home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
          }
        ];
      };
    };
  };
}
