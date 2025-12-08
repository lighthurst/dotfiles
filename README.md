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

### 📝 Vim Configuration

- **Theme**: Material.vim (dark, modern aesthetic)
- **Indentation**: Consistent 2‑space indentation (including XML and plist)
- **Search**: Smartcase, incremental search, highlighted results
- **Clipboard**: Integrated system clipboard support when available
- **UI**: Line numbers, cursorline, match highlighting, 256‑color support

All Vim configuration lives in:

```
~/dotfiles/vim/.vimrc
```

A symlink is created automatically during installation.

---

## 🚀 Quick Install

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles

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
  - .vimrc
  - VS Code settings
- Install vim-plug and automatically install all Vim plugins
- Set up VS Code settings and install all extensions listed in vscode/extensions.txt
- Configure Git with your name and email
- Install Homebrew (if not already installed)

---

## 📁 Directory Structure

```
dotfiles/
├── vscode/
│   ├── settings.json
│   └── extensions.txt
├── shell/
│   ├── .zshrc
│   └── .zprofile
├── vim/
│   └── .vimrc
├── git/
│   └── .gitconfig
├── scripts/
│   └── install.sh
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

### Vim

```bash
ln -sf ~/dotfiles/vim/.vimrc ~/.vimrc
```

### Git

```bash
cp git/.gitconfig ~/.gitconfig
# Then edit ~/.gitconfig to add your name and email
```

---

## 🎯 Key Features

### VS Code

- Berkeley Mono font
- Material Theme
- Auto-formatting with Prettier
- Minimal UI
- Essential web-dev extensions

### Shell

- Custom git alias (`glp`)
- Oh My Zsh git plugin
- Homebrew environment integration

### Vim

- Material-inspired theme
- 2‑space indentation
- Clipboard integration
- Clean UI defaults

### Git

- Auto‑setup remote branches
- Branch sorting by commit date
- Histogram diff algorithm

---

## 🔄 Staying Updated

```bash
cd ~/dotfiles
git pull origin main
./scripts/install.sh
```

---

## 🤝 Contributing

Feel free to:

- Open issues
- Submit PRs
- Fork and customize

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
