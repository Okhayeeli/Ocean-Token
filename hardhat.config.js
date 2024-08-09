require("@nomicfoundation/hardhat-toolbox");
require("hardhat-secure-accounts");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.24",
  networks: {
    sepolia: {
      url: process.env.ALCHEMY_API_KEY,
      accounts: [process.env.PRIVATE_KEY],
      timeout: 60000 // 1 minute timeout
    }
  }
};
