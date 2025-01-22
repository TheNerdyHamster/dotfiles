{
    pkgs,
    ...
}: {
    home.packages = with pkgs; [
    ];
    
    programs.ssh = {
        enable = true;
        controlMaster = "auto";
        controlPath = "~/.ssh/sockets/master-%r@%h:%p.socket";
        controlPersist = "4h";

        extraOptionOverrides = {
            CanonicalDomains = "ladm.se loltech.se";
        };

        matchBlocks = {
            "github.com git.sr.ht" = {
                user = "git";
                identityFile = "~/.ssh/id_ed25519_sk_rk_private";
            };
            "*.ladm.se *.loltech.se" = {
                user = user;
                identityFile = "~/.ssh/id_ed25519_sk_rk_private";
            };
        };

    };
}
