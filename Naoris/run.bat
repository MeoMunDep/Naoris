@echo off
title Naoris Bot by @MeoMunDep
color 0A

cd ..
if exist node_modules (
    echo Found node_modules in parent directory
    cd %~dp0
) else (
    cd %~dp0
    echo node_modules not found in parent directory
)


cls
echo Checking node_modules location...
if exist "..\node_modules" (
    cd ..
    echo Installing/Updating dependencies in parent directory...
    CALL npm install user-agents axios colors p-limit https-proxy-agent socks-proxy-agent crypto-js canvas gl
    cd %~dp0
) else (
    echo Installing dependencies in current directory...
    CALL npm install user-agents axios colors p-limit https-proxy-agent socks-proxy-agent crypto-js canvas gl
)
echo.
echo Dependencies installation completed!
echo.


cls
echo Checking configuration files...

if not exist configs.json (
    echo {> configs.json
    echo   "timeZone": "en-US",>> configs.json
    echo   "rotateProxy": false,>> configs.json
    echo   "skipInvalidProxy": false,>> configs.json
    echo   "proxyRotationInterval": 2,>> configs.json
    echo   "delayEachAccount": [5, 8],>> configs.json
    echo   "timeToRestartAllAccounts": 300,>> configs.json
    echo   "howManyAccountsRunInOneTime": 100,>> configs.json
    echo   "referralCode":  ["nyef7qjEMvqYIOML", "1yFdxBDRS7UsKsd3"]>> configs.json
    echo }>> configs.json
    echo Created configs.json
)

if not exist datas.txt (
    type nul > datas.txt
    echo Created datas.txt
)
if not exist wallets.json (
    type nul > wallets.json
    echo Created wallets.json
)
if not exist proxies.txt (
    type nul > proxies.txt
    echo Created proxies.txt
)

echo.
echo Configuration files have been created/checked.
echo.


cls
echo Starting the bot...
if exist "..\node_modules" (
    echo Using node_modules from parent directory
) else (
    echo Using node_modules from current directory
)
node referrals_and_generate_devicehash_meomundep.js

pause
exit
