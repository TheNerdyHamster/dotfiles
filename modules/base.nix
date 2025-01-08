{
    config,
    pkgs,
    ...
} @ args: {
    nix.package = pkgs.nixVersions.latest;

    environment.systemPackages = with pkgs; [

    ];

    nix.settings = {
        experimental-features = ["nix-command" "flakes"];

        trusted-users = ["lol"];
    };
}
