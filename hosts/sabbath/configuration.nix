# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, system, inputs, stable, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "sabbath"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.nameservers = [ "1.1.1.1" "9.9.9.9" ];

  networking.extraHosts = ''
  127.0.0.1 db-fancy.feldera.com
  '';

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "Asia/Kathmandu";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  # Enable tailscale
  services.tailscale.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Budgie Desktop environment.
  services.xserver.displayManager.lightdm.enable = false;
  services.xserver.desktopManager.budgie.enable = false;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.greetd = {
    enable = true;

    settings.default_session = {
      command = "Hyprland";
      user = "abhizer";
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # enable docker
  virtualisation.docker.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    dart-sass
    cyrus_sasl.dev
    cyrus_sasl.out
    zstd.dev
    zstd.out
    llvmPackages.libclang
    clang
    zlib
    libxml2
    # stable.nodePackages_latest.rollup
  ];

  # Enable zsh
  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.abhizer = {
    isNormalUser = true;
    description = "Abhinav Gyawali";
    extraGroups = [ "networkmanager" "wheel" "input" "docker" ];
    packages = with pkgs; [
	home-manager
    ];
    shell = pkgs.zsh;
  };

  # Home manager configuration.
  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = { inherit inputs system stable; };
    users = {
      "abhizer" = { imports = [ ./home.nix ./../../modules/home ]; };
    };
  };

  nix.extraOptions = ''
        trusted-users = root abhizer
  '';

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
  ];

  environment.variables.PATH = [ "/home/abhizer/.cargo/bin" ];
  #
  # system.activationScripts.linkZoneinfo = {
  # text = ''
  #   mkdir /usr/share
  #   ln -sfn /etc/zoneinfo /usr/share/zoneinfo
  # '';
  # };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "mydatabase" ];
    enableTCPIP = true;
    settings.port = 5432;
    authentication = pkgs.lib.mkOverride 10 ''
      #type database DBuser origin-address auth-method
      local all      all     trust
      # ... other auth rules ...

      # ipv4
      host  all      all     127.0.0.1/32   trust
      # ipv6
      host  all      all     ::1/128        trust
    '';
  };

  services.minio = {
    enable = true;

    consoleAddress = "0.0.0.0:9001";
    listenAddress = "0.0.0.0:9000";

    rootCredentialsFile = "/etc/minio/credentials";
  };

  services.openvpn.servers = {
    # awsVPN = {
    #   config = '' config /home/abhizer/Development/aws_vpn/vpc.ovpn '';
    #   updateResolvConf = true;
    # };
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 9000 ];
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?


  fileSystems."/home/abhizer/Development" = { device = "/dev/disk/by-uuid/6114954c-434c-4673-a7ec-f1bb41aab592"; fsType = "ext4"; };
  fileSystems."/home/abhizer/Extras" = { device = "/dev/disk/by-uuid/418a8de9-e3f3-49ee-856e-12947ac25cfc"; fsType = "ext4"; };
}
