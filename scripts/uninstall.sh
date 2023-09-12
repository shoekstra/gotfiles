#!/usr/bin/env bash

if [ -x "home-manager" ]; then
    echo "==> Uninstalling Home Manager..."
    home-manager uninstall
fi

echo "==> Uninstalling Nix..."
if [ -e "/nix/nix-installer" ]; then
    /nix/nix-installer uninstall
fi

echo "==> Uninstall complete!"
