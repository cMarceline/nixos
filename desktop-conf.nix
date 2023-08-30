{ config, pkgs, lib, ...}:{
  imports =
    [
      ./vfio.nix
      ./looking-glass.nix
    ];

  # Keybinds
  programs.light.enable = true; # Needed for the /run/wrappers/bin/light SUID wrapper.
  services.actkbd = {
    enable = true;
    bindings = [
      { keys = [ 87 ]; events = [ "key" ]; command = "/home/marci/.screenlayout/primeTop.sh"; }
    ];
  };

}
