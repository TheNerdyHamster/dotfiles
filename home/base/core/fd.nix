{
    pkgs,
    ...
}: {
    home.packages = with pkgs; [
    ];
    
    programs.fd = {
        enable = true;
        ignores = [
            ".git/"
            "*.bak"
            "*.tmp"
        ];
    };
}
