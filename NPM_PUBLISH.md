# Publishing Monokit to NPM 🚀

This guide explains how to publish Monokit as an npm CLI application.

## 📦 NPM Package Structure

The `package.json` is already configured for npm distribution with:

```json
{
  "name": "monokit",
  "bin": {
    "monokit": "./monokit"
  },
  "preferGlobal": true,
  "files": [
    "monokit",
    "monokit-files/",
    "install.sh",
    "README.md",
    "LICENSE"
  ]
}
```

## 🚀 Publishing Steps

### 1. Prepare for Publishing

```bash
# Update version in package.json
npm version patch  # or minor/major

# Update author information
# Edit package.json with your details:
# - "name": "your-npm-username"
# - "author": { "name": "Your Name", "email": "your@email.com" }
# - "repository": { "url": "https://github.com/your-username/monokit.git" }
```

### 2. Test Locally

```bash
# Test the package locally
npm pack
npm install -g ./monokit-1.0.0.tgz

# Test the installation
monokit --help
monokit init test-project
cd test-project
monokit add lib utils
```

### 3. Publish to NPM

```bash
# Login to npm (if not already logged in)
npm login

# Publish the package
npm publish

# Or publish with specific tag
npm publish --tag beta
```

## 📥 Installation Methods

Once published, users can install Monokit in several ways:

### Global Installation (Recommended)
```bash
npm install -g monokit
```

### Using npx (No Installation)
```bash
npx monokit init my-project
npx monokit add lib utils
```

### Using Yarn
```bash
yarn global add monokit
```

### Using PNPM
```bash
pnpm add -g monokit
```

## 🎯 Usage After NPM Installation

After installing via npm, users can use Monokit exactly as documented:

```bash
# Initialize a new monorepo
monokit init my-awesome-project
cd my-awesome-project

# Add packages
monokit add lib utils
monokit add app web-app

# Switch dependencies
monokit switch utils lib local
monokit switch utils lib remote
```

## 🔧 Package Configuration Details

### Bin Configuration
```json
"bin": {
  "monokit": "./monokit"
}
```
This makes the `monokit` script executable globally when installed.

### PreferGlobal
```json
"preferGlobal": true
```
This warns users if they try to install locally instead of globally.

### Files Array
```json
"files": [
  "monokit",
  "monokit-files/",
  "install.sh",
  "README.md",
  "LICENSE"
]
```
This ensures only necessary files are included in the npm package.

### Scripts
```json
"scripts": {
  "prepublishOnly": "chmod +x monokit && chmod +x monokit-files/*.sh",
  "postinstall": "chmod +x monokit"
}
```
- `prepublishOnly`: Makes scripts executable before publishing
- `postinstall`: Makes the main script executable after installation

## 🌟 Benefits of NPM Distribution

### For Users
1. **Easy Installation**: `npm install -g monokit`
2. **Version Management**: `npm update -g monokit`
3. **Global Availability**: Works from any directory
4. **Automatic Updates**: Can be updated via npm

### For Developers
1. **Wide Distribution**: Available to millions of npm users
2. **Version Control**: Semantic versioning with npm
3. **Analytics**: npm provides download statistics
4. **Discovery**: Users can find it via `npm search monokit`

## 📊 NPM Package Features

### Automatic Script Execution
When users install the package globally, npm automatically:
1. Creates a symlink to the `monokit` script
2. Makes it available in their PATH
3. Allows execution from any directory

### Cross-Platform Compatibility
The package works on:
- **Linux**: Full functionality
- **macOS**: Full functionality  
- **Windows**: Via WSL or Git Bash

### Dependencies
The package has minimal dependencies:
- **Runtime**: None (pure bash scripts)
- **Dev**: Only Prettier for formatting

## 🔄 Publishing Updates

### Version Management
```bash
# Patch release (bug fixes)
npm version patch

# Minor release (new features)
npm version minor

# Major release (breaking changes)
npm version major
```

### Publishing Process
```bash
# 1. Update version
npm version patch

# 2. Test locally
npm pack
npm install -g ./monokit-*.tgz

# 3. Publish
npm publish

# 4. Verify
npm view monokit version
```

## 🎯 Marketing on NPM

### Package Description
The description clearly explains the value proposition:
> "A powerful command-line tool for creating and managing modern TypeScript monorepos with best practices built-in"

### Keywords for Discovery
The package includes relevant keywords for npm search:
- `monorepo`, `typescript`, `pnpm`, `cli`
- `scaffolding`, `boilerplate`, `generator`
- `react`, `nextjs`, `express`, `vite`

### README Integration
The README.md is included in the package, so users see it on npmjs.com.

## 🚨 Important Notes

### File Permissions
The `prepublishOnly` and `postinstall` scripts ensure the bash scripts are executable:
```bash
chmod +x monokit
chmod +x monokit-files/*.sh
```

### Dependencies
The package has no runtime dependencies, making it lightweight and reliable.

### Cross-Platform
The scripts use bash, which works on Unix-like systems. For Windows users, they'll need WSL or Git Bash.

## 🎉 Success Metrics

After publishing, you can track success via:
- **Downloads**: `npm view monokit downloads`
- **Stars**: GitHub repository stars
- **Issues**: User feedback and bug reports
- **Forks**: Community contributions

---

**Ready to publish?** Just update the author information in `package.json` and run `npm publish`! 🚀 