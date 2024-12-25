{ user, config, pkgs, ... }:

let
  xdg_configHome = "${config.users.users.${user}.home}/.config";
  xdg_home = "${config.users.users.${user}.home}"; in
  {
    "${xdg_home}/.plugins.zsh" = {
        executable = false;
        text = ''
            # Plugins
            zinit light zsh-users/zsh-syntax-highlighting
            zinit light zsh-users/zsh-completions
            zinit light zsh-users/zsh-autosuggestions
            # Snippets
            zinit snippet OMZP::command-not-found
            zinit snippet OMZP::colored-man-pages
        '';
    };
  }
