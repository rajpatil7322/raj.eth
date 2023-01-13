// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract FunNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    struct Collection {
      uint tokenId;
      uint price;
      bool forSale;
    }

    mapping(uint => Collection) collections;

    constructor() ERC721("FunNFT Collection", "FUN") {}

    function mint(string memory tokenURI, uint price) public returns (uint tokenId) {
        // increment the counter, to get the next tokenId.
        _tokenIds.increment();
        tokenId = _tokenIds.current();

        // mint the new NFT and then set its tokenURI.
        _mint(msg.sender, tokenId);
        _setTokenURI(tokenId, tokenURI);

        // add it to the collection.
        Collection memory collection = Collection(
            tokenId,
            price,
            false
        );
        collections[tokenId] = collection;
    }

    function buy(uint tokenId) public payable {
        // verify that the NFT exists.
        require(_exists(tokenId));

        // verify that owner of the token is not the one calling this function.
        require(msg.sender != ownerOf(tokenId));

        Collection memory collection = collections[tokenId];

        // verify that the price sent is greater than equal to NFT's price.
        require(msg.value >= collection.price);

        // verify that the NFT is available to buy
        require(collection.forSale);

        // transfer the NFT from the owner to the buyer.
        address owner = ownerOf(tokenId);
        payable(owner).transfer(msg.value);
        _transfer(owner, msg.sender, tokenId);

        // update the mapping.
        collection.forSale = false;
        collections[tokenId] = collection;
    }

    function toggleForSale(uint tokenId) public {
        // verify that the NFT exists.
        require(_exists(tokenId));

        // verify that owner of the token is the one calling this function.
        require(msg.sender == ownerOf(tokenId));

        // get the NFT from mapping and store it in memory.
        Collection memory collection = collections[tokenId];

        collection.forSale = !collection.forSale;

        // update the NFT in the mapping.
        collections[tokenId] = collection;
    }
}

//0xdF6Ebcd7c7043d2CA2c1B02EF43465bC29cAf22d