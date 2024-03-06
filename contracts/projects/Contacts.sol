// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Contacts is ERC1155 {
    uint256 public constant DanFotografia = 1;
    uint256 public constant DanAuditoria = 4;
    uint256 public constant Dan3D = 0;
    uint256 public constant AdanProgramacionWeb = 2;
    uint256 public constant AdanProgramacionWeb3 = 3;
    uint256 public mintPrice = 0.001 ether;
    string public name = "Contacts";
    // uint256 public maxSupply = 100;
    // uint256 internal totalMinted;

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
    function mint(uint256 numOfNFTs, uint256 _tokenIdContacts) external payable {
        // require(totalMinted + numOfNFTs < maxSupply,"Minting would exceed max supply");
        require(mintPrice * numOfNFTs <= msg.value,"Not enough MATIC sent");
        require(numOfNFTs <= 10,"Only up to 10 NFTs can be minted");
        _mint(msg.sender, _tokenIdContacts, numOfNFTs, "");
        // totalMinted += numOfNFTs;
    }
//     function getTotalSupply() external view returns (uint256) {
//         return maxSupply;
//    }
//    function getMinted() external view returns (uint256) {
//         return totalMinted;
//     }


}
