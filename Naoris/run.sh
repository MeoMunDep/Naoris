#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' 

print_green() {
    echo -e "${GREEN}$1${NC}"
}

print_yellow() {
    echo -e "${YELLOW}$1${NC}"
}

print_red() {
    echo -e "${RED}$1${NC}"
}

chmod +x "$0"

if [ -d "../node_modules" ]; then
    print_green "Found node_modules in parent directory"
    MODULES_DIR=".."
else
    print_green "Using current directory for node_modules"
    MODULES_DIR="."
fi

create_default_configs() {
    cat > configs.json << EOL
{
  "timeZone": "en-US",
  "rotateProxy": false,
  "skipInvalidProxy": false,
  "proxyRotationInterval": 2,
  "delayEachAccount": [1, 1],
  "timeToRestartAllAccounts": 300,
  "howManyAccountsRunInOneTime": 1,
  "referralCodes": ["nyef7qjEMvqYIOML", "1yFdxBDRS7UsKsd3"]
}
EOL
}

check_configs() {
    if ! node -e "const cfg=require('./configs.json');if(typeof cfg.howManyAccountsRunInOneTime !== 'number' || cfg.howManyAccountsRunInOneTime < 1) throw new Error('Invalid config');" 2>/dev/null; then
        print_red "Invalid configuration detected. Resetting to default values..."
        create_default_configs
        print_green "Configuration reset completed."
    fi
}

clear
echo "============================================================"
echo "    Naoris BOT SETUP AND RUN SCRIPT by @MeoMunDep"
echo "============================================================"
echo
echo "Current directory: $(pwd)"
echo "Node modules directory: $MODULES_DIR/node_modules"
echo


print_yellow "Installing/Updating Node.js dependencies..."
cd "$MODULES_DIR"
npm install user-agents axios colors p-limit https-proxy-agent socks-proxy-agent crypto-js ws canvas gl
cd - > /dev/null
print_green "Dependencies installation completed!"
echo


print_yellow "Setting up configuration files..."

if [ ! -f configs.json ]; then
    create_default_configs
    print_green "Created configs.json with default values"
fi

check_configs

for file in datas.txt wallets.json proxies.txt; do
    if [ ! -f "$file" ]; then
        touch "$file"
        print_green "Created $file"
    fi
done

print_green "\nConfiguration files have been created/checked."
print_yellow "Please edit the files with your data before running the bot."
echo


print_yellow "Checking configuration before starting..."
check_configs

print_green "Starting the bot..."
if [ -d "../node_modules" ]; then
    print_green "Using node_modules from parent directory"
else
    print_green "Using node_modules from current directory"
fi

node referrals_and_generate_devicehash_meomundep.js
