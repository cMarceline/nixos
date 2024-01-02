{ config, pkgs, ... }:{
  imports = [
    ./hardconf.nix
    ./looking-glass.nix
    ./vfio.nix
  ];
}
