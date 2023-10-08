{ lib, pkgs, config, ... }: {
  boot.kernelParams = [ 
    "amd_iommu=on" 
    "pcie_aspm_off" 
    "vfio-pci.ids=10de:2503,10de:228e"
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
  ];

  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 marci qemu-libvirtd -"
    "f /dev/input/by-id/usb-Logitech_USB_Receiver-if02-mouse 0660 marci qemu-libvirtd -"
    "f /dev/input/by-id/usb-Logitech_USB_Receiver-if02-event-mouse 0660 marci qemu-libvirtd -"
    "f /dev/input/by-id/usb-Keychron_Keychron_C1-if01-mouse 0660 marci qemu-libvirtd -"
    "f /dev/input/by-id/usb-Keychron_Keychron_C1-if01-event-mouse 0660 marci qemu-libvirtd -"
    "f /dev/input/by-id/usb-Keychron_Keychron_C1-event-kbd 0660 marci qemu-libvirtd -"
    "f /dev/input/by-path/pci-0000:09:00.3-usb-0:4:1.2-event-mouse 0660 marci qemu-libvirtd -"
    "f /dev/input/by-path/pci-0000:09:00.3-usb-0:3:1.0-event-kbd 0660 marci qemu-libvirtd -"
    "f /dev/input/by-path/pci-0000:09:00.3-usb-0:4:1.2-mouse 0660 marci qemu-libvirtd -"
    "f /dev/input/by-path/pci-0000:09:00.3-usb-0:3:1.1-event-mouse 0660 marci qemu-libvirtd -"
  ];


  services.persistent-evdev.enable = true;
  services.persistent-evdev = {
    #cache = "/opt/persistent-evdev/cache";
    devices = {
      persist-mouse0 = "/dev/input/by-path/usb-Logitech_USB_Receiver-if02-mouse";
      persist-mouse1 = "/dev/input/by-path/usb-Logitech_USB_Receiver-if02-event-mouse";
      persist-mouse2 = "/dev/input/by-path/usb-Keychron_Keychron_C1-if01-mouse";
      persist-mouse3 = "/dev/input/by-path/usb-Keychron_Keychron_C1-if01-event-mouse";
      persist-keyboard0 = "/dev/input/by-path/usb-Keychron_Keychron_C1-event-kbd";
    };
  };

  virtualisation.libvirtd.qemu.verbatimConfig = ''
    cgroup_device_acl = [
      "/dev/null", "/dev/full", "/dev/zero", 
      "/dev/random", "/dev/urandom",
      "/dev/ptmx", "/dev/kvm", "/dev/kqemu",
      "/dev/rtc","/dev/hpet",
      "/dev/input/by-path/uinput-usb-Keychron_Keychron_C1-event-kbd",
      "/dev/input/by-path/uinput-usb-Keychron_Keychron_C1-if01-event-mouse",
      "/dev/input/by-path/uinput-usb-Keychron_Keychron_C1-if01-mouse",
      "/dev/input/by-path/uinput-usb-Logitech_USB_Receiver-if02-event-mouse",
      "/dev/input/by-path/uinput-usb-Logitech_USB_Receiver-if02-mouse"
    ];
  '';

  boot.initrd.preDeviceCommands = ''
    DEVS="0000:07:00.0 0000:07:00.1"
    for DEV in $DEVS; do
      echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
    done
    modprobe -i vfio-pci
  '';

  virtualisation.libvirtd = {
    enable = true;
    qemuOvmf = true;
    qemuRunAsRoot = false;
    onBoot = "ignore";
    onShutdown = "shutdown";
  };
}
