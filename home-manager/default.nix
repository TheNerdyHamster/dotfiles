{
    config,
    inputs,
    lib,
    outputs,
    pkgs,
    stateVersion,
    username,
    ...
}:
let
    inherit (pkgs.stdenv) isDarwin;
in
{
    imports = [
        inputs.nix-index-database.hmModules.nix-index
    ];

    home = {
        inherit stateVersion;
        inherit username;
        homeDirectory =
            if isDarwin then
                "/Users/${username}"
            else
                "/home/${username}";

        sessionVariables = {
            EDITOR = "emacs";
            PAGER = "bat";
            VISUAL = "emacs";
        };
    };

    fonts.fontconfig.enable = true;

    news.display = "silent";

    nixpkgs = {
        overlays = [

        ];

        config = {
            allowUnfree = true;
        };
    };

    nix = {
        package = pkgs.nixVersions.latest;
    };
}
