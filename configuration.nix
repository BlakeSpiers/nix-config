# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      # default
      ./hardware-configuration.nix
      #After Symlink
      #/etc/nixos/hardware-configuration.nix
      <home-manager/nixos>
    ];

  # NixOS Version
  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
    dates = "daily";
  };

  #Enable Flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Sydney";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.utf8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "au";
    xkbVariant = "";
  };

  services.xserver.videoDrivers = ["nvidia"];
  hardware.opengl.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.blake = {
    isNormalUser = true;
    description = "Blake Spiers";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  fonts = {
    fonts = with pkgs; [
      (nerdfonts.override { fonts = ["Hack"];})
    ];
    fontDir.enable = true;
  };

  home-manager.users.blake = { pkgs, ... }: {
    nixpkgs.config.allowUnfree = true;

    home.packages = with pkgs; [
      firefox
      neovim
      tmux
      ripgrep
      fd
      emacs
      spotify
      starship
    ];

    programs.git = {
      enable = true;
      userName = "Blake Spiers";
      userEmail = "blakespiers93@gmail.com";
      extraConfig = {
        core.editor = "nvim";
      };
    };

    programs.alacritty = {
      enable = true;
      settings = {
        shell.program = "${pkgs.fish}/bin/fish";

        window = {
	  startup_mode = "Fullscreen";
	};

	font = {
	  normal.family = "Hack Nerd Font Mono";
	  bold.family = "Hack Nerd Font Mono";
	  italic.family = "Hack Nerd Font Mono";
	  size = 10.0;
	  offset = {
	    x = 0;
	    y = 0;
	  };
	  glyph_offset = {
	   x = 0;
	   y = 0;
	  };
	};
      };
    };

    programs.fish = {
      enable = true;
      interactiveShellInit = "
        starship init fish | source
      ";
    };

    dconf.settings = {
      "org/gnome/mutter" = {
        experimental-features = ["x11-randr-fractional-scaling"];
      };
    };
  };

  # Allow unfree packages
  # Required for nvidia
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
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
  system.stateVersion = "22.05"; # Did you read the comment?

}
