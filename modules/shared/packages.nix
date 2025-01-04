{ pkgs, ... }:

with pkgs; [
    # General packages
    zinit
    wget
    curl
    neovim
    neofetch
    openssh
    silver-searcher
    gcc
    coreutils
    #sqlite installed as a dependency
    killall
    imagemagick
    sqlite
    # switchaudio-osx # - Build package yourself
    yubikey-manager

    # Utilities
    nmap
    mtr
    inetutils
    nowplaying-cli
    zip
    # xz
    # lz4
    gnumake
    cmake
    automake
    autoconf
    mailutils
    jansson

    # Macos shit
    yabai
    skhd
    sketchybar
    spicetify-cli


    # Encryption and security stuff
    libfido2
    
    # Programing
    tree-sitter
    lua
    stylua
    rustup
    go # Migrate to homemanager
    ninja
    bash-language-server
    yaml-language-server
    biome

    just
    # Custom stuff
    tokei

    # NIX Generator
    nixos-generators

    # Git
    git-filter-repo
]
