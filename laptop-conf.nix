{ config, pkgs, lib, ... }:{
  boot.kernelParams = [ "mem_sleep_default=deep" ];

  powerManagement = {
    enable = true;
    powertop.enable = true;
    #cpuFreqGovernor = lib.mkDefault "ondemand";
  };
  
  hardware.opengl.extraPackages = with pkgs; [
    mesa_drivers
    vaapiIntel
    vaapiVdpau
    libvdpau-va-gl
    intel-media-driver
  ];
}
