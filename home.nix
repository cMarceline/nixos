{ config, pkgs, ... }:{
  # init
  home.username = "marci";
  home.stateVersion = "23.11";

  # hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "source" = "/etc/nixos/dots/hyprland.conf";
      "exec-once" = "firefox & swww init & waybar";
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

