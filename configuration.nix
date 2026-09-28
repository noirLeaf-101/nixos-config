{ config, pkgs, ... }:

{
  imports =
  [ # Import other files
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Define your hostname
  networking.hostName = "nixos";

  # Enable Networking
  networking.networkmanager.enable = true;

  # Set your time zone
  time.timeZone = "Asia/Karachi";

  # Select internationalisation properties
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the KDE Plasma Desktop Environment
  services.displayManager.plasma-login-manager.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Exclude pre-installed KDE Plasma packages
  environment.plasma6.excludePackages = with pkgs; [
  kdePackages.elisa
  kdePackages.discover
  kdePackages.qrca
  kdePackages.plasma-browser-integration
  ];

  # Fix font rendering / RGB subpixel settings.
  fonts.fontconfig = {
  enable = true;
  antialias = true;
  hinting.style = "slight";

  subpixel = {
  rgba = "rgb";
  lcdfilter = "default";
    };
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable sound with pipewire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."ar" = {
    isNormalUser = true;
    description = "ar";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Nvidia Drivers
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;

  # List services that you want to enable
  services.flatpak.enable = true;
  virtualisation.podman.enable = true;
  zramSwap.enable = true;

  # List aliases
  environment.shellAliases = {
  update = "sudo nixos-rebuild switch";
  };

  system.stateVersion = "26.05";
}
