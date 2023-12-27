{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    nur.url = "github:nix-community/NUR";
  };

  outputs = { self, nixpkgs, home-manager, hyprland, nur, ... }@inputs: {

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
          # nur
          nur.nixosModules.nur
           # This adds a nur configuration option.
           # Use `config.nur` for packages
        ];
      };

      "frameNix" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./laptopSoftConf.nix
          ./laptopHardConf.nix
          ./onepass.nix
          ./hyprland.nix

          # home manager module
          #hyprland.homeManagerModules.default    
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.marci = import ./home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
          }
        ];
      };

      #homeConfigurations."marci@nixos" = home-manager.lib.homeManagerConfiguration {
      #  pkgs = nixpkgs.legacyPackages.x86_64-linux;
      #
      #  modules = [
      #    hyprland.homeManagerModules.default
      #    {wayland.windowManager.hyprland.enable = true;}
      #    # ...
      #  ];
      #};

    };
  };
}
	
