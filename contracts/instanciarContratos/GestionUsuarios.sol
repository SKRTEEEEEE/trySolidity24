// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// Definición de la estructura de datos Usuario
struct Usuario {
        bool esAdmin;
    // Otros campos de usuario
}

// Contrato de gestión de usuarios
contract GestionUsuarios {
    address public contractCreator;

    constructor(){
        contractCreator = msg.sender;
    }

    modifier onlyContractCreator() {
        require(msg.sender == contractCreator, "Solo el creador del contrato puede");
        _; // Continuar con la ejecución de la función si la condición se cumple
    }
    // Mapping para almacenar la información de los usuarios
    mapping(address => Usuario) public usuarios;

    // Funciones para asignar el rol de administrador a un usuario
    function asignarRolAdmin(address _usuario) public onlyContractCreator {
        usuarios[_usuario].esAdmin = true;
    }
    function desasignarRolAdmin(address _usuario) public onlyContractCreator {
        usuarios[_usuario].esAdmin = false;
    }
}