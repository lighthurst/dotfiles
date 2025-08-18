# Aaron's Dotfiles 🚀

My personal development environment configuration files. Clean, focused, and productivity-oriented setup for macOS.

## ✨ What's Included

### 🎨 VS Code Configuration

- **Theme**: Material Theme with clean, modern aesthetics
- **Font**: Berkeley Mono (with Operator Mono fallback)
- **Features**: Auto-save, format-on-save, no minimap for distraction-free coding
- **Extensions**: Curated selection for web development and Python

### 🐚 Shell Setup (Zsh + Oh My Zsh)

- **Theme**: Robbyrussell (clean and fast)
- **Plugins**: Git integration
- **Custom Aliases**: Enhanced git log formatting
- **Homebrew**: Properly configured shell environment

### 🔧 Git Configuration

- **Modern Features**: Auto-setup remote branches, sort by commit date
- **Performance**: Histogram diff algorithm for better diffs
- **Workflow**: Streamlined for daily development

## 🚀 Quick Install

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles

# Run the install script
cd ~/dotfiles
./scripts/install.sh
```

The install script will:

- ✅ Install Oh My Zsh (if not present)
- ✅ Backup your existing configurations
- ✅ Create symlinks to the dotfiles
- ✅ Set up VS Code settings and install extensions
- ✅ Configure Git with your personal information
- ✅ Install Homebrew (if on macOS and not present)

## 📁 Directory Structure

```
dotfiles/
├── vscode/
│   ├── settings.json      # VS Code preferences
│   └── extensions.txt     # List of extensions to install
├── shell/
│   ├── .zshrc            # Zsh configuration
│   └── .zprofile         # Shell environment setup
├── git/
│   └── .gitconfig        # Git configuration (template)
├── scripts/
│   └── install.sh        # Automated setup script
└── README.md             # This file
```

## 🛠 Manual Setup

If you prefer to set up manually:

### VS Code

1. Copy `vscode/settings.json` to `~/Library/Application Support/Code/User/settings.json`
2. Install extensions: `cat vscode/extensions.txt | xargs -L 1 code --install-extension`

### Shell Configuration

1. Link shell files:
   ```bash
   ln -sf ~/dotfiles/shell/.zshrc ~/.zshrc
   ln -sf ~/dotfiles/shell/.zprofile ~/.zprofile
   ```
2. Reload shell: `source ~/.zshrc`

### Git Configuration

1. Copy and customize:
   ```bash
   cp git/.gitconfig ~/.gitconfig
   # Edit ~/.gitconfig to add your name and email
   ```

## 🎯 Key Features

### VS Code Highlights

- **Berkeley Mono font** for excellent readability
- **Material Theme** for beautiful syntax highlighting
- **Auto-formatting** with Prettier on save
- **Minimal UI** with disabled minimap and startup editor
- **Essential extensions** for modern web development

### Shell Enhancements

- **Custom git alias** (`glp`) for beautiful commit logs
- **Oh My Zsh** with git plugin for enhanced git workflow
- **Homebrew integration** for package management

### Git Workflow

- **Auto-setup remote** branches for smoother workflow
- **Branch sorting** by commit date for better organization
- **Histogram diff** algorithm for clearer diffs

## 🔄 Staying Updated

To update your dotfiles:

```bash
cd ~/dotfiles
git pull origin main
./scripts/install.sh  # Re-run to apply any new changes
```

## 🤝 Contributing

Found a bug or have a suggestion? Feel free to:

- Open an issue
- Submit a pull request
- Fork and customize for your own use

## 📝 Notes

- **Backups**: The install script automatically backs up existing configurations
- **Customization**: Feel free to fork and modify for your needs
- **Compatibility**: Designed for macOS, may need adjustments for other systems

## 🙏 Inspiration

This setup is optimized for:

- **Web development** (JavaScript, TypeScript, React, Next.js)
- **Python development** with modern tooling
- **Clean, distraction-free coding** environment
- **Efficient git workflow** and version control

---

**Happy coding! 🎉**
