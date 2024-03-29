// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@thirdweb-dev/contracts/base/ERC1155Base.sol";
// import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
// import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
// import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./GestionUsuarios.sol";
// import "@openzeppelin/contracts/utils/Strings.sol";

contract MyNFT is ERC1155Base {
    uint256 public constant DanFotografia = 1;
    uint256 public constant DanAuditoria = 4;
    uint256 public constant Dan3D = 0;
    uint256 public constant AdanProgramacionWeb = 2;
    uint256 public constant AdanProgramacionWeb3 = 3;
    uint256 public mintPrice = 0.001 ether;
    // string public name = "MyNFT";
    address public gestionUsuarios = 0xE080ba298BE622aEEE19cA778c787df62D04Aebd;

    constructor(
        address _defaultAdmin,
        string memory _name,
        string memory _symbol,
        address _royaltyRecipient,
        uint128 _royaltyBps
    )
        ERC1155Base(
            _defaultAdmin,
            _name,
            _symbol,
            _royaltyRecipient,
            _royaltyBps
        )
    {
        // _name = name;
        _mint(_defaultAdmin, DanFotografia, 1, "");
        _mint(_defaultAdmin, DanAuditoria, 1, "");
        _mint(_defaultAdmin, Dan3D, 1, "");
        _mint(_defaultAdmin, AdanProgramacionWeb, 1, "");
        _mint(_defaultAdmin, AdanProgramacionWeb3, 1, "");
    }

    modifier soloAdmin {
        (, bool isAdmin) = GestionUsuarios(gestionUsuarios).usuarios(msg.sender);
        require(isAdmin, "Acceso restringido a administradores");
        _;
    }

    function uri(uint256 _tokenid) override public pure returns (string memory) {
        return string(
            abi.encodePacked(
                "https://ipfs.io/ipfs/QmXVL2qrVRGHCtjU9UzYrAvgyaescG8W72h52X1V4wRYr7/",
                Strings.toString(_tokenid),".json"
            )
        );
    }

    function mint(uint256 numOfNFTs, uint256 tokenIdContacts) external payable {
        require(mintPrice * numOfNFTs <= msg.value,"Not enough SepoliaETH sent");
        require(numOfNFTs <= 10,"Only up to 10 NFTs can be minted");
        _mint(msg.sender, tokenIdContacts, numOfNFTs, "");
    }

    function freeMintTo (uint256 numOfNFTs, uint256 tokenIdContacts, address addressToSend ) external soloAdmin {
        _mint(addressToSend, tokenIdContacts, numOfNFTs, "");
    }
}