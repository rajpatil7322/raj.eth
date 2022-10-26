const { ethers } = require("hardhat");

async function main() {
    const WhitelistContract = await ethers.getContractFactory("Whitelist");

    const deployedWhitelist = await WhitelistContract.deploy(10);

    await deployedWhitelist.deployed();

    console.log("Whitelist Contract Address:", deployedWhitelist.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });