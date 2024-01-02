{ config, lib, pkgs, ... }:{
  imports = [
    ./hardconf.nix
    ./looking-glass.nix
    ./vfio.nix
  ];
  home-manager.users.marci.wayland.windowManager.hyprland.settings = {
    "monitor" = lib.mkForce [
      "DP-1,1920x1080@144,0x0,1"
      "HDMI-A-1,preferred,0x1080,1"
    ];
  };
}
