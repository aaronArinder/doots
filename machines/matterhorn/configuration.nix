# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "matterhorn"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "America/Detroit";

  networking.useDHCP = true;
  networking.interfaces.enp3s0.useDHCP = true;

  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
      defaultSession = "none+i3";
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
	    i3status
	    i3lock
      ];
    };

    videoDrivers = [ "nvidia" ];

  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;

   users.users.aaron = {
     isNormalUser = true;
     extraGroups = [
     	"wheel"
	    "audio"
   	    # adding docker to user's extraGroups equivalent to running as root
	    "docker"
     ];
     # enable 'sudo' for user
     shell = pkgs.zsh;
   };

   virtualisation.docker = {
     enable = true;
   };

   environment.systemPackages = with pkgs; [
     vim
     curl
     git
     wget
     i3
     alacritty
     zsh
     bash
     pulseaudio # possible remove?
     #firefox
     docker
     bottles
   ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in firewall for Source Dedicated Server
  };

  programs.zsh = {
  	enable = true;
	autosuggestions.enable = true;
	syntaxHighlighting.enable = true;

	ohMyZsh = {
		plugins = ["git"];
		theme = "agnoster";

	};
  };

  fonts.fonts = with pkgs; [
    carlito
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}

