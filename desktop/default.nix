{ config, lib, pkgs, ... }:{
  imports = [
    ./hardConf.nix
    ./looking-glass.nix
    ./vfio.nix
  ];
  home-manager.users.marci.wayland.windowManager.hyprland.settings = {
    "input:sensitivity" = 0.5;
    "monitor" = lib.mkForce [
      "DP-1,1920x1080@144,0x0,1"
      "HDMI-A-1,preferred,0x1080,1"
      #"HDMI-A-1,disabled"
    ];
    "bind" = [
      "SUPER,H,swapactiveworkspaces, DP-1 HDMI-A-1"
      "SUPER,K,movecurrentworkspacetomonitor,DP-1"
      "SUPER,L,movecurrentworkspacetomonitor,HDMI-A-1"
      "SUPER,Page_Up,exec,hyprctl dispatch dpms off HDMI-A-1"
      "SUPER,Page_Down,exec,hyprctl dispatch dpms on HDMI-A-1"
    ];
  };
}
