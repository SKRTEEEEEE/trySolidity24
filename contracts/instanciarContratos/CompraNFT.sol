// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "./CreateNFTCollection.sol";
import "./GestionUsuarios.sol";

contract CompraNFT {
    address public direccionColeccionNFT;
    address public gestionUsuarios;


    // Constructor que recibe la dirección de la colección NFT
    constructor(address _direccionColeccionNFT, address _direccionGestionUsuarios) {
        direccionColeccionNFT = _direccionColeccionNFT;
        gestionUsuarios = _direccionGestionUsuarios;
    }

    // Modificador para restringir el acceso solo alos admin
    modifier soloAdmin {
        require(GestionUsuarios(gestionUsuarios).usuarios(msg.sender), "Acceso restringido a administradores");
        _;
    }    

    // Función para hacer safeMint desde el contrato intermediario
    function safeMintTienda(uint256 tokenId) public soloAdmin {
        // Usa la función safeMint del contrato NFT de la colección
        CreateNFTCollection(direccionColeccionNFT).safeMint(msg.sender , tokenId);
    }
}
