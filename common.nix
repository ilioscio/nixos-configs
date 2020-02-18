# A bunch of things I expect to have on every machine I work with.

{ config, pkgs, lib, ... }:
{

  # Niceties
  environment.variables.EDITOR = "neovim";
  time.timeZone = "America/Boise";

  # My usual user account
  users.users.ilios= {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  # NTP clock synchronization
  services.timesyncd.enable = true;

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

}
