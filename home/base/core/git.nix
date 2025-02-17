{
    myvars,
    pkgs,
    ...
}: {
    home.packages = with pkgs; [
    ];

    programs.git = {
        enable = true;
        userName = myvars.name;
        userEmail = myvars.useremail;
        extraConfig = {
            core = {
                editor = "nvim";
                autocrlf = "input";
            };

            color = {
                diff = "auto";
                status = "auto";
                branch = "auto";
                ui = true;
            };

            merge = {
                conflictstyle = "zdiff3";
            };

            status = {
                submodulesummary = true;
            };

            init = {
                defaultBranch = "main";
            };

        };
        delta = {
            enable = true;
            options = {
                navigate = true;
                dark = true;
                minus-style = "syntax #37222c";
                minus-non-emph-style = "syntax #37222c";
                minus-emph-style = "syntax #713137";
                minus-empty-line-marker-style = "syntax #37222c";
                line-numbers-minus-style = "#914c54";
                plus-style = "syntax #20303b";
                plus-non-emph-style = "syntax #20303b";
                plus-emph-style = "syntax #2c5a66";
                plus-empty-line-marker-style = "syntax #20303b";
                line-numbers-plus-style = "#449dab";
                line-numbers-zero-style = "#3b4261";
            };
        };
        aliases = {
            s = "status";
            d = "diff";
            co = "checkout";
            br = "branch";
            last = "log -1 HEAD";
            cane = "commit --amend --no-edit";
            lo = "log --oneline -n 10";
            pr = "pull --rebase";
            cm = "commit";
            rh = "reset --hard";
            a = "add";
            al = "add .";
            ap = "add -p";
#pu = "push";
            loa = "log --oneline --all --decorate --graph";
            patch = "!git --no-pager diff --no-color";
# Gitlab stuff
            pms = "push -o merge_request.create";
            pmd = "push -o merge_request.create -o merge_request.draft";
            track = "!git branch --set-upstream-to=origin/\`git symbolic-ref --short HEAD\`";
            pu = "!git push -u origin `git symbolic-ref --short HEAD`";
        };

    };

}
