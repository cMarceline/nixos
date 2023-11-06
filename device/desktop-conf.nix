{ config, pkgs, lib, ...}:{
  imports =
    [
      ./vfio.nix
      ./looking-glass.nix
      /etc/nixos/hardware-configuration.nix
    ];
}
