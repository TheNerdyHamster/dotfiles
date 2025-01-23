{
    config,
    myvars,
    pkgs,
    lib,
    ...
} @ args: {
    nix.package = pkgs.nixVersions.latest;
    
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elm (lib.getName pkg) [
        "discord"
    ];
    environment.systemPackages = with pkgs; [
        neofetch
        wget
        jq
        fd
        fzf
        openssh
        gcc
        coreutils
        ripgrep
        killall
        imagemagick
        yubikey-manager

        nmap
        mtr
        inetutils
        nowplaying-cli
        zip
        gnumake
        cmake
        automake
        autoconf
        mailutils
        jansson

        libfido2

        tree-sitter
        lua
        stylua
        go
        ninja
        bash-language-server
        yaml-language-server
        #biome

        #btop
        #bat
        #eza
        tokei

        git-filter-repo
    ];

    nix.settings = {
        experimental-features = ["nix-command" "flakes"];

        trusted-users = [myvars.username];
    };
}
