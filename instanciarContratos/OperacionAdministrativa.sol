// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// Importar el contrato de gestión de usuarios
import "./GestionUsuarios.sol";

// Contrato de gestión de operaciones administrativas
contract OperacionAdministrativa {
    // Dirección del contrato de gestión de usuarios
    address public gestionUsuarios;

    // Modificador que restringe el acceso a operaciones administrativas
    modifier soloAdmin {
        require(GestionUsuarios(gestionUsuarios).usuarios(msg.sender), "Acceso restringido a administradores");
        _;
    }

    // Evento para notificar cuando se realiza una operación administrativa
    event OperacionAdministrativaRealizada(address administrador, string descripcion);

    // Constructor que recibe la dirección del contrato de gestión de usuarios
    constructor(address _direccionGestionUsuarios) {
        gestionUsuarios = _direccionGestionUsuarios;
    }

    // Función que solo puede ser llamada por administradores para realizar una operación administrativa
    function realizarOperacionAdministrativa(string memory _descripcion) public soloAdmin {
        // Lógica para realizar la operación administrativa
        emit OperacionAdministrativaRealizada(msg.sender, _descripcion);
    }
}
