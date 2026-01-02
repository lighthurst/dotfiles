# Aaron's Dotfiles 🚀

My personal development environment configuration files. Clean, focused, and productivity-oriented setup for macOS.

## ✨ What's Included

### 🎨 VS Code Configuration

- **Theme**: Material Theme with clean, modern aesthetics
- **Font**: Berkeley Mono (with Operator Mono fallback)
- **Features**: Auto-save, format-on-save, no minimap for distraction-free coding
- **Extensions**: Curated selection for web development, Python, and Rust

### 🐚 Shell Setup (Zsh + Oh My Zsh)

- **Theme**: Robbyrussell (clean and fast)
- **Plugins**: Git integration
- **Custom Aliases**: Enhanced git log formatting
- **Homebrew**: Properly configured shell environment
- **direnv**: Auto-loads `.envrc` files per directory (if installed, see `.envrc.example`)

### 🍺 CLI Tools (Brewfile)

- **fd**: Fast file finder (find alternative)
- **fzf**: Fuzzy finder
- **jq**: JSON processor
- **ripgrep**: Fast grep (rg)
- **shfmt**: Shell script formatter

### 🔐 SSH Configuration

- **1Password SSH Agent**: Keys managed by 1Password, no private keys on disk
- **Touch ID**: Biometric authentication for SSH operations
- **Requires**: [1Password SSH Agent](https://developer.1password.com/docs/ssh/get-started) enabled

### 🔧 Git Configuration

- **Modern Features**: Auto-setup remote branches, sort by commit date
- **Performance**: Histogram diff algorithm for better diffs
- **Workflow**: Streamlined for daily development

### 📝 Vim Configuration

- **Theme**: vim-material (dark, modern aesthetic)
- **Indentation**: Consistent 2‑space indentation (including XML and plist)
- **Search**: Smartcase, incremental search, highlighted results
- **Clipboard**: Integrated system clipboard support when available
- **UI**: Line numbers, cursorline, match highlighting, 256‑color support
- **Linting/Formatting**: ALE with format-on-save (prettier, ruff, shfmt, rustfmt)

All Vim configuration lives in:

```
~/dotfiles/vim/.vimrc
```

A symlink is created automatically during installation.

### ⚡ Neovim Configuration

Based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) with the following customizations:

- **Arrow keys disabled** - Forces hjkl navigation habits
- **Formatters** - prettier (html/css/js/ts/json/yaml), ruff (python), shfmt (shell), rustfmt (rust)
- **Plugins enabled** - autopairs, neo-tree

All Neovim configuration lives in:

```
~/dotfiles/nvim/
```

A symlink is created automatically during installation (`~/.config/nvim` → `~/dotfiles/nvim`).

---

## 🚀 Quick Install

```bash
# Clone the repository
git clone https://github.com/lighthurst/dotfiles.git ~/dotfiles

# Run the install script
cd ~/dotfiles
./scripts/install.sh
```

The install script will:

- Install Oh My Zsh (if not present)
- Back up any existing configuration files (shell, Git, Vim, VS Code)
- Create symlinks for:
  - .zshrc
  - .zprofile
  - .ssh/config
  - .vimrc
  - VS Code settings
