{
    self, 
    myvars, 
    ...
}: {
    homebrew = {
        enable = true;
        #autoMigrate = true;
        #user = "${myvars.username}";
        onActivation = {
            autoUpdate = true;
            upgrade = true;
            cleanup = "zap";
        };

        #mutableTaps = false;
        taps = [
            "homebrew/homebrew-core"
            "homebrew/homebrew-cask"
            "homebrew/homebrew-bundle"
            "homebrew/homebrew-services"
            "felixkratz/homebrew-formulae"
        ];

        brews = [
            "wget"
            "curl"
        ];

        casks = [
            "kicad"
            "obsidian"

            "signal"

            "keycastr"
            "hyperkey"
            "osxfuse"
            "macfuse"

            # "firefox"

            "spotify"

            "font-hack-nerd-font"
            "sf-symbols"
        ];
    };
}

