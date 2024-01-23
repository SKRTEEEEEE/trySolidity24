// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


// Importar el contrato de gestión de usuarios
import "./GestionUsuarios.sol";
// import "./CreateNFTCollection.sol";

// Contrato de gestión de productos
contract GestionProductos {
    // Dirección del contrato de gestión de usuarios
    address public gestionUsuarios;

    struct Product {
        uint256 id;
        string name;
        uint256 precio;
        uint256 uds;
        string ipfs;
        string token;
    }
    uint256 numProduct;
    mapping (uint256=> Product) public products;

    // Evento para notificar cuando se agrega un nuevo producto
    event ProductoAgregado(string nombre, uint256 precio, uint256 uds, string ipfs, string token);

    // Modificador que restringe el acceso a ciertos roles
    modifier soloAdmin {
        require(GestionUsuarios(gestionUsuarios).usuarios(msg.sender), "Acceso restringido a administradores");
        _;
    }

    // Constructor que recibe la dirección del contrato de gestión de usuarios
    constructor(address _direccionGestionUsuarios) {
        gestionUsuarios = _direccionGestionUsuarios;
        numProduct = 0;
    }

    // Función que solo puede ser llamada por administradores para agregar un nuevo producto
    function agregarNuevoProducto(string memory _nombre, uint256 _precio, uint256 _uds, string memory _ipfs, string memory _token) public soloAdmin {
        // Lógica para agregar un nuevo producto
        products[numProduct] = Product(numProduct, _nombre, _precio, _uds, _ipfs, _token);
        // CreateNFTCollection nftCollection = new CreateNFTCollection(_ipfs, _nombre, _token);
        emit ProductoAgregado(_nombre, _precio, _uds, _ipfs, _token);
        numProduct++;
    }
    // function safeMintNFT(address nftCollectionAddress, address to, uint256 tokenId) public {
    //     CreateNFTCollection nftCollection = CreateNFTCollection(nftCollectionAddress);
    //     nftCollection.safeMint(to, tokenId);
    // }
}