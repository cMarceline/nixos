{ config, pkgs, lib, ...}:{

  programs.waybar.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    nvidiaPatches = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    opengl.enable = true;
    nvidia.modesetting.enable = true;
  };

  environment.systemPackages = with pkgs; [
    hyprland
    kitty
    waybar
    hyprpaper
  ];

}
