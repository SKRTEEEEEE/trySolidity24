// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.6.0/utils/Counters.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";
import "./GestionUsuarios.sol";
//https://ipfs.io/ipfs/QmWYf5oBuk7ej8nPNgvmNy1P2tHwm6X4ZR5McMagxPSiNt/


contract CreateNFTCollectionPruebas is ERC721 {
    using Counters for Counters.Counter;
    address private gestionUsuarios = 0xd9145CCE52D386f254917e481eB44e9943F39138;//<-Provar en private para mas sec
    string private baseURI = "https://ipfs.io/ipfs/QmWYf5oBuk7ej8nPNgvmNy1P2tHwm6X4ZR5McMagxPSiNt/";
    uint256 public maxTokenSupply;
    Counters.Counter public tokenIdCounter;
    
    
    constructor( string memory _collectionName, string memory _tokenAbbreviation, uint256 _maxTokenSupply) ERC721(_collectionName, _tokenAbbreviation) {
        // gestionUsuarios = _direccionGestionUsuarios;
        // baseURI = _ipfsBaseURI;
        require(_maxTokenSupply > 0, "La cantidad maxima de NFTs debe ser mayor que cero");
        maxTokenSupply = _maxTokenSupply;
    }
    modifier soloAdmin {
        require(GestionUsuarios(gestionUsuarios).usuarios(msg.sender), "Acceso restringido a administradores");
        _;
    }

    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }

    function safeMint(address to) public soloAdmin {
        tokenIdCounter.increment();
        require(tokenIdCounter.current() <= maxTokenSupply, "Se alcanzo la cantidad maxima de NFTs");
        uint256 tokenId = tokenIdCounter.current();
        _safeMint(to, tokenId);

    }
}
