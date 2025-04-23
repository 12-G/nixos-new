# Like GNU `make`, but `just` rustier.
# https://just.systems/
# run `just` from this directory to see available commands

# Default command when 'just' is run without arguments
default:
  @just --list

# Update nix flake
[group('Main')]
update:
  nix flake update

# Single update flake input
[group('Main')]
nixvim:
  nix flake update nixvim

# Lint nix files
[group('dev')]
lint:
  nix fmt

# Check nix flake
[group('dev')]
check:
  nix flake check

# Manually enter dev shell
[group('dev')]
dev:
  nix develop

# Activate the configuration
[group('Main')]
run:
  nix run

# List all genereations of the system profile
[group('nix')]
history:
  nix profile history --profile /nix/var/nix/profiles/system

# remove all generations older than 5 days
[group('nix')]
clean:
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 3d

# Garbage collect all unused nix store entries
[group('nix')]
gc:
  # garbage collect all unused nix store entries(system-wide)
  sudo nix-collect-garbage --delete-older-than 5d
  # garbage collect all unused nix store entries(for the user - home-manager)
  # https://github.com/NixOS/nix/issues/8508
  nix-collect-garbage --delete-older-than 5d

[group('nix')]
find:
  nix-store -q --references /run/current-system/sw

[group('nix')]
pack:
  nix-store --gc --print-roots | rg -v '/proc/' | rg -Po '(?<= -> ).*' | xargs -o nix-tree

##################### For hostName specific build switch #####################
[group('nix')]
thinkbook:
  # switch to a new generation for thinkbook
  sudo nixos-rebuild switch --flake .#thinkbook

# check the home-manager service
[group('home')]
home:
  journalctl --unit home-manager-ethan.serivce
