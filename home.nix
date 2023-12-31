{ config, pkgs, ... }:{
  # init
  home.username = "marci";
  home.stateVersion = "23.11";

  # hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "source" = "/etc/nixos/hyprland.conf";
      "exec-once" = "firefox & swww init";
      bind = [
        "$mainMod, F, exec, firefox"
      ];
    };
  };

  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";
  };

  programs.waybar = {
    enable = true;
    settings = {
    };
  };

  home.packages = [
    #pkgs.wayland
    #pkgs.hyprland
    #pkgs.waybar
    pkgs.wofi
    pkgs.dunst
    pkgs.kitty
  ];
}

