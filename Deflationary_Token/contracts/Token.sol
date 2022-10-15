//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "./ERC20MOD.sol";

contract Token is ERC20MOD {

    constructor() ERC20MOD("TOKEN","TK"){
        _mint(msg.sender,10);
    }
}

