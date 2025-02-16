{pkgs, ...}: 
{
    time.timeZone = "Europe/Stockholm";

    system = {
        # activationScripts are executed every time you boot the system or run `nixos-rebuild` / `darwin-rebuild`.
        activationScripts.postUserActivation.text = ''
            # activateSettings -u will reload the settings from the database and apply them to the current session,
            # so we do not need to logout and login again to make the changes take effect.
            /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
        '';

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
            #universalaccess.reduceMotion = true;

            CustomUserPreferences = {
                ".GlobalPreferences" = {
                    AppleSpacesSwitchOnActivate = true;
                };
                "com.apple.desktopservices" = {
                    # Dont create .DS_Store files on network and usb drives.
                    DSDontWriteNetworkStores = true;
                    DSDontWriteUSBStores = true;
                };
            };
        };

    };
}
