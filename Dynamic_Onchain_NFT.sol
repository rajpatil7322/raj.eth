// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./Base64.sol";

contract Dynamic_NFT is ERC721Enumerable, Ownable {
  using Strings for uint256;

  string[] public words = ["BTC","XRP","ETH","MATIC"];

  struct Words{
    string name;
    string description;
    string bHuew;
    string texthue;
    string value;
  }

  mapping(uint256 => Words) public word_map;


  constructor(
  ) ERC721("Onchain","ONC") {}

  function mint() public payable{
      uint256 supply=totalSupply();
      require(supply+1 <=10);

      Words memory newWord=Words(
        string(abi.encodePacked('OCN#',uint256(supply+1).toString())),
        "This is your cool NFT",
        random(361,block.timestamp,supply).toString(),
        random(361,block.timestamp,supply).toString(),
        words[random(words.length,block.difficulty,supply)]
      );

      if(msg.sender!=owner()){
          require(msg.value>=0.05 ether,"Only Owner can mint the nft for free");

      }
      word_map[supply+1]=newWord;
      _safeMint(msg.sender,supply+1);
  }
  //Built a pseudo random number generator...Can use ChainLink VRF instead.
  function random(uint _mod,uint _seed,uint _salt) internal view returns(uint){
      uint num=uint(keccak256(abi.encodePacked(block.timestamp,msg.sender,_seed,_salt))) % _mod;
      return num;
  }
  //Function that builds the SVG code as a BAse64 encoded string.
  function biuldImage(uint256 _tokenid) internal view returns(string memory){
    Words memory currentword=word_map[_tokenid];
    return Base64.encode(bytes(abi.encodePacked(
        '<svg width="800" height="600" xmlns="http://www.w3.org/2000/svg">',
        '<rect  height="276" width="356" y="175" x="230" stroke="#000" fill="hsl(',currentword.bHuew,',50%,25%)"/>',
        '<text dominant-baseline="middle" text-anchor="middle" font-size="24" y="50%" x="50%" stroke-width="0" stroke="#000" fill="hsl(',currentword.texthue,',10%,85%)">',currentword.value,'</text>',
        '</svg>'
    )));
  }

  function tokenURI(uint256 tokenId)
    public
    view
    virtual
    override
    returns (string memory){
    require(
      _exists(tokenId),
      "ERC721Metadata: URI query for nonexistent token"
    );
     Words memory currentword=word_map[tokenId];
    
    return string(abi.encodePacked(
        'data:application/json;base64,',Base64.encode(bytes(abi.encodePacked(
            '{"name":"',
            currentword.name,
            '", "description":"',
            currentword.description,
            '", "image":"',
            'data:image/svg+xml;base64,',
            biuldImage(tokenId),
            '"}'

        )))));
  }

}