- Install vim-plug and automatically install all Vim plugins
- Set up VS Code settings and install all extensions listed in vscode/extensions.txt
- Configure Git with your name and email
- Set up global gitignore (merges with existing, won't overwrite)
- Install Homebrew (if not already installed)
- Install CLI tools from Brewfile

---

## 📁 Directory Structure

```
dotfiles/
├── .envrc.example
├── Brewfile
├── vscode/
│   ├── settings.json
│   └── extensions.txt
├── shell/
│   ├── .zshrc
│   └── .zprofile
├── ssh/
│   ├── config
│   └── config.local.example
├── vim/
│   └── .vimrc
├── nvim/
│   ├── init.lua
│   └── lua/
├── git/
│   ├── .gitconfig
│   ├── .gitconfig.local.example
│   └── gitignore_global
├── scripts/
│   ├── install.sh
│   └── update.sh
├── server/
│   ├── .vimrc
│   ├── .gitconfig
│   └── setup.sh
└── README.md
```

---

## 🛠 Manual Setup

### VS Code

Copy settings:

```bash
cp vscode/settings.json "~/Library/Application Support/Code/User/settings.json"
```

Install extensions:

```bash
cat vscode/extensions.txt | xargs -L 1 code --install-extension
```

### Shell

```bash
ln -sf ~/dotfiles/shell/.zshrc ~/.zshrc
ln -sf ~/dotfiles/shell/.zprofile ~/.zprofile
source ~/.zshrc
```

### SSH

```bash
mkdir -p ~/.ssh && chmod 700 ~/.ssh
ln -sf ~/dotfiles/ssh/config ~/.ssh/config
chmod 600 ~/.ssh/config
touch ~/.ssh/config.local && chmod 600 ~/.ssh/config.local
```

Requires [1Password SSH Agent](https://developer.1password.com/docs/ssh/get-started) to be enabled. Add private host configurations to `~/.ssh/config.local`.

### Vim

```bash
ln -sf ~/dotfiles/vim/.vimrc ~/.vimrc
```

### Neovim

```bash
mkdir -p ~/.config
ln -sf ~/dotfiles/nvim ~/.config/nvim
```

### Git

```bash
ln -sf ~/dotfiles/git/.gitconfig ~/.gitconfig
cp git/.gitconfig.local.example ~/.gitconfig.local
# Then edit ~/.gitconfig.local with your name and email
```

### CLI Tools

```bash
brew bundle --file=~/dotfiles/Brewfile
```

---

## 🔄 Staying Updated

Use the update script to pull the latest changes and re-run installation:

```bash
./scripts/update.sh
```

Or use the `dotup` alias (available after installation):

```bash
dotup
```

---

## 🖥 Remote Server Setup

Minimal configs for remote servers (Ubuntu, AWS, etc.) without macOS dependencies.

**One-liner install:**

```bash
curl -fsSL https://raw.githubusercontent.com/lighthurst/dotfiles/main/server/setup.sh | bash
```

**Or manually:**

```bash
scp ~/dotfiles/server/.vimrc your-server:~/.vimrc
scp ~/dotfiles/server/.gitconfig your-server:~/.gitconfig
```

The setup script will prompt for your git name and email.

The server configs include:
- Vim: Core settings, no plugins required
- Git: Modern defaults (rebase on pull, histogram diff, branch sort)

---

## 🤝 Contributing

Feel free to:

- Open issues
- Submit PRs
- Fork and customize

---

## 🛠 Troubleshooting

**Shell script formatting (spaces vs tabs)**

Shell scripts in this repo use shfmt with 2-space indentation. VS Code is configured
to use the Shell Script Formatter extension to enforce this.

If formatting behaves unexpectedly:

- Ensure shfmt is installed (`brew install shfmt`)
- Verify shell-format extension version is compatible (v7.2.2 works reliably)

Relevant VS Code settings:

```json
"[shellscript]": {
  "editor.defaultFormatter": "foxundermoon.shell-format",
  "editor.tabSize": 2,
  "editor.insertSpaces": true
},
"shellformat.path": "/opt/homebrew/bin/shfmt",
"shellformat.flag": "-i 2"
```

**`brew bundle` fails with "could not symlink"**

If a formula (e.g., shfmt) conflicts with an existing binary:

```bash
brew link --overwrite <formula>
```

This can happen if a VS Code extension or other tool installed its own copy first.

---

## 📝 Notes

- Install script automatically backs up existing files
- Designed for macOS
- Easy to extend and personalize

---

## 🙏 Inspiration

Optimized for:

- Web development (JS/TS/React/Next.js)
- Python tooling
- Clean, distraction‑free environments
- Efficient Git workflows

---

**Happy coding! 🎉**
