{ config, pkgs, lib, ...}:{

  programs.waybar.enable = true;
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    hyprland
    kitty
    waybar
    eww
  ];

}
