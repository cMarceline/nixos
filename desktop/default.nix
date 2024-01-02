{ config, pkgs, ... }:{
  imports = [
    ./desktopSoftConf.nix
    ./desktopHardConf.nix
    ./looking-glass.nix
    ./vfio.nix
  ];
}
