{ pkgs, ... }:

with pkgs; [
    # General packages
    wget
    curl
    neofetch
    jq
    fd
    fzf
    openssh
    gcc
    coreutils
    ripgrep
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
    starship
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
    go
    ninja
    bash-language-server
    yaml-language-server
    biome


    # Custom stuff
    btop
    bat
    eza
    tokei

    # Git
    delta
    git-filter-repo
    git
]
