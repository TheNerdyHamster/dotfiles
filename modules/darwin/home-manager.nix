{ config, pkgs, lib, home-manager, ... }:

let
    name = "TheNerdyHamster";
    user = "lol";
    email = "leo@letnh.com";
    files = import ./files.nix { inherit user config pkgs; };
in
{
    users.users.${user} = {
        name = "${user}";
        home = "/Users/${user}";
        isHidden = false;
        shell = pkgs.zsh;
    };
    
    # Nix-darwin homebrew module.
    # Base homebrew configuration is done via nix-homebrew
    homebrew = {
        enable = true;
        casks = pkgs.callPackage ./casks.nix {};
        
        # https://github.com/mas-cli/mas
        # $ nix shell nixpkgs#mas
        # $ mas search <app>
        masApps = {};
    };

    home-manager = {
        useGlobalPkgs = true;
        backupFileExtension = "bak";
        users.${user} = { pkgs, config, lib, ... }:{
            home = {
                enableNixpkgsReleaseCheck = false;
                packages = pkgs.callPackage ./packages.nix {};

                file = lib.mkMerge [
                    files
                ];
                # Fix emacs
                stateVersion = "23.11";
            };

            programs = {

                home-manager.enable = true;

                zsh = {
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

                fzf = {
                    enable = true;
                    enableZshIntegration = true;
                    defaultCommand = "ag --hidden --ignore .git -g '' ";
                };

                eza = {
                    enable = true;
                    enableZshIntegration = true;
                    git = true;
                    icons = "always";
                    colors = "always";
                };

                direnv = {
                    enable = true;
                    nix-direnv.enable = true;
                };

                ssh = {
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

                git = {
                    enable = true;
                    userName = name;
                    userEmail = email;
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

                starship = {
                    enable = true;
                    settings = {
                        format = "[](color_orange)$os$username[](bg:color_yellow fg:color_orange)$directory[](fg:color_yellow bg:color_aqua)$git_branch$git_status[](fg:color_aqua bg:color_blue)$c$rust$golang$nodejs$php$java$kotlin$haskell$python[](fg:color_blue bg:color_bg3)$docker_context$conda[](fg:color_bg3 bg:color_bg1)$time[ ](fg:color_bg1)$line_break$character";
                        palette = "gruvbox_dark";
                        palettes.gruvbox_dark = {
                            color_fg0 = "#fbf1c7";
                            color_bg1 = "#3c3836";
                            color_bg3 = "#665c54";
                            color_blue = "#458588";
                            color_aqua = "#689d6a";
                            color_green = "#98971a";
                            color_orange = "#d65d0e";
                            color_purple = "#b16286";
                            color_red = "#cc241d";
                            color_yellow = "#d79921";
                        };
                        os = {
                            disabled = false;
                            style = "bg:color_orange fg:color_fg0";
                            symbols = {
                                Windows = "󰍲";
                                Ubuntu = "󰕈";
                                SUSE = "";
                                Raspbian = "󰐿";
                                Mint = "󰣭";
                                Macos = "󰀵";
                                Manjaro = "";
                                Linux = "󰌽";
                                Gentoo = "󰣨";
                                Fedora = "󰣛";
                                Alpine = "";
                                Amazon = "";
                                Android = "";
                                Arch = "󰣇";
                                Artix = "󰣇";
                                EndeavourOS = "";
                                CentOS = "";
                                Debian = "󰣚";
                                Redhat = "󱄛";
                                RedHatEnterprise = "󱄛";
                                Pop = "";
                            };
                        };
                        username = {
                            show_always = true;
                            style_user = "bg:color_orange fg:color_fg0";
                            style_root = "bg:color_orange fg:color_fg0";
                            format = "[ $user ]($style)";
                        };
                            
                        directory = {
                            style = "fg:color_fg0 bg:color_yellow";
                            format = "[ $path ]($style)";
                            truncation_length = 3;
                            truncation_symbol = "…/";
                            
                            substitutions = {
                                "Documents" = "󰈙 ";
                                "Downloads" = " ";
                                "Music" = "󰝚 ";
                                "Pictures" = " ";
                                "Developer" = "󰲋 ";
                            };
                        };
                            
                        git_branch = {
                            symbol = "";
                            style = "bg:color_aqua";
                            format = "[[ $symbol $branch ](fg:color_fg0 bg:color_aqua)]($style)";
                        };
                            
                        git_status = {
                            style = "bg:color_aqua";
                            format = "[[($all_status$ahead_behind )](fg:color_fg0 bg:color_aqua)]($style)";
                        };
                            
                            
                        rust = {
                            symbol = "";
                            style = "bg:color_blue";
                            format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
                        };
                            
                        golang = {
                            symbol = "";
                            style = "bg:color_blue";
                            format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
                        };
                            
                        php = {
                            symbol = "";
                            style = "bg:color_blue";
                            format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
                        };
                            
                        java = {
                            symbol = "";
                            style = "bg:color_blue";
                            format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
                        };
                            
                        python = {
                            symbol = "";
                            style = "bg:color_blue";
                            format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
                        };
                            
                            
                        time = {
                            disabled = false;
                            time_format = "%R";
                            style = "bg:color_bg1";
                            format = "[[  $time ](fg:color_fg0 bg:color_bg1)]($style)";
                        };
                            
                        line_break = {
                            disabled = false;
                        };
                            
                        character = {
                            disabled = false;
                            success_symbol = "[](bold fg:color_green)";
                            error_symbol = "[](bold fg:color_red)";
                            vimcmd_symbol = "[](bold fg:color_green)";
                            vimcmd_replace_one_symbol = "[](bold fg:color_purple)";
                            vimcmd_replace_symbol = "[](bold fg:color_purple)";
                            vimcmd_visual_symbol = "[](bold fg:color_yellow)";
                        };
                    };
                };
            };
        };
    };
}
