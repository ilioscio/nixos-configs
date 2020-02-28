{ config, pkgs, lib, ... }:
{
  # Pi Specific Section
  # NixOS wants to enable GRUB by default, but we use u-boot on rpi
  boot.loader.grub.enable = false;
  # if you have a Raspberry Pi 2 or 3, pick this:
  boot.kernelPackages = pkgs.linuxPackages;
  # A bunch of boot parameters needed for optimal runtime on RPi 3b+
  boot.kernelParams = ["cma=256M"];
  boot.loader.raspberryPi.enable = true;
  boot.loader.raspberryPi.version = 3;
  boot.loader.raspberryPi.uboot.enable = true;
  boot.loader.raspberryPi.firmwareConfig = ''gpu_mem=256'';
  environment.systemPackages = with pkgs; [
    raspberrypi-tools
  ];
  
  # Other System Section
  # Preserve space by deleting generations older than 60d
  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 30d";
  # Configure basic SSH access
  services.openssh.enable = true;
  # Allow root ssh login
  #services.openssh.permitRootLogin = "yes";
  # NTP clock synchronization
  services.timesyncd.enable = true;
  
  # Virtualisation section
  virtualisation.docker.enable = true;
  
  # Enviroment section
  # Set hostname
  #networking.hostName = "";
  environment.variables.EDITOR = "neovim";
  #time.timeZone = "";
  # My usual user account
  users.users.ilios= {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker"];
  };
  # Install things I'm used to having around
  environment.systemPackages = with pkgs; [
    neovim
    git
    wget
    curl
    w3m 
    ncdu
    iftop
    iotop
    rsync
    tmux
  ];

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
  #swapDevices = [ { device = "/dev/sda1"; size = 4096; } ];
  
}
