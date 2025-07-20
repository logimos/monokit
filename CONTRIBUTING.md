# Contributing to Monokit 🤝

Thank you for your interest in contributing to Monokit! This document provides guidelines and information for contributors.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Project Structure](#project-structure)
- [Adding Features](#adding-features)
- [Adding New App Types](#adding-new-app-types)
- [Testing Your Changes](#testing-your-changes)
- [Submitting Changes](#submitting-changes)
- [Release Process](#release-process)

## 📜 Code of Conduct

This project adheres to the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

## 🚀 Getting Started

### Prerequisites

- **Node.js 18+** - [Download here](https://nodejs.org/)
- **PNPM 8+** - Install with `npm install -g pnpm`
- **Git** - [Download here](https://git-scm.com/)
- **Bash** - Available on most Unix-like systems

### Quick Start

1. **Fork the repository** on GitHub
2. **Clone your fork**:
   ```bash
   git clone https://github.com/YOUR_USERNAME/monokit.git
   cd monokit
   ```
3. **Install dependencies**:
   ```bash
   pnpm install
   ```
4. **Make your fork executable**:
   ```bash
   chmod +x monokit
   ```

## 🛠️ Development Setup

### Local Development

1. **Test the script locally**:
   ```bash
   # Test basic functionality
   ./monokit --help
   
   # Test initialization
   ./monokit init test-project
   cd test-project
   
   # Test adding packages
   ../monokit add lib test-lib
   ../monokit add app test-app
   ```

2. **Create a test environment**:
   ```bash
   # Create a temporary directory for testing
   mkdir -p ~/monokit-test
   cd ~/monokit-test
   
   # Test the full workflow
   /path/to/your/monokit init my-test-repo
   cd my-test-repo
   /path/to/your/monokit add lib utils
   /path/to/your/monokit add app cli-tool
   ```

### Development Tools

- **Prettier**: Code formatting
  ```bash
  pnpm format
  ```
- **ShellCheck**: Bash script linting (optional)
  ```bash
  # Install shellcheck
  sudo apt-get install shellcheck  # Ubuntu/Debian
  brew install shellcheck          # macOS
  
  # Check scripts
  shellcheck monokit
  shellcheck monokit-files/*.sh
  ```

## 📁 Project Structure

```
monokit/
├── monokit                    # Main CLI script
├── monokit-files/            # Modular script components
│   ├── cli-app.sh           # CLI application template
│   ├── express-app.sh       # Express API template
│   ├── vite-app.sh          # Vite React template
│   ├── nextjs-app.sh        # Next.js template
│   ├── github-actions.sh    # GitHub Actions setup
│   └── readme.sh            # README generation
├── install.sh                # Installation script
├── package.json              # NPM package configuration
├── README.md                 # Main documentation
├── CONTRIBUTING.md           # This file
└── LICENSE                   # MIT license
```

## ✨ Adding Features

### Guidelines

1. **Follow existing patterns** - Study the current code structure
2. **Add error handling** - Use the `error()` function for failures
3. **Add success messages** - Use the `success()` function for confirmations
4. **Test thoroughly** - Test your changes with different scenarios
5. **Update documentation** - Keep README.md and this file updated

### Example: Adding a New Command

```bash
# In monokit script, add to the case statement:
case "$COMMAND" in
  # ... existing commands ...
  new-command)
    new_command_function "$@"
    ;;
  # ... rest of commands ...
esac

# Add the function:
new_command_function() {
  # Your implementation here
  success "New command completed successfully"
}
```

## 🆕 Adding New App Types

### Step-by-Step Guide

1. **Create the template script**:
   ```bash
   # Create monokit-files/new-app-type.sh
   touch monokit-files/new-app-type.sh
   chmod +x monokit-files/new-app-type.sh
   ```

2. **Implement the creation function**:
   ```bash
   #!/bin/bash
   
   create_new_app_type() {
     local DEST=$1
     local PKG_NAME=$2
     local TS_NAME=$3
   
     echo "🛠 Setting up New App Type..."
     
     # Create package.json
     cat > "$DEST/package.json" <<EOL
   {
     "name": "$PKG_NAME",
     "version": "0.0.1",
     "private": true,
     "scripts": {
       "build": "your-build-command",
       "dev": "your-dev-command",
       "test": "vitest run",
       "lint": "eslint . --ext .ts --config ../../eslint.config.js"
     }
   }
   EOL
   
     # Add dependencies
     pnpm add --filter "$PKG_NAME" your-dependencies
     
     # Create source files
     # ... your implementation ...
     
     echo "✅ New App Type created successfully"
   }
   ```

3. **Update the main script**:
   ```bash
   # In monokit script, add to the interactive menu:
   echo "5) New App Type"
   
   # Add to the case statement:
   case "$APP_TYPE" in
     # ... existing cases ...
     5)
       source "$SCRIPT_DIR/monokit-files/new-app-type.sh"
       create_new_app_type "$DEST" "$PKG_NAME" "$TS_NAME"
       ;;
   esac
   ```

4. **Update documentation**:
   - Add the new app type to README.md
   - Update this CONTRIBUTING.md file
   - Add examples and usage instructions

### App Type Requirements

Each app type should include:

- ✅ **package.json** with proper scripts
- ✅ **TypeScript configuration** (tsconfig.json)
- ✅ **Test setup** (vitest.config.ts)
- ✅ **Example source code** with utilities
- ✅ **Test files** with comprehensive coverage
- ✅ **Proper error handling** and success messages
- ✅ **Documentation** in the generated README

## 🧪 Testing Your Changes

### Manual Testing

1. **Test the installation script**:
   ```bash
   # Test fresh installation
   ./install.sh
   
   # Test upgrade
   ./install.sh --upgrade
   ```

2. **Test the main script**:
   ```bash
   # Test all commands
   ./monokit init test-repo
   cd test-repo
   ../monokit add lib test-lib
   ../monokit add app test-app
   ../monokit switch test-lib lib local
   ../monokit switch test-lib lib remote
   ```

3. **Test generated projects**:
   ```bash
   # Build and test generated packages
   pnpm build
   pnpm test
   pnpm lint
   pnpm type-check
   ```

### Automated Testing

Create test scripts for common scenarios:

```bash
#!/bin/bash
# test-scenarios.sh

set -e

echo "🧪 Running test scenarios..."

# Test 1: Fresh monorepo creation
./monokit init test-scenario-1
cd test-scenario-1
../monokit add lib utils
../monokit add app cli-tool
pnpm build
pnpm test
cd ..
rm -rf test-scenario-1

echo "✅ All tests passed!"
```

## 📤 Submitting Changes

### Before Submitting

1. **Test your changes** thoroughly
2. **Format your code** with Prettier
3. **Check for errors** with ShellCheck (if available)
4. **Update documentation** as needed

### Pull Request Process

1. **Create a feature branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes** and commit them:
   ```bash
   git add .
   git commit -m "feat: add new app type for Svelte"
   ```

3. **Push to your fork**:
   ```bash
   git push origin feature/your-feature-name
   ```

4. **Create a Pull Request** on GitHub with:
   - Clear title describing the change
   - Detailed description of what was changed
   - Steps to test the changes
   - Screenshots if applicable

### Commit Message Format

Use conventional commit format:

```
type(scope): description

feat(app): add Svelte app template
fix(install): resolve permission issues on macOS
docs(readme): update installation instructions
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

### Pull Request Template

```markdown
## ✨ Summary

Brief description of changes

## 🔧 Changes Made

- [ ] Added new feature X
- [ ] Fixed bug Y
- [ ] Updated documentation

## 🧪 Testing

- [ ] Manual testing completed
- [ ] All existing functionality works
- [ ] New features tested thoroughly

## 📝 Documentation

- [ ] README updated
- [ ] Code comments added
- [ ] Examples provided

## 🔍 Review Checklist

- [ ] Code follows project style
- [ ] Error handling implemented
- [ ] Success messages added
- [ ] No breaking changes
```

## 🚀 Release Process

### For Maintainers

1. **Update version** in package.json
2. **Create a release branch**:
   ```bash
   git checkout -b release/v1.1.0
   ```

3. **Update changelog** and documentation
4. **Test the release**:
   ```bash
   # Test installation
   ./install.sh
   
   # Test all features
   ./test-scenarios.sh
   ```

5. **Create a release** on GitHub:
   - Tag: `v1.1.0`
   - Title: `Release v1.1.0`
   - Description: Include changelog

6. **Publish to npm** (if applicable):
   ```bash
   npm publish
   ```

### Release Checklist

- [ ] All tests pass
- [ ] Documentation updated
- [ ] Changelog updated
- [ ] Version bumped
- [ ] Release notes written
- [ ] GitHub release created
- [ ] NPM package published (if applicable)

## 🤝 Getting Help

### Questions and Support

- **GitHub Issues**: For bug reports and feature requests
- **GitHub Discussions**: For questions and general discussion
- **Documentation**: Check README.md first

### Communication Guidelines

- Be respectful and inclusive
- Provide clear, reproducible examples
- Include system information when reporting bugs
- Use issue templates when available

## 📚 Additional Resources

- [Bash Scripting Guide](https://www.gnu.org/software/bash/manual/)
- [PNPM Workspaces](https://pnpm.io/workspaces)
- [TypeScript Documentation](https://www.typescriptlang.org/docs/)
- [Conventional Commits](https://www.conventionalcommits.org/)

---

Thank you for contributing to Monokit! 🎉 