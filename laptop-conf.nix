{ config, pkgs, lib, ... }:{
  boot.kernelParams = [ "mem_sleep_default=deep" ];

  powerManagement = {
    enable = true;
    powertop.enable = true;
    #cpuFreqGovernor = lib.mkDefault "ondemand";
  };

  environment.systemPackages = [
    pkgs.fprintd
  ];
  services.fprintd.enable = true;
  #services.fprintd.tod.enable = true;

  hardware.opengl.extraPackages = with pkgs; [
    mesa_drivers
    vaapiIntel
    vaapiVdpau
    libvdpau-va-gl
    intel-media-driver
  ];
}
