#!/usr/bin/env bash

if [ -x "home-manager" ]; then
    echo "==> Uninstalling Home Manager..."
    home-manager uninstall
fi

echo "==> Uninstalling Nix..."
/nix/nix-installer uninstall

echo "==> Uninstall complete!"
