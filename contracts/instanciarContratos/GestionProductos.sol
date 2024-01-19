// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// Importar el contrato de gestión de usuarios
import "./GestionUsuarios.sol";

// Contrato de gestión de productos
contract GestionProductos {
    // Dirección del contrato de gestión de usuarios
    address public gestionUsuarios;

    // Evento para notificar cuando se agrega un nuevo producto
    event ProductoAgregado(string nombre, uint256 precio);

    // Modificador que restringe el acceso a ciertos roles
    modifier soloAdmin {
        require(GestionUsuarios(gestionUsuarios).usuarios(msg.sender), "Acceso restringido a administradores");
        _;
    }

    // Constructor que recibe la dirección del contrato de gestión de usuarios
    constructor(address _direccionGestionUsuarios) {
        gestionUsuarios = _direccionGestionUsuarios;
    }

    // Función que solo puede ser llamada por administradores para agregar un nuevo producto
    function agregarNuevoProducto(string memory _nombre, uint256 _precio) public soloAdmin {
        // Lógica para agregar un nuevo producto
        emit ProductoAgregado(_nombre, _precio);
    }
}