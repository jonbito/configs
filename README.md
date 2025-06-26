# Dotfiles & Setup Scripts

This repository contains my personal configuration files (dotfiles) and setup scripts for quickly provisioning a new macOS or Linux environment.

## Features

- Automated Homebrew installation and package management (macOS & Linux)
- Safe symlinking of dotfiles with backup/overwrite/skip options
- Custom binaries installation to `~/.local/bin`
- Rust toolchain setup
- Modular scripts for easy customization

## Usage

**Warning:**  
This setup will overwrite your existing configuration files. Back up important files before proceeding.

### 1. Clone the repository

```sh
git clone https://github.com/yourusername/configs.git
cd configs
```

### 2. Run the installer

```sh
./install.sh
```

- Press Enter to confirm, or run with `-y` to skip confirmation.

### 3. What happens

- Existing `.zshrc` is backed up to `.zshrc.backup`
- Homebrew is installed and packages are set up via Brewfile
- Dotfiles from `tilde/` are symlinked to your home directory
- Custom scripts in `bin/` are symlinked to `~/.local/bin`
- Rust toolchain is installed and updated

## Structure

- `install.sh` — Main entry point
- `setup/brew.sh` — Homebrew installation and package setup
- `setup/symlinks.sh` — Symlinks dotfiles and custom binaries
- `setup/misc.sh` — Installs Rust and other tools
- `tilde/` — All dotfiles to be linked (e.g., `.zshrc`, `.config/`)
- `bin/` — Custom scripts to be linked to `~/.local/bin`
