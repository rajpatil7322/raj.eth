const { expect } = require('chai');
const { ethers } = require('hardhat');

describe("Token contract", function() {
    it("Deployment should assign the total supply of tokens to the owner", async function() {
        const [owner] = await ethers.getSigners();

        const Token = await ethers.getContractFactory("Token");

        const hardhatToken = await Token.deploy();

        const ownerBalance = await hardhatToken.balanceOf(owner.address);
        expect(await hardhatToken.totalSupply()).to.equal(ownerBalance);
    });

    it("Should transfer tokens between accounts", async function() {
        const [owner, addr1, addr2] = await ethers.getSigners();

        const Token = await ethers.getContractFactory("Token");

        const hardhatToken = await Token.deploy();

        // Transfer 50 tokens from owner to addr1
        await hardhatToken.transfer(addr1.address, 5);
        expect(await hardhatToken.balanceOf(addr1.address)).to.equal(5);

        expect(await hardhatToken.totalSupply()).to.equal(8);
    });
});