{
    pkgs,
    ...
}: {
    home.packages = with pkgs; [
    ];

    programs.btop = {
        enable = true;
        settings = {
            color_theme = "tokyo-night";
            theme_background = false;
        };
    };
}
