{
  config,
  hostname,
  inputs,
  lib,
  outputs,
  pkgs,
  platform,
  username,
  ...
}: {
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
    inputs.nix-index-database.darwinModules.nix-index
    ./${hostname}
    ./_mixins/desktop
    ./_mixins/features
    ./_mixins/scripts
  ];

  documentation.enable = true;
  documentation.doc.enable = false;
  documentation.info.enable = false;
  documentation.man.enable = true;

  environment = {
    shells = [pkgs.zsh];
    systemPackages = with pkgs; [
      git
      m-cli
      mas
      nix-output-monitor
      sops

      utm
      gnugrep
      gnutar
      dockutil
    ];

    variables = {
      EDITOR = "emacs";
      VISUAL = "emacs";
    };
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
    brews = [
      "wget"
      "curl"
    ];

    casks = [
      "kicad"
      "obsidian"

      "signal"

      "gnucash"

      "keycastr"
      "hyperkey"
      "osxfuse"
      "macfuse"

      # "firefox"

      "spotify"

      "sf-symbols"
    ];
  };

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    autoMigrate = true;
    user = "${username}";
    mutableTaps = true;
    taps = {
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
      "homebrew/homebrew-services" = inputs.homebrew-services;
      "felixkratz/homebrew-formulae" = inputs.felixkratz-formulae;
      "homebrew/homebrew-core" = inputs.homebrew-core;
    };
  };
  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = lib.mkDefault "${platform}";
    overlays = [
      inputs.darwin-emacs.overlays.emacs
      inputs.darwin-emacs-packages.overlays.package
    ];
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      experimental-features = "flakes nix-command";
      flake-registry = "";
      nix-path = config.nix.nixPath;
      trusted-users = [
        "root"
        "${username}"
      ];
      warn-dirty = false;
    };

    channel.enable = false;
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  networking.hostName = hostname;
  networking.computerName = hostname;

  programs = {
    zsh = {
      enable = true;
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    info.enable = false;
    nix-index-database.comma.enable = true;
  };

  security.pam.enableSudoTouchIdAuth = true;

  services = {
  };

  system = {
    stateVersion = 6;
    activationScripts = {
      nixos-needsreboot = {
        supportDryActivation = true;
        text = "${lib.getExe inputs.nixos-needsreboot.packages.${pkgs.system}.default} \"$systemConfig\" || true";
      };
      # Reload the settings and apply them without needing to logout/login
      postUserActivation.text = ''
        /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
      '';
    };
    defaults = {
      ".GlobalPreferences" = {
        "com.apple.sound.beep.sound" = "/System/Library/Sounds/Frog.aiff";
      };
      LaunchServices = {
        LSQuarantine = true;
      };
      NSGlobalDomain = {
        AppleEnableMouseSwipeNavigateWithScrolls = true;
        AppleEnableSwipeNavigateWithScrolls = true;
        AppleICUForce24HourTime = false;
        AppleInterfaceStyleSwitchesAutomatically = false;
        AppleMeasurementUnits = "Centimeters";
        AppleMetricUnits = 1;
        AppleScrollerPagingBehavior = true;
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        AppleShowScrollBars = "WhenScrolling";
        AppleSpacesSwitchOnActivate = false;
        AppleTemperatureUnit = "Celsius";
        InitialKeyRepeat = 25;
        KeyRepeat = 5;
        NSDocumentSaveNewDocumentsToCloud = false;
        NSTableViewDefaultSizeMode = 1;
        NSWindowShouldDragOnGesture = true;
        _HIHideMenuBar = true;
        "com.apple.trackpad.forceClick" = true;
        "com.apple.trackpad.scaling" = 2.0;
        "com.apple.trackpad.trackpadCornerClickBehavior" = 1;
      };
      SoftwareUpdate = {
        AutomaticallyInstallMacOSUpdates = false;
      };
      WindowManager = {
        AppWindowGroupingBehavior = true;
        AutoHide = false;
        EnableStandardClickToShowDesktop = false;
        EnableTiledWindowMargins = false;
        HideDesktop = true;
        StandardHideDesktopIcons = false;
        StandardHideWidgets = false;
        StageManagerHideWidgets = false;
      };
      alf = {
        globalstate = 0;
        allowdownloadsignedenabled = 0; # Should be 1;
        allowsignedenabled = 1;
        loggingenabled = 0;
        stealthenabled = 1;
      };
      controlcenter = {
        AirDrop = false;
        Bluetooth = true;
        # Set bellow default to 2
        Display = null;
        FocusModes = null;
        NowPlaying = null;
        Sound = null;
      };
      dock = {
        autohide = true;
        mru-spaces = false;
        orientation = "bottom";
        show-recents = false;
        showhidden = false;
        static-only = true;
        wvous-br-corner = 13;
      };
      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        ShowExternalHardDrivesOnDesktop = false;
        ShowPathbar = true;
        ShowRemovableMediaOnDesktop = false;
        ShowStatusBar = true;
        _FXShowPosixPathInTitle = true;
        _FXSortFoldersFirst = true;
      };
      hitoolbox = {
        AppleFnUsageType = "Change Input Source";
      };
      loginwindow = {
        GuestEnabled = false;
      };
      menuExtraClock = {
        ShowAMPM = true;
        ShowDayOfWeek = true;
        ShowDate = 0;
      };
      screencapture = {
        location = "~/Pictures/";
      };
      screensaver = {
        askForPassword = true;
        askForPasswordDelay = 0;
      };
      spaces.spans-displays = false;
      trackpad.TrackpadRightClick = true;
      trackpad.TrackpadThreeFingerTapGesture = 0;
      #universalaccess.reduceMotion = true;

      CustomUserPreferences = {
        "com.apple.AdLib" = {
          allowApplePersonalizedAdertising = false;
        };
        ".GlobalPreferences" = {
          AppleSpacesSwitchOnActivate = true;
        };
        "com.apple.desktopservices" = {
          # Dont create .DS_Store files on network and usb drives.
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        "com.apple.commerce".AutoUpdate = true;
      };
    };
  };

  services = {
    emacs = {
      enable = true;
      package = pkgs.emacs-30;
    };
  };
}
