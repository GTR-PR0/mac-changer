#!/bin/bash

# =============================================
# MAC Changer Installer
# By: SharpMalware
# =============================================

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Check if running as root
if [ "$(id -u)" != "0" ]; then
    echo -e "${RED}Error: This script must be run as root!${NC}"
    echo -e "Try: ${YELLOW}sudo ./install.sh${NC}"
    exit 1
fi

# Installation steps
echo -e "${YELLOW}Starting MAC Changer installation...${NC}"

# Step 1: Download the script
echo -e "${YELLOW}Downloading the script...${NC}"
wget https://raw.githubusercontent.com/GTR-PR0/mac-changer/main/mac-changer1 -O /tmp/mac-changer1 || {
    echo -e "${RED}Error: Failed to download the script!${NC}"
    exit 1
}

# Step 2: Install to /usr/local/bin
echo -e "${YELLOW}Installing to /usr/local/bin...${NC}"
mv /tmp/mac-changer1 /usr/local/bin/mac-changer1 || {
    echo -e "${RED}Error: Failed to move the script!${NC}"
    exit 1
}

# Step 3: Make executable
chmod +x /usr/local/bin/mac-changer1 || {
    echo -e "${RED}Error: Failed to make the script executable!${NC}"
    exit 1
}

# Step 4: Create symlink
echo -e "${YELLOW}Creating symlink...${NC}"
ln -sf /usr/local/bin/mac-changer1 /usr/bin/mac-changer1 || {
    echo -e "${RED}Error: Failed to create symlink!${NC}"
    exit 1
}

# Step 5: Check dependencies
echo -e "${YELLOW}Checking dependencies...${NC}"
if ! command -v ip &> /dev/null || ! command -v openssl &> /dev/null; then
    echo -e "${YELLOW}Installing required packages...${NC}"
    apt-get update && apt-get install -y iproute2 openssl || {
        echo -e "${RED}Error: Failed to install dependencies!${NC}"
        exit 1
    }
fi

# Installation complete
echo -e "${GREEN}Installation completed successfully!${NC}"
echo -e "You can now run the tool with: ${YELLOW}sudo mac-changer1${NC}"
echo -e "Or simply: ${YELLOW}mac-changer1${NC} (with sudo privileges)"
exit 0 
