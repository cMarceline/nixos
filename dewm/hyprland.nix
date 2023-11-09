{ config, pkgs, lib, ...}:{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    #nvidiaPatches = true;
  };
  #xdg.portal.enable = true;
  #xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  environment.sessionVariables = {
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };
  hardware = {
    opengl.enable = true;
    #nvidia.modesetting.enable = true;
  };

  imports = [
    <home-manager/modules/services/window-managers/hyprland.nix>
  ];

  environment.systemPackages = with pkgs; [
    hyprland
    kitty
  ];

  home-manager.users.marci = {
    home.packages = [
      pkgs.wayland
      pkgs.hyprland
      pkgs.wofi
      pkgs.swww
      pkgs.dunst
      pkgs.kitty
    ];
    wayland.windowManager.hyprland.extraconfig = ''
      
    '';
    
    programs = {
      wofi = {
        enable = true;
        #settings = {};
        #style = "";
      };
    };
  };
}
