//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.17;

contract Whitelist {
    uint8 public maxWhitelistAddress;

    mapping(address => bool) public whitelisted;

    uint8 public numAddressesWhitelisted;

    constructor(uint8 _maxWhitelistAddress ){
        maxWhitelistAddress=_maxWhitelistAddress;
    }

    function addAddressToWhitelist() public {
       
        require(!whitelisted[msg.sender], "Sender has already been whitelisted");
     
        require(numAddressesWhitelisted < maxWhitelistAddress, "More addresses cant be added, limit reached");
       
        whitelisted[msg.sender] = true;
      
        numAddressesWhitelisted += 1;
    }
}

//0x6C227fC6Dee51B9C352A8088BB18c52C77F336ac