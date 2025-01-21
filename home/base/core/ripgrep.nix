
{
    pkgs,
    ...
}: {
    home.packages = with pkgs; [
    ];
    
    programs.ripgrep = {
        enable = true;
        arguments = [
            "--max-columns-preview"
            "--pretty"
        ];
    };
}
