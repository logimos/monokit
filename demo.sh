#!/bin/bash

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Monokit Demo${NC}"
echo "=================="
echo

# Create demo directory
DEMO_DIR="monokit-demo"
if [ -d "$DEMO_DIR" ]; then
    echo -e "${YELLOW}Removing existing demo directory...${NC}"
    rm -rf "$DEMO_DIR"
fi

echo -e "${GREEN}Creating demo monorepo...${NC}"
./monokit init "$DEMO_DIR"

cd "$DEMO_DIR"

echo -e "${GREEN}Adding a utility library...${NC}"
../monokit add lib utils

echo -e "${GREEN}Adding a CLI application...${NC}"
../monokit add app cli-tool

echo -e "${GREEN}Adding a web application...${NC}"
../monokit add app web-app

echo -e "${GREEN}Building all packages...${NC}"
pnpm build

echo -e "${GREEN}Running tests...${NC}"
pnpm test

echo -e "${GREEN}Checking types...${NC}"
pnpm type-check

echo
echo -e "${BLUE}📁 Demo Project Structure:${NC}"
tree -I 'node_modules|dist|.git' -a

echo
echo -e "${BLUE}📋 Available Commands:${NC}"
echo "Root level:"
echo "  pnpm build          # Build all packages"
echo "  pnpm dev            # Run dev mode for all packages"
echo "  pnpm test           # Run tests across the monorepo"
echo "  pnpm lint           # Lint all packages"
echo
echo "Package specific:"
echo "  pnpm @myorg/utils:build      # Build utils library"
echo "  pnpm @myorg/cli-tool:dev     # Run CLI tool in dev mode"
echo "  pnpm @myorg/web-app:dev      # Run web app in dev mode"

echo
echo -e "${GREEN}✅ Demo completed successfully!${NC}"
echo "You can now explore the generated monorepo in the '$DEMO_DIR' directory."
echo
echo "To clean up, run: rm -rf $DEMO_DIR" 