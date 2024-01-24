// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
// import "@openzeppelin/contracts/utils/math/SafeMath.sol";

import "./CreateNFTCollection.sol";
import "./GestionUsuarios.sol";

contract CompraNFT {
    address public direccionColeccionNFT;
    address public gestionUsuarios;
    // using SafeMath for uint256;
    // uint256 public costoMint = 1 ether;

    // Constructor que recibe la dirección de la colección NFT
    constructor(address _direccionColeccionNFT) {
        direccionColeccionNFT = _direccionColeccionNFT;
        // gestionUsuarios = _direccionGestionUsuarios;
    }

    // Modificador para restringir el acceso solo alos admin
    // modifier soloAdmin {
    //     require(GestionUsuarios(gestionUsuarios).usuarios(msg.sender), "Acceso restringido a administradores");
    //     _;
    // }    

    // Función para hacer safeMint desde el contrato intermediario
    function safeMintTienda() public {
        // require(msg.value >= 10, "El monto enviado no cubre el costo de mint");

        // Calcula el cambio, si hay más ETH enviado de lo necesario
        // uint256 cambio = msg.value.sub(costoMint);

        // Transfiere el cambio de vuelta al remitente
        // if (cambio > 0) {
        //     payable(msg.sender).transfer(cambio);
        // }

        // Almacena 1 ETH en el contrato
        // (esto puede ser modificado según tus necesidades específicas)
        //  payable(address(this)).transfer(costoMint);
        // Usa la función safeMint del contrato NFT de la colección
        CreateNFTCollection(direccionColeccionNFT).safeMint(msg.sender);
    }
}
