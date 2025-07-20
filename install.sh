#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
SCRIPT_NAME="monokit"
INSTALL_DIR="/usr/local/bin"
BACKUP_DIR="$HOME/.monokit-backup"
REPO_URL="https://raw.githubusercontent.com/your-username/monokit/main"
SCRIPT_URL="$REPO_URL/monokit"

# Helper functions
error() {
    echo -e "${RED}❌ Error: $1${NC}" >&2
    exit 1
}

success() {
    echo -e "${GREEN}✅ $1${NC}"
}

info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

# Check if running as root for system-wide installation
check_permissions() {
    if [[ "$EUID" -eq 0 ]]; then
        error "Please don't run this script as root. It will use sudo when needed."
    fi
}

# Check system requirements
check_requirements() {
    info "Checking system requirements..."
    
    # Check if curl is available
    if ! command -v curl &> /dev/null; then
        error "curl is required but not installed. Please install curl first."
    fi
    
    # Check if jq is available (required by monokit)
    if ! command -v jq &> /dev/null; then
        warning "jq is not installed. Installing jq..."
        if command -v apt-get &> /dev/null; then
            sudo apt-get update && sudo apt-get install -y jq
        elif command -v yum &> /dev/null; then
            sudo yum install -y jq
        elif command -v brew &> /dev/null; then
            brew install jq
        else
            error "Could not install jq automatically. Please install jq manually."
        fi
    fi
    
    success "System requirements met"
}

# Download the script
download_script() {
    info "Downloading monokit script..."
    
    # Create temporary file
    TEMP_FILE=$(mktemp)
    
    # Download with error handling
    if ! curl -fsSL "$SCRIPT_URL" -o "$TEMP_FILE"; then
        rm -f "$TEMP_FILE"
        error "Failed to download monokit script. Check your internet connection."
    fi
    
    # Verify the script is not empty
    if [[ ! -s "$TEMP_FILE" ]]; then
        rm -f "$TEMP_FILE"
        error "Downloaded file is empty. Please check the repository URL."
    fi
    
    echo "$TEMP_FILE"
}

# Backup existing installation
backup_existing() {
    if [[ -f "$INSTALL_DIR/$SCRIPT_NAME" ]]; then
        info "Backing up existing installation..."
        mkdir -p "$BACKUP_DIR"
        cp "$INSTALL_DIR/$SCRIPT_NAME" "$BACKUP_DIR/${SCRIPT_NAME}.backup.$(date +%Y%m%d_%H%M%S)"
        success "Backup created in $BACKUP_DIR"
    fi
}

# Install the script
install_script() {
    local temp_file="$1"
    
    info "Installing monokit to $INSTALL_DIR..."
    
    # Make the script executable
    chmod +x "$temp_file"
    
    # Move to installation directory
    if ! sudo mv "$temp_file" "$INSTALL_DIR/$SCRIPT_NAME"; then
        rm -f "$temp_file"
        error "Failed to install monokit. Check permissions."
    fi
    
    success "monokit installed successfully to $INSTALL_DIR/$SCRIPT_NAME"
}

# Verify installation
verify_installation() {
    info "Verifying installation..."
    
    if ! command -v "$SCRIPT_NAME" &> /dev/null; then
        error "Installation verification failed. monokit not found in PATH."
    fi
    
    # Test the script
    if ! "$SCRIPT_NAME" &> /dev/null; then
        error "Installation verification failed. monokit script is not working properly."
    fi
    
    success "Installation verified successfully"
}

# Show usage information
show_usage() {
    echo
    echo -e "${GREEN}🎉 monokit has been installed successfully!${NC}"
    echo
    echo "Usage examples:"
    echo "  $SCRIPT_NAME init my-project     # Create a new monorepo"
    echo "  $SCRIPT_NAME add lib utils       # Add a library"
    echo "  $SCRIPT_NAME add app web-app     # Add an application"
    echo
    echo "For more information, run:"
    echo "  $SCRIPT_NAME --help"
    echo
    echo "To uninstall, run:"
    echo "  sudo rm $INSTALL_DIR/$SCRIPT_NAME"
    echo
}

# Upgrade existing installation
upgrade() {
    info "Upgrading existing monokit installation..."
    
    # Backup existing
    backup_existing
    
    # Download and install
    local temp_file=$(download_script)
    install_script "$temp_file"
    verify_installation
    
    success "monokit upgraded successfully"
    show_usage
}

# Fresh installation
install() {
    info "Installing monokit..."
    
    # Check requirements
    check_requirements
    
    # Backup if exists
    backup_existing
    
    # Download and install
    local temp_file=$(download_script)
    install_script "$temp_file"
    verify_installation
    
    success "monokit installed successfully"
    show_usage
}

# Main function
main() {
    echo -e "${BLUE}🚀 monokit Installer${NC}"
    echo "========================"
    echo
    
    # Check permissions
    check_permissions
    
    # Check if already installed
    if command -v "$SCRIPT_NAME" &> /dev/null; then
        echo -e "${YELLOW}monokit is already installed.${NC}"
        read -p "Do you want to upgrade? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            upgrade
        else
            info "Installation cancelled."
            exit 0
        fi
    else
        install
    fi
}

# Handle command line arguments
case "${1:-}" in
    --help|-h)
        echo "Usage: $0 [--help|--upgrade]"
        echo
        echo "Options:"
        echo "  --help, -h    Show this help message"
        echo "  --upgrade     Force upgrade existing installation"
        echo
        echo "If no arguments are provided, the script will:"
        echo "  - Install monokit if not present"
        echo "  - Offer to upgrade if already installed"
        exit 0
        ;;
    --upgrade)
        if command -v "$SCRIPT_NAME" &> /dev/null; then
            upgrade
        else
            error "monokit is not installed. Use --help for more information."
        fi
        ;;
    "")
        main
        ;;
    *)
        error "Unknown option: $1. Use --help for usage information."
        ;;
esac 