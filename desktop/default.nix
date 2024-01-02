{ config, pkgs, ... }:{
  imports = [
    ./hardware-configuration.nix
    ./looking-glass.nix
    ./vfio.nix
  ];
}
