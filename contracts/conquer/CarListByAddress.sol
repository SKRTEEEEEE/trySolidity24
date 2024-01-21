// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2;

contract CarListByAddress {
    address owner;
    uint256 precio;
    uint256[] identificadores;
    mapping(address => Coche) coches;
    struct Coche {
        uint256 identificadores;
        string marca;
        uint32 caballos;
        uint32 kilometros;
    }
    modifier precioFiltro(uint256 _precio){
        require(_precio == precio);
        _;
    }

    constructor(uint256 _precio) {
        owner = msg.sender;
        precio = _precio;
    }

    function addCoche(uint256 _id, string memory _marca, uint32 _caballos, uint32 _kilometros) public precioFiltro(msg.value) payable {
        identificadores.push(_id);
        coches[msg.sender] = Coche(_id, _marca, _caballos, _kilometros);
    }
    function getLength() external view returns(uint256){
        return identificadores.length;
    }
    function getCocheBYAddress() external view returns(string memory marca, uint32 caballos, uint32 kilometros){
        marca = coches[msg.sender].marca;
        caballos = coches[msg.sender].caballos;
        kilometros = coches[msg.sender].kilometros;
    }

}