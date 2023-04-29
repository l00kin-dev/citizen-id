require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");
require('dotenv').config()
const { GOERLI_INFURA_URI, SEPOLIA_INFURA_URI, MAINNET_INFURA_URI, ETHERSCAN_API_KEY, PRIVATE_KEY } = process.env;

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: {
    version: "0.8.7",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    },
  },
  networks: {
    hardhat: {
      chainId: 1337,
      accounts: {
        mnemonic: "test test test test test test test test test test test junk",
        path: "m/44'/60'/0'/0",
        initialIndex: 0,
        count: 150,
        passphrase: "",
      }
    },
    goerli: {
      url: GOERLI_INFURA_URI,
      accounts: [PRIVATE_KEY]
    },
    sepolia: {
      url: SEPOLIA_INFURA_URI,
      accounts: [PRIVATE_KEY]
    },
    mainnet: {
      url: MAINNET_INFURA_URI,
      accounts: [PRIVATE_KEY]
    },
  },
  etherscan: {
    apiKey: {
      goerli: ETHERSCAN_API_KEY,
      mainnet: ETHERSCAN_API_KEY,
    }
  }
};
