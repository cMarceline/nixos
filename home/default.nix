{ inputs, lib, config, pkgs, ... }:{
  # init
  home.username = "marci";
  home.stateVersion = "23.11";

  imports = [
    ./waybar.nix
    ./wofi.nix
  ];

  # hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "monitor" = lib.mkDefault ",preferred,auto,1.25";
      "source" = "/etc/nixos/home/hyprland.conf";
      "exec-once" = "swww init & waybar & mullvad-gui";
    };
  };

  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";
  };

  # OBS Studio
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      looking-glass-obs
    ];
  };

  home.packages = [
    pkgs.wofi
    pkgs.dunst
  ];
}

