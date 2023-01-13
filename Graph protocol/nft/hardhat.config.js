require('@nomiclabs/hardhat-waffle');
require('hardhat-abi-exporter');
require("dotenv").config({ path: ".env" });


const AlCHEMY_API_KEY = process.env.AlCHEMY_API_KEY;
const PRIVATE_KEY = process.env.PRIVATE_KEY;

module.exports = {
    solidity: '0.8.17',
    abiExporter: {
        path: './abi/',
        clear: true,
    },
    networks: {
        goerli: {
            url: AlCHEMY_API_KEY,
            accounts: [PRIVATE_KEY],
        },
    },
};