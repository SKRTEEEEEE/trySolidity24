// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts@4.4.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.4.0/access/Ownable.sol";

contract CanValdesNFTs is ERC721, Ownable {
    constructor() ERC721("Can-Valdes2", "FCB") {}

    function _baseURI() internal pure override returns (string memory) {
        return "https://ipfs.io/ipfs/QmWYf5oBuk7ej8nPNgvmNy1P2tHwm6X4ZR5McMagxPSiNt/";
    }

    function safeMint(address to, uint256 tokenId) public onlyOwner {
        _safeMint(to, tokenId);
    }
}