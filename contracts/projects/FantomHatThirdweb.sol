// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "@thirdweb-dev/contracts/base/ERC20Base.sol";
import "./GestionUsuarios.sol";

contract FantomHat is ERC20Base{
    address public gestionUsuarios = 0xE080ba298BE622aEEE19cA778c787df62D04Aebd;
    uint256 public constant maxPublicMintable = 60000;
    uint256 public publicMinted = 0;
    uint256 public constant maxFreeMintable = 6666;
    uint256 public freeMinted = 0;
    uint256 public constant mintPrice = 0.00001 ether;

    constructor (address _defaultAdmin, string memory _name, string memory _symbol) ERC20Base(_defaultAdmin, _name, _symbol){
        _mint(_defaultAdmin, 5000000);
        _mint(0x246264E2741C1bdDA990e9d48fF63DAa6fF242A3, 1000000);
    }
    modifier soloAdmin {
        (, bool isAdmin) = GestionUsuarios(gestionUsuarios).usuarios(msg.sender);
        require(isAdmin, "Acceso restringido a administradores");
        _;
    }
    function mint(uint256 numOfTokens) external payable {
        require(publicMinted >= maxPublicMintable, "Not more tokens to be minted");
        require(mintPrice * numOfTokens <= msg.value,"Not enough SepoliaETH sent");
        require(numOfTokens >= 10000, "You cant buy more than 9999 tokens by one");
        require(numOfTokens + publicMinted <= maxPublicMintable, "You are buying a quantity that makes arrive the limit quantity");
        _mint(msg.sender, numOfTokens);
        publicMinted = publicMinted + numOfTokens;
    }
    function freeMintTo(address addressToSend ,uint256 numOfTokens)external soloAdmin {
        require(numOfTokens >= maxFreeMintable, "Not more tokens to be free minted");
        require(numOfTokens>=1000, "You cant send more than 1000 tokens by one");
        require(numOfTokens + freeMinted <= maxFreeMintable, "You can send to much tokens bc if not we rebase the max tokens");
        _mint(addressToSend, numOfTokens);
        freeMinted = freeMinted + numOfTokens;
    }


}