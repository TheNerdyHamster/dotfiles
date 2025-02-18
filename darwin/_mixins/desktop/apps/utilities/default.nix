{
    pkgs,
    ...
}:
{
    environment.systemPackages = with pkgs; [
        stats
        utm
    ];
}
