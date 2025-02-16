hostname := `scutil --get LocalHostName`

# List all commands
default:
    @just --list

# Update all flakes 
[group("nix")]
up:
    nix flake update

# Update specific flake
# Example:
# just upp nixpkgs

[group("nix")]
upp input:
    nix flake update {{input}}

# Nix Repl
[group("nix")]
repl:
    nix repl -f flake:nixpkgs

# List all generations
[group("nix")]
history:
    nix profile history --profile /nix/var/nix/profiles/system

# Remove old generations thats older then 7 days
[group("nix")]
clean:
    sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d

# Garbage collection
[group("nix")]
gc:
    # Garbage collection system-wide
    sudo nix-collect-garbage --delete-older-than 7d
    # Garbage collect for the user aka home-manager
    nix-collect-garbage --delete-older-than 7d

[group("nix")]
fmt:
    nix fmt

[group("nix")]
gcroot:
    ls -al /nix/var/nix/gcroots/auto/

# Macos Specific commands
# Restart launchpad to force reindexing
[macos]
[group("desktop")]
restart-launchpad:
    defaults write com.apple.dock RestartLaunchPad -bool true
    killall Dock

# Rebuild and switch
[macos]
[group("desktop")]
rb:
    darwin-rebuild switch --flake .
