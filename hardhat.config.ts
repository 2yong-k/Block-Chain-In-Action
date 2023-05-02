/** @type import('hardhat/config').HardhatUserConfig */
require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-etherscan"); // for verify
require("dotenv").config();

module.exports = {
  solidity: "0.8.17",
  etherscan: {
    apiKey: `${process.env.ETHERSCAN_API}`,
  },
  networks: {
    ethereum: {
      url: `${process.env.ETHEREUM_URL}`,
      accounts: [process.env.PVK],
    },
    goerli: {
      url: `${process.env.GOERLI_URL}`,
      accounts: [process.env.PVK],
    },
    polygon: {
      url: `${process.env.POLYGON_URL}`,
      accounts: [process.env.PVK],
    },
    mumbai: {
      url: `${process.env.MUMBAI_URL}`,
      accounts: [process.env.PVK],
    },
  },
};
