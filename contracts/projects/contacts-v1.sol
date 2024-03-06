// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Contacts is ERC1155 {
    uint256 public constant DanFotografia = 1;
    uint256 public constant DanAuditoria = 4;
    uint256 public constant Dan3D = 0;
    uint256 public constant AdanProgramacionWeb = 2;
    uint256 public constant AdanProgramacionWeb3 = 3;

    constructor() ERC1155("https://ipfs.io/ipfs/QmXVL2qrVRGHCtjU9UzYrAvgyaescG8W72h52X1V4wRYr7/{id}.json") {
        _mint(msg.sender, DanFotografia, 1, "");
        _mint(msg.sender, DanAuditoria, 1, "");
        _mint(msg.sender, Dan3D, 1, "");
        _mint(msg.sender, AdanProgramacionWeb, 1, "");
        _mint(msg.sender, AdanProgramacionWeb3, 1, "");
    }



    //Hay que poner la funcion uri para sobreescribir el id
     function uri(uint256 _tokenid) override public pure returns (string memory) {
        return string(
            abi.encodePacked(
                "https://ipfs.io/ipfs/QmXVL2qrVRGHCtjU9UzYrAvgyaescG8W72h52X1V4wRYr7/",
                Strings.toString(_tokenid),".json"
            )
        );
    }
}
