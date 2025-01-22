{ pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        gnugrep
        gnutar

        # Macos specific
        utm
        yabai
        skhd
        sketchybar
        dockutil
    ];
}
