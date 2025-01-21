{
    pkgs,
    ...
}: {
    home.packages = with pkgs; [
    ];

    programs.fzf = {
        enable = true;
        enableZshIntegration = true;
        defaultCommand = "ag --hidden --ignore .git -g ''";
    };
}
