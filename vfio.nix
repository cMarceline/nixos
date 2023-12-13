{ lib, pkgs, config, ... }: {
  
  boot.kernelParams = [ 
    "amd_iommu=on" 
    "pcie_aspm_off" 
    "vfio-pci.ids=10de:2503,10de:228e,144d:a808"
  ];
  boot.kernelModules = [ 
    "vfio_pci"
    "vfio"
    "vfio_iommu_type1"
    "vfio_virqfd"
    
    "nvidia"
    "nvidia_modeset"
    "nvidia_uvm"
    "nvidia_drm"
  ];
  
  environment.systemPackages = [
     pkgs.persistent-evdev
     pkgs.looking-glass-client
     pkgs.haskellPackages.evdev
     pkgs.libvirt
     pkgs.qemu
  ];

  boot.initrd.preDeviceCommands = ''
    DEVS="0000:07:00.0 0000:07:00.1 0000:01:00.0"
    for DEV in $DEVS; do
      echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
    done
    modprobe -i vfio-pci
  '';

  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 marci qemu-libvirtd -"
    "f /dev/input/by-id/usb-05d5_KEYBOARD-event-if01 0660 marci qemu-libvirtd -"
    "f /dev/input/by-id/usb-05d5_KEYBOARD-event-kbd 0660 marci qemu-wlibvirtd -"
    "f /dev/input/by-id/usb-Logitech_USB_Receiver-if02-event-mouse 0660 marci qemu-wlibvirtd -"
  ];

  virtualisation = {
    libvirtd = {
      enable = true;
      qemuOvmf = true;
      qemuRunAsRoot = false;
      
      onBoot = "ignore";
      onShutdown = "shutdown";
      
      qemu.verbatimConfig = ''
        cgroup_device_acl = [
          "/dev/null", "/dev/full", "/dev/zero", 
          "/dev/random", "/dev/urandom",
          "/dev/ptmx", "/dev/kvm", "/dev/kqemu",
          "/dev/rtc","/dev/hpet",
          "/dev/input/by-id/usb-05d5_KEYBOARD-event-if01",
          "/dev/input/by-id/usb-05d5_KEYBOARD-event-kbd",
          "/dev/input/by-id/usb-Logitech_USB_Receiver-if02-event-mouse"
        ]
      '';
    };
  };
}
