{ config, pkgs, lib, ... }:{
  imports = [
    #./hypr/hypr.nix
  ];
  services.xserver.displayManager.gdm.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    nvidiaPatches = true;
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
  };
}
