{
    config,
    pkgs,
    ...
}: {
    home.packages = with pkgs; [
        zinit
    ];

    home.file.".plugins.zsh".text = ''
        # Plugins
        zinit light zsh-users/zsh-syntax-highlighting
        zinit light zsh-users/zsh-completions
        zinit light zsh-users/zsh-autosuggestions
        # Snippets
        zinit snippet OMZP::command-not-found
        zinit snippet OMZP::colored-man-pages
    '';
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autocd = true;
        defaultKeymap = "emacs";
        autosuggestion = {
            enable = true;
        };
        initExtraBeforeCompInit = ''
            setopt extendedglob nomatch notify
            unsetopt beep
# Zinit
            source "${pkgs.zinit}/share/zinit/zinit.zsh"
            source $HOME/.plugins.zsh
            '';
        completionInit = ''
            autoload -U zmv
            autoload -U promptinit && promptinit
            autoload colors && colors
            autoload -Uz compinit
            compinit
            zinit cdreplay -q
            '';
        history = {
            path = "$HOME/.zsh_history";
            size = 50000;
            save = 100000;
            expireDuplicatesFirst = true;
            extended = true;
            ignoreDups = true;
            ignoreSpace = true;
            share = false;
            ignorePatterns = [
                "rm *"
            ];
        };
        dirHashes = {
            code = "$HOME/Documents/code";
            conf = "$HOME/.config";
            docs = "$HOME/Documents";
            dl = "$HOME/Downloads";
            pic = "$HOME/Pictures";
        };
        shellAliases = {
# Terminal
            c = "clear";
            szsh = "source ~/.zshrc";

# Vim
            vi = "nvim";
            vim = "nvim";

# Navigation
            ".." = "cd ..";
            "..." = "cd ../..";
            "...." = "cd ../..";

# Git aliases
            gcm = "git commit";
            ga = "git add";
            gb = "git branch";
            gba = "git branch --all";
            gcp = "git cherry-pick";
            gd = "git diff -w";
            gds = "git diff -w --staged";
            grs = "git restore --staged";
            gst = "git rev-parse --git-dir > /dev/null 2>&1 && git status || eza";
            gcan = "gc --amend --no-edit";
        };
    };
}
