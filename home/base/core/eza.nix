{
    pkgs,
    ...
}: {
    home.packages = with pkgs; [
    ];
    programs.eza = {
        enable = true;
        enableZshIntegration = true;
        git = true;
        icons = "always";
        colors = "always";
    };
}
