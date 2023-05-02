# Block Chain In Action Study

## Hardhat
1. npm init
2. npm install --save-dev hardhat
3. npx hardhat
4. npm install --save-dev PACKAGES / npm install --save PACKAGES
5. write code in hardhat.config.js
6. mkdir contracts, scripts, test folder
7. make sol file in contracts folder
8. npx hardhat compile
9. make ts file in scripts folder
10. npx hardhat help: command verification
11. local testnet for deploy
    - open up a new terminal
    - npx hardhat node -> make local testnet
    - npx hardhat run --network localhost scripts/DEPLOY_FILE.ts
12. testnet for deploy
    - npx hardhat run --network NETWORK_NAME scripts/DEPLOY_FILE.ts
14. make ts file in test folder
15. local testnet for test
    - npx hardhat test --network localhost test/TEST_FILE.ts
16. testnet for test
    - npx hardhat test --network NETWORK_NAME test/TEST_FILE.ts
17. do verify
    - hardhat.config.ts -> @nomiclabs/hardhat-etherscan
    - config -> etherscan: {apiKey: process.env.ETHERSCAN_API_KEY}
    - npx hardhat verify --network NETWORK_NAME "CONTRACT_ADDRESS"
18. local testnet for function -> terminal or .ts file in root folder(node FUNC_FILE.ts)
    - npx hardhat console
    - ethers.provider
    - await thers.getSigner()
19. testnet for function -> terminal or .ts file in root folder(node FUNC_FILE.ts)
    - npx hardhat --network NETWORK_NAME console
    - set provider + set signer
    - set contract abi + set contract address
    - set contract