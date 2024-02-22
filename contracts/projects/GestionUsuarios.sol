// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

// Contrato de gestión de usuarios
contract GestionUsuarios {
    address public contractCreator;
    int256 public numUsers;

    constructor() {
        contractCreator = msg.sender;
        numUsers = 0;
    }

    modifier onlyContractCreator() {
        require(msg.sender == contractCreator, "Solo el creador del contrato puede");
        _; // Continuar con la ejecución de la función si la condición se cumple
    }

    // Estructura de Usuario
    struct Usuario {
        int256 id;
        bool esAdmin;
        // Otros campos de usuario
    }

    // Mapping para almacenar la información de los usuarios
    mapping(address => Usuario) public usuarios;

    // Funciones para asignar y desasignar el rol de administrador a un usuario
    function asignarRolAdmin(address _usuario) public onlyContractCreator {
        usuarios[_usuario].esAdmin = true;
        usuarios[_usuario].id = numUsers;
        numUsers++;
    }

    function desasignarRolAdmin(address _usuario) public onlyContractCreator {
        usuarios[_usuario].esAdmin = false;
        delete usuarios[_usuario].id;
        numUsers--;
    }

    // Función para obtener información de un usuario
    function obtenerInfoUsuario(address _usuario) public view returns (bool esAdmin) {
        return usuarios[_usuario].esAdmin;
    }

}
