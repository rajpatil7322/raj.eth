require("@nomiclabs/hardhat-waffle");
require("dotenv").config({ path: ".env" });

const ALCHEMY_URL = process.env.ALCHEMY_URL;
const PRIVATE_KEY = process.env.PRIVATE_KEY;

module.exports = {
    solidity: "0.8.17",
    networks: {
        goerli: {
            url: ALCHEMY_URL,
            accounts: [PRIVATE_KEY],
        },
    },
};