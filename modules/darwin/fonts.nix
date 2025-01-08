{pkgs, ...}: {

    fonts = {
        packages = with pkgs; [
            material-design-icons
            # Nerd fonts can be found here: https://github.com/NixOS/nixpkgs/blob/nixos-unstable-small/pkgs/data/fonts/nerd-fonts/manifests/fonts.json
            nerd-fonts.symbols-only
            nerd-fonts.fira-code
            nerd-fonts.hack
        ];
    };
}
