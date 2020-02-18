{ config, pkgs, lib, ... }:
{
  # NixOS wants to enable GRUB by default
  boot.loader.grub.enable = false;

  # if you have a Raspberry Pi 2 or 3, pick this:
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # A bunch of boot parameters needed for optimal runtime on RPi 3b+
  boot.kernelParams = ["cma=256M"];
  boot.loader.raspberryPi.enable = true;
  boot.loader.raspberryPi.version = 3;
  boot.loader.raspberryPi.uboot.enable = true;
  boot.loader.raspberryPi.firmwareConfig = ''
    gpu_mem=256
  '';
  environment.systemPackages = with pkgs; [
    raspberrypi-tools
  ];

  # Preserve space by sacrificing documentation and history
  #services.nixosManual.enable = false;
  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 60d";
  #boot.cleanTmpDir = true;

  # Configure basic SSH access
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "yes";

}
