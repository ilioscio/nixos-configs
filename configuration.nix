{ config, pkgs, lib, ... }:
{
  imports = [
    ./rpi.nix
    ./common.nix
  ]; 

  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;
  
  # Set hostname
  networking.hostName = "bernoulli";

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
  swapDevices = [ { device = "/dev/sda1"; size = 4096; } ];

}
