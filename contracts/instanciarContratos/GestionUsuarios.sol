// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// Definición de la estructura de datos Usuario
struct Usuario {
    bool esAdmin;
    // Otros campos de usuario
}

// Contrato de gestión de usuarios
contract GestionUsuarios {
    // Mapping para almacenar la información de los usuarios
    mapping(address => Usuario) public usuarios;

    // Función para asignar el rol de administrador a un usuario
    function asignarRolAdmin(address _usuario) public {
        usuarios[_usuario].esAdmin = true;
    }
    function desasignarRolAdmin(address _usuario) public {
        usuarios[_usuario].esAdmin = false;
    }
}