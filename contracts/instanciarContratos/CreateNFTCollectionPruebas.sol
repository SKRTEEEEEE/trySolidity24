// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.6.0/utils/Counters.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "./GestionUsuarios.sol";
//https://ipfs.io/ipfs/QmWYf5oBuk7ej8nPNgvmNy1P2tHwm6X4ZR5McMagxPSiNt/


contract CreateNFTCollectionPruebas is ERC721 {
    using Counters for Counters.Counter;
    AggregatorV3Interface internal priceFeed;
    address private gestionUsuarios = 0xd3Aff0855aA92fa8A4D5575194CC6AC7E94677a4;//<-Provar en private para mas sec
    string private baseURI = "https://ipfs.io/ipfs/QmWYf5oBuk7ej8nPNgvmNy1P2tHwm6X4ZR5McMagxPSiNt/";
    uint256 public maxTokenSupply;
    uint8 public priceInUSD = 2;
    // uint256 public priceToken = calculateETHAmountFromUSD(2);
    Counters.Counter public tokenIdCounter;
    
    
    constructor( string memory _collectionName, string memory _tokenAbbreviation, uint256 _maxTokenSupply) ERC721(_collectionName, _tokenAbbreviation) {
        // gestionUsuarios = _direccionGestionUsuarios;
        // baseURI = _ipfsBaseURI;
         /**
        * Network: Sepolia
        * Aggregator: ETH/USD
        * Address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        */
        priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        require(_maxTokenSupply > 0, "La cantidad maxima de NFTs debe ser mayor que cero");
        maxTokenSupply = _maxTokenSupply;
    }
    modifier soloAdmin {
        require(GestionUsuarios(gestionUsuarios).usuarios(msg.sender), "Acceso restringido a administradores");
        _;
    }


    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }
    function getChainlinkDataFeedLatestAnswer() public view returns (int) {
        (
            /*uint80 roundID*/,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();
        return price;
    }
function calculateETHAmountFromUSD() public view returns (uint) {
    uint256 price = uint256(getChainlinkDataFeedLatestAnswer());
    
    // Calcular la cantidad de ETH equivalente a 2 USD
    uint ethAmount1 = (priceInUSD * 1e18 ) /  price;  // Multiplica por 1e18 para manejar decimales en el precio
    uint ethAmount = ethAmount1 * 1e8;
    return ethAmount;
}


    function safeMintForAdmins(address to) public soloAdmin {
        tokenIdCounter.increment();
        require(tokenIdCounter.current() <= maxTokenSupply, "Se alcanzo la cantidad maxima de NFTs");
        uint256 tokenId = tokenIdCounter.current();
        _safeMint(to, tokenId);
    }
    function mintPaying() public payable {
        uint256 ethAmount = calculateETHAmountFromUSD();
        require(msg.value >= ethAmount, "El monto enviado no cubre el costo de mint");//<-Minimo 10gwei
        tokenIdCounter.increment();
        require(tokenIdCounter.current() <= maxTokenSupply, "Se alcanzo la cantidad maxima de NFTs");
        uint256 tokenId = tokenIdCounter.current();
        _safeMint(msg.sender, tokenId);
    }
}
