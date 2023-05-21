#!/bin/bash

# Install prerequisites to running ansible

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo Detected Linux...
        # Check for Ubuntu
        if grep -q debian "/etc/os-release"; then
            echo Detected debian distro...
            # Install ansible via apt
            echo "\n\nInstalling ansible from apt ..."
            apt update
            apt install -y software-properties-common
            apt-add-repository --yes --update ppa:ansible/ansible
	        apt install -y python3 python3-pip apt-transport-https ca-certificates
            apt install -y ansible
            apt install -y ansible-lint
        # Check for alpine
        elif grep -q alpine "/etc/os-release"; then
            echo Detected alpine distro...
            # Install ansible via apk
            echo "\n\nInstalling ansible from apk ..."
            apk add python3 python3-pip
            apk add ansible
            apk add ansible-lint
        # Check for archlinux
        elif grep -q archlinux "/etc/os-release"; then
            echo Detected archlinux distro...
            # Install ansible via pacman
            echo "\n\nInstalling ansible from pacman ..."
            pacman -Syu --noconfirm
            pacman -S --noconfirm python3 python3-pip
            pacman -S --noconfirm ansible
            pacman -S --noconfirm ansible-lint
        fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo Detected Mac OSX...
        # Install homebrew
        brew_path='/opt/homebrew/bin/brew'
        if ! type brew >/dev/null; then
            echo 'Installing Homebrew...'
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

            echo '\n\nAdding Homebrew to PATH...'
            eval "$($brew_path shellenv)"

            # If we can't find homebrew after installing, fail just to be safe
            if ! type brew >/dev/null; then
                echo '\n\nERROR: Homebrew installation failed. Please install it manually according to https://brew.sh/ and re-run this script.'
                exit 1
            fi
        else
            # If we see homebrew, update and proceed
            echo "\n\nUpdating Homebrew ..."
            brew update

            eval "$($brew_path shellenv)"
        fi

        # Install ansible via Homebrew
        echo "\n\nInstalling ansible from Homebrew ..."
        HOMEBREW_NO_AUTO_UPDATE=1 brew install ansible
        HOMEBREW_NO_AUTO_UPDATE=1 brew install ansible-lint
elif [[ "$OSTYPE" == "cygwin" ]]; then
        echo "Detected POSIX compatibility layer and Linux environment emulation for Windows"
        echo This script is not supported on Cygwin
elif [[ "$OSTYPE" == "msys" ]]; then
        echo "Detected Lightweight shell and GNU utilities compiled for Windows (part of MinGW)"
        echo This script is not supported on MinGW
elif [[ "$OSTYPE" == "win32" ]]; then
        echo Detected Windows
        echo This script is not supported on Windows
elif [[ "$OSTYPE" == "freebsd"* ]]; then
        echo Detected FreeBSD
        echo This script is not supported on FreeBSD
else
        echo "Unknown OS $OSTYPE"
fi
