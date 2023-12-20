{ config, pkgs, lib, ... }:{
  imports = [
    #./hypr/hypr.nix
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.xserver.desktopManager.gnome.enable = false;
  services.xserver.displayManager.defaultSession = "hyprland";
  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
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

  environment.systemPackages = with pkgs; [
    hyprland
    kitty
    pkgs.libsForQt5.dolphin
  ];
}
