// SPDX-License-Identifier: MIT
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
pragma solidity ^0.8.12;

contract SBT is Ownable {
    using SafeMath for uint256;

    mapping(uint256 => string) private _tokenURIs;
    mapping(uint256 => mapping(address => uint256)) private _balances;
    

  function setUri(uint256 _id,string memory _uri) external virtual onlyOwner{
    _tokenURIs[_id]=_uri;
  }

   function balanceOf(address account, uint256 id) public view virtual returns (uint256) {
        require(account != address(0), "address zero is not a valid owner");
        return _balances[id][account];
    }


  function _mint(
    address to,
    uint256 tokenId
  ) internal virtual onlyOwner {
    _balances[tokenId][to].add(1);
  }

  function _burn(address _of,uint256 tokenId) internal virtual onlyOwner {
    _balances[tokenId][_of].sub(1);
  } 
}
