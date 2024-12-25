{ self, config, pkgs, ... }:

let user = "lol"; in
{

    imports = [
        ../../modules/darwin/home-manager.nix
    ];

    # Automatic upgrades of nix packages.
    services.nix-daemon.enable = true;

    # Setup users, packages and progreams
    nix = {
        package = pkgs.nix;
        configureBuildUsers = true;

        settings = {
            trusted-users = [ "@admin" "${user}" ];
            experimental-features = "nix-command flakes";
        };

        gc = {
            user = "root";
            automatic = true;
            interval = { Weekday = 0; Hour = 2; Minute = 0; };
            options = "--delete-older-then 30d";
        };
    };

    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    environment.systemPackages = with pkgs; [
        #emacs-unstable
    ];

    # Enable touchido Support for sudo.
    security.pam.enableSudoTouchIdAuth = true;

    # Enable alternative shell support in nix-darwin.
    programs.zsh.enable = true;

    system = {

        # MacOS specific settings
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
                StageManagerHideWidgets = false;
                StandardHideDesktopIcons = false;
                StandardHideWidgets = false;
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
            universalaccess.reduceMotion = true;
        };
        # Set Git commit hash for darwin-version.
        configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        stateVersion = 5;
    };

    # The platform the configuration will be used on.
    nixpkgs.hostPlatform = "aarch64-darwin";


    # users.users.lol = {
    #     name = "lol";
    #     home = "/Users/lol";
    # }
}
