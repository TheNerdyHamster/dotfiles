{
    pkgs,
    ...
}: {
    home.packages = with pkgs; [
    ];

    # programs.ghostty = {
    #     enable = true;
    #     enableZshIntegration = true;
    # };
}
