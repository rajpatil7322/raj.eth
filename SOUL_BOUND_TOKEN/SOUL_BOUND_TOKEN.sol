// SPDX-License-Identifier: MIT
import "@openzeppelin/contracts/access/Ownable.sol";
pragma solidity ^0.8.12;

contract SBT is Ownable {

    string private _name;
    string private _symbol;

    uint256 token;


    mapping(uint256 => address) private _owners;
    mapping(uint256 => string) private _tokenURIs;
    mapping (address => uint256) private balanceOf;
    constructor(
    string memory name_,
    string memory symbol_
  ) {
    _name = name_;
    _symbol = symbol_;
  }

  function name() public view virtual  returns (string memory) {
    return _name;
  }

  function symbol() public view virtual  returns (string memory) {
    return _symbol;
  }

  function ownerOf(uint256 tokenId) public view virtual returns (address) {
    address owner = _owners[tokenId];
    require(owner != address(0), "ownerOf: token doesn't exist");
    return owner;
  }

  function balance(address _of) public view virtual returns (uint256) {
        return balanceOf[_of];
  }


  function _exists(uint256 tokenId) internal view virtual returns (bool) {
      return _owners[tokenId] != address(0);
  }

  function _mint(
    address to,
    uint256 tokenId,
    string memory uri
  ) internal virtual onlyOwner returns (uint256) {
    require(!_exists(tokenId), "mint: tokenID exists");
    _owners[tokenId] = to;
    _tokenURIs[tokenId] = uri;
    balanceOf[to]++;
   
    return tokenId;
  }

  function mint(address to,string memory str) external onlyOwner{
    token++;
    _mint(to,token,str);
  }

  function _burn(address _of,uint256 tokenId) external virtual onlyOwner {
    delete _owners[tokenId];
    delete _tokenURIs[tokenId];
    balanceOf[_of]--;

  } 
}
