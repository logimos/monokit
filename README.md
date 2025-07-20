# Monokit 🚀

A powerful command-line tool for creating and managing modern TypeScript monorepos with best practices built-in.

## ✨ Features

- **Zero-config setup** - Initialize a complete monorepo with one command
- **Multiple app types** - CLI, Express API, Vite React, Next.js
- **Library management** - Create reusable packages with proper TypeScript setup
- **Modern tooling** - PNPM workspaces, Vitest, ESLint, Prettier, Changesets
- **CI/CD ready** - GitHub Actions workflows included
- **Dependency switching** - Toggle between local workspace and remote dependencies
- **TypeScript first** - Full TypeScript support with proper configurations

## 🏗️ Architecture

```
my-monorepo/
├── apps/           # Deployable applications
│   ├── cli-app/    # Command-line tools
│   ├── api-app/    # Express.js APIs
│   ├── web-app/    # Vite + React apps
│   └── next-app/   # Next.js applications
├── packages/       # Reusable libraries
│   ├── core/       # Shared utilities
│   ├── ui/         # UI components
│   └── config/     # Configuration packages
├── .github/        # GitHub Actions & templates
└── package.json    # Root workspace config
```

## 🚀 Quick Start

### Installation

#### Option 1: NPM (Recommended)
```bash
# Install globally via npm
npm install -g monokit

# Or use npx without installation
npx monokit init my-project
```

#### Option 2: Direct Download
```bash
# Download the monokit script
curl -fsSL https://raw.githubusercontent.com/your-username/monokit/main/monokit -o monokit

# Make it executable
chmod +x monokit

# Move to a directory in your PATH (optional)
sudo mv monokit /usr/local/bin/
```

#### Option 3: Clone and Install
```bash
# Clone the repository
git clone https://github.com/your-username/monokit.git
cd monokit

# Make executable
chmod +x monokit

# Create a symlink (optional)
sudo ln -s $(pwd)/monokit /usr/local/bin/monokit
```

### Create Your First Monorepo

```bash
# Initialize a new monorepo
monokit init my-awesome-project

# Navigate to the project
cd my-awesome-project

# Add a library
monokit add lib utils

# Add a CLI application
monokit add app cli-tool

# Add a web application
monokit add app web-app
```

## 📖 Usage Guide

### Initializing a Monorepo

```bash
monokit init <project-name>
```

This creates a complete monorepo with:
- PNPM workspace configuration
- TypeScript base configuration
- ESLint and Prettier setup
- Vitest testing framework
- Changesets for versioning
- GitHub Actions CI/CD
- Comprehensive README

### Adding Libraries

```bash
monokit add lib <library-name>
```

Creates a reusable library with:
- TypeScript configuration
- Build setup with tsup
- Test configuration with Vitest
- Proper package.json structure
- Example source code and tests

### Adding Applications

```bash
monokit add app <app-name>
```

Interactive app creation with 4 options:
1. **CLI Application** - Command-line tools with chalk for styling
2. **Express API** - REST API with Express.js
3. **Vite React** - Modern React app with Vite
4. **Next.js** - Full-stack React framework

### Managing Dependencies

Switch between local workspace and remote dependencies:

```bash
# Switch to local workspace dependencies
monokit switch <package-name> <app|lib> local

# Switch to remote dependencies
monokit switch <package-name> <app|lib> remote
```

## 🛠️ Development Workflow

### Root Level Commands

| Command | Description |
|---------|-------------|
| `pnpm build` | Build all packages |
| `pnpm dev` | Run dev mode for all packages |
| `pnpm test` | Run tests across the monorepo |
| `pnpm test:ui` | Run tests with Vitest UI |
| `pnpm lint` | Lint all packages |
| `pnpm format` | Format all packages |
| `pnpm clean` | Clean all dist folders |
| `pnpm type-check` | Type check all packages |

### Package-Specific Commands

For a package named `@myorg/my-package`:

| Command | Description |
|---------|-------------|
| `pnpm @myorg/my-package:build` | Build specific package |
| `pnpm @myorg/my-package:dev` | Run dev mode for specific package |
| `pnpm @myorg/my-package:test` | Test specific package |
| `pnpm @myorg/my-package:lint` | Lint specific package |
| `pnpm @myorg/my-package:format` | Format specific package |
| `pnpm @myorg/my-package:clean` | Clean specific package |
| `pnpm @myorg/my-package:type-check` | Type check specific package |

## 📦 App Types

### CLI Applications
- Built with TypeScript and chalk for styling
- Includes example utilities and tests
- Ready for command-line argument parsing
- Proper error handling setup

### Express API Applications
- REST API with Express.js
- JSON middleware configured
- Health check endpoint
- Example calculation endpoint
- Comprehensive testing setup

### Vite React Applications
- Modern React with TypeScript
- Vite for fast development
- Testing with React Testing Library
- Hot module replacement
- Build optimization

### Next.js Applications
- Latest Next.js with App Router
- Tailwind CSS v4 integration
- Geist fonts included
- Server-side rendering ready
- API routes support

## 🔄 Versioning and Releases

Monokit uses [Changesets](https://github.com/changesets/changesets) for versioning:

```bash
# Create a changeset
pnpm changeset

# Version packages
pnpm version-packages

# Create and push a tag
git tag v1.0.0
git push origin v1.0.0
```

GitHub Actions will automatically publish changed packages to npm.

## 🤝 Contributing

### Prerequisites
- Node.js 18+ 
- PNPM 8+
- Git

### Development Setup

1. **Fork and clone** the repository
2. **Install dependencies**: `pnpm install`
3. **Make changes** to the scripts in `monokit-files/`
4. **Test your changes** by running the monokit script locally
5. **Submit a pull request** with a clear description

### Adding New App Types

To add a new app type (e.g., Svelte, Vue):

1. Create a new script file: `monokit-files/svelte-app.sh`
2. Implement the `create_svelte_app()` function
3. Add the option to the interactive menu in `monokit`
4. Update this README with the new app type

### Adding New Features

1. **Modify the main script** (`monokit`) to add new commands
2. **Create helper scripts** in `monokit-files/` for complex operations
3. **Update documentation** in this README
4. **Add tests** if applicable

### Code Style

- Use consistent bash scripting patterns
- Add proper error handling
- Include helpful success/error messages
- Follow the existing naming conventions

## 🔧 Configuration

### Customizing Organization Name

Edit the `ORG_NAME` variable in the `monokit` script:

```bash
# Change from @myorg to your organization
ORG_NAME="@yourorg"
```

### Customizing Dependencies

Modify the dependency installation in each app type script:

```bash
# In monokit-files/cli-app.sh
pnpm add --filter "$PKG_NAME" your-preferred-cli-lib
```

## 🚨 Troubleshooting

### Common Issues

**"Not in a workspace" error**
- Ensure you're running commands from within a monorepo directory
- Check that `pnpm-workspace.yaml` exists

**Permission denied**
- Make sure the monokit script is executable: `chmod +x monokit`

**Package not found**
- Run `pnpm install` to install dependencies
- Check that the package name is correct

**Build failures**
- Run `pnpm clean` to clear build artifacts
- Check TypeScript errors with `pnpm type-check`

### Getting Help

1. Check the [Issues](https://github.com/your-username/monokit/issues) page
2. Create a new issue with:
   - Your operating system
   - Node.js and PNPM versions
   - The exact command that failed
   - Error messages and stack traces

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [PNPM](https://pnpm.io/) for fast, disk space efficient package management
- [Vitest](https://vitest.dev/) for blazing fast unit testing
- [Changesets](https://github.com/changesets/changesets) for versioning and releases
- [Tsup](https://github.com/egoist/tsup) for zero-config TypeScript bundling

---

**Made with ❤️ for the TypeScript community** 