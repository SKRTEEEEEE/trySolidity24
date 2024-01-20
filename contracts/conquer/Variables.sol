
// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

contract Variables{
    //Variables enteras
    uint32 public numero = 100;
    int8 public numero2 = -2;

    //Strings

    string public cadena = "Esto es una cadena";

    //Boolean

    bool verdadero = true;
    bool falso = false;

    //Dirrecciones

    address public dir = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
    address public owner = msg.sender;

    //Bytes

    bytes32 public hashing = keccak256(abi.encodePacked("keyPair", "palabra"));

}