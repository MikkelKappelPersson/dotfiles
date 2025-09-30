#!/bin/bash

# Exit immediately if bitwarden CLI is already available and working
if command -v bw >/dev/null 2>&1; then
    # Check if we can run bw status (means it's properly installed)
    if bw status >/dev/null 2>&1; then
        exit 0
    fi
fi

echo "Installing Bitwarden CLI..."

case "$(uname -s)" in
    Linux)
        # Check for different package managers
        if command -v yay >/dev/null 2>&1; then
            yay -S --needed --noconfirm bitwarden-cli
        elif command -v pacman >/dev/null 2>&1; then
            sudo pacman -S --needed --noconfirm bitwarden-cli
        elif command -v apt >/dev/null 2>&1; then
            # Debian/Ubuntu
            sudo apt update && sudo apt install -y bitwarden-cli
        elif command -v dnf >/dev/null 2>&1; then
            # Fedora
            sudo dnf install -y bitwarden-cli
        else
            echo "No supported package manager found"
            exit 1
        fi
        ;;
    Darwin)
        # macOS
        if command -v brew >/dev/null 2>&1; then
            brew install bitwarden-cli
        else
            echo "Homebrew not found, please install it first"
            exit 1
        fi
        ;;
    *)
        echo "Unsupported OS: $(uname -s)"
        exit 1
        ;;
esac

echo "Bitwarden CLI installed successfully"