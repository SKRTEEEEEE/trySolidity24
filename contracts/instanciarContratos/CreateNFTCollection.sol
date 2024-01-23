// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";
import "./GestionUsuarios.sol";
//https://ipfs.io/ipfs/QmWYf5oBuk7ej8nPNgvmNy1P2tHwm6X4ZR5McMagxPSiNt/


contract CreateNFTCollection is ERC721 {
    address public gestionUsuarios;
    string private baseURI;
    
    constructor(address _direccionGestionUsuarios, string memory _ipfsBaseURI, string memory _collectionName, string memory _tokenAbbreviation) ERC721(_collectionName, _tokenAbbreviation) {
        baseURI = _ipfsBaseURI;
        gestionUsuarios = _direccionGestionUsuarios;
    }
    modifier soloAdmin {
        require(GestionUsuarios(gestionUsuarios).usuarios(msg.sender), "Acceso restringido a administradores");
        _;
    }

    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }

    function safeMint(address to, uint256 tokenId) public soloAdmin {
        _safeMint(to, tokenId);
    }
}
