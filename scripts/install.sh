#!/usr/bin/env bash

echo "==> Installing Nix..."

for file in /etc/*.backup-before-nix; do
    [ -e "${file}" ] && sudo rm -v ${file}
done

curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

echo "==> Running first build..."

# Initial build
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
nix build "./nix#darwinConfigurations.$(hostname).system" --extra-experimental-features "nix-command flakes"

# Manual steps for nix-darwin to work with flakes
grep -q "private/var/run" /etc/synthetic.conf || printf 'run\tprivate/var/run\n' | sudo tee -a /etc/synthetic.conf
/System/Library/Filesystems/apfs.fs/Contents/Resources/apfs.util -t

for file in /etc/bashrc /etc/nix/nix.conf /etc/zshrc; do
    [ -e "${file}" ] && sudo mv ${file} ${file}.before-nix-darwin
done

echo "==> Running first switch..."

./result/sw/bin/darwin-rebuild switch --flake ./nix

grep -q "/etc/static/zshrc" /etc/zshrc || echo 'if test -e /etc/static/zshrc; then . /etc/static/zshrc; fi' | sudo tee -a /etc/zshrc

echo "==> Setup complete!"
echo "Run \"darwin-rebuild switch --flake ./nix\" to rebuild your configuration after any changes"
