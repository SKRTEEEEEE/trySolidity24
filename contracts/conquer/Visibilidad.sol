// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2;
/*
VISIBILIDAD DE VARIABLES Y FUNCIONES
- PUBLIC: completamente accesible, sea cual sea el origen
- PRIVATE: solo se puede acceder desde el smart contract donde se declaran
- INTERNAL: solo se puede acceder desde el SC se declara 
            y los que derivan de el
- EXTERNAL: parte de la interfaz del contrato
            pueden llamarse desde otros contratos y transacciones,
            pero no pueden llamarse internamente


*/

contract Visibilidad {
    string private  mensajePrivate = "Hola Mundo";
    string internal mensajeInternal = "Conquer Blocks";
    string public mensajePublic = "Hola gente";

}

contract B is Visibilidad {
    function getMensajeInternal() public view returns (string memory){
        return mensajeInternal;
    }
}