{ config, pkgs, ... }:{
  # init
  home.username = "marci";
  home.stateVersion = "23.11";

  # hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "source" = "/etc/nixos/hyprland.conf";
      "exec-once" = "waybar & firefox & swww init";
      bind = [
        "$mainMod, F, exec, firefox"
      ];
    };
  };

  programs.waybar = {
    enable = true;
  };

  home.packages = [
    #pkgs.wayland
    #pkgs.hyprland
    #pkgs.waybar
    pkgs.wofi
    pkgs.swww
    pkgs.dunst
    pkgs.kitty
  ];
}

