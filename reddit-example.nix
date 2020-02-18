{ config, pkgs, lib, ... }:
{
  # NixOS wants to enable GRUB by default, but we use u-boot on rpi
  boot.loader.grub.enable = false;
  # if you have a Raspberry Pi 2 or 3, pick this:
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # A bunch of boot parameters needed for optimal runtime on RPi 3b+
  boot.kernelParams = ["cma=256M"];
  boot.loader.raspberryPi.enable = true;
  boot.loader.raspberryPi.version = 3;
  boot.loader.raspberryPi.uboot.enable = true;
  boot.loader.raspberryPi.firmwareConfig = ''gpu_mem=256'';
  environment.systemPackages = with pkgs; [
    raspberrypi-tools
  ];
  # Configure basic SSH access
  services.openssh.enable = true;
  # Allow root ssh login
  services.openssh.permitRootLogin = "yes";
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;
  # Set hostname
  networking.hostName = "<HOST NAME>";
  # File systems configuration for using the installer's partition layout
  fileSystems = {
    /*
    "/boot" = {
      device = "/dev/disk/by-label/NIXOS_BOOT";
      fsType = "vfat";
    };
    */
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
  };
  # Set up swap device
  swapDevices = [ { device = "<SWAP DEVICE NAME>"; size = <SWAP DEVICE SIZE IN BYTES>; } ];
  # Niceties
  environment.variables.EDITOR = "neovim";
  time.timeZone = "<TIMEZONE>"; # Example time zone would be America/Denver
  # User account
  users.users.<USERNAME>= {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Wheel group gives you access to the sudo command
  };
  # NTP clock synchronization
  services.timesyncd.enable = true;
  # Enable wireless networking
  networking.wireless.enable = true;
  networking.wireless.networks = {
    "<WIFI NAME>" = {
      psk = "<WIFI PASSWORD>";
    };
  };
  # Install any programs you want on the system
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    w3m
    rsync
    tmux
    neovim
  ];
}
