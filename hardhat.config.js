require('dotenv').config();
require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");
require("@nomiclabs/hardhat-ethers");
const { API_URL, POLYGON_API_URL, ROPSTEN_API_URL , RINKEBY_API_URL , ETHERSCAN_API, PRIVATE_KEY } = process.env;

task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

module.exports = {
  solidity: {
    version: "0.8.4",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  defaultNetwork: "ropsten",
   networks: {
      hardhat: {},

      ropsten: {
         url: ROPSTEN_API_URL,
         accounts: [`0x${PRIVATE_KEY}`]
      } ,

      rinkeby: {
        url: RINKEBY_API_URL,
        accounts: [`0x${PRIVATE_KEY}`]
     } ,

     mainnet: {
       url: API_URL,
       accounts: [`0x${PRIVATE_KEY}`]
    },

    polygon: {
      url: POLYGON_API_URL,
      accounts: [`0x${PRIVATE_KEY}`]
   }

   
   },
  etherscan: {
    apiKey: ETHERSCAN_API
  }
};
