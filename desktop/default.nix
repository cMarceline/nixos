{ config, pkgs, ... }:{
  imports = [
    ./desktopSoftConf.nix
    ./desktopHardConf.nix
  ];
}
