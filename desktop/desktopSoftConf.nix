{ config, pkgs, lib, ...}:{
  imports =
    [
      #/etc/nixos/device/vfio.nix
      #/etc/nixos/device/looking-glass.nix
      #/etc/nixos/hardware-configuration.nix
    ];
}
