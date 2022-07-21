// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "./SBT.sol";


contract Curse is SBT {
    using SafeMath for uint256; 
    uint256 curse_potion_1=1;
    uint256 curse_potion_2=2;

    function curse(address _to,uint256 _id) external{
        _mint(_to,_id);
    }

    function revive(address _of,uint256 _id) external {
        _burn(_of,_id);
    }
}