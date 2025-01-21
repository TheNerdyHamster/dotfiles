{
    pkgs,
    ...
}: {
    home.packages = with pkgs; [
    ];
    
    programs.fd = {
        enable = true;
        ignore = [
            ".git/"
            "*.bak"
            "*.tmp"
        ];
    };
}
