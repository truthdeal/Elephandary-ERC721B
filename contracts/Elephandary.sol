// SPDX-License-Identifier: MIT
/*                 
                                                           @@@@@@@@@@@                                        
                                                        @@@@@@@@@@@@@@@(                        
                                                     @@@          &@@, #@@@@                    
                                                    @@              @@     @@@                 
                                        @@@@@@@@@@@@@                      @@/   @@@@@@        
                                 &@@@@@@%           @@                .     @@@   @@@ @@@       
                             .@@@&                  @@@              @@/    @@#    @@  @@       
                           ,@@&                      &@@             #     (@@     @@  @@      
                          @@@                          @@@,       @@@      @@     @@@  @@      
                         .@@                              @@@@@@@@@        @@@@@@@@    @@      
                         &@@                                                          @@@       
                         @@(                                    #&@@                &@@(        
                          @@@                                   @@ &@@@&        /@@@@           
                          %@@                                  @#%     (@@@@@@@@&               
                           @@                 *&@@@@@@@.       @@                               
                           @@/      /@@@@@@@@%(       @@      @@@                               
                           @@&      @@,               @@      @@                                
                           &@@      @@                @@      @@                                
                            @@      @@(               @@      @@                                
                            @@#     (@@               @@@     @@                                
                             (@@@@@@@#                  &@@@@@#                                 
                                      


  
   /$$$$$$$$ /$$                     /$$                                 /$$                              
  | $$_____/| $$                    | $$                                | $$                              
  | $$      | $$  /$$$$$$   /$$$$$$ | $$$$$$$   /$$$$$$  /$$$$$$$   /$$$$$$$  /$$$$$$   /$$$$$$  /$$   /$$
  | $$$$$   | $$ /$$__  $$ /$$__  $$| $$__  $$ |____  $$| $$__  $$ /$$__  $$ |____  $$ /$$__  $$| $$  | $$
  | $$__/   | $$| $$$$$$$$| $$  \ $$| $$  \ $$  /$$$$$$$| $$  \ $$| $$  | $$  /$$$$$$$| $$  \__/| $$  | $$
  | $$      | $$| $$_____/| $$  | $$| $$  | $$ /$$__  $$| $$  | $$| $$  | $$ /$$__  $$| $$      | $$  | $$
  | $$$$$$$$| $$|  $$$$$$$| $$$$$$$/| $$  | $$|  $$$$$$$| $$  | $$|  $$$$$$$|  $$$$$$$| $$      |  $$$$$$$
  |________/|__/ \_______/| $$____/ |__/  |__/ \_______/|__/  |__/ \_______/ \_______/|__/       \____  $$
                          | $$                                                                   /$$  | $$
                          | $$                                                                  |  $$$$$$/
                          |__/                                                                   \______/
  

@author:   Baris Arya CANTEPE  (@bcantepe)


*/
pragma solidity ^0.8.4;

import "@beskay/erc721b/contracts/ERC721B.sol"      ;
import "@openzeppelin/contracts/access/Ownable.sol" ;
import "@openzeppelin/contracts/utils/Strings.sol"  ;
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol"  ;

contract Elephandary is ERC721B, Ownable {
using Strings for uint256;


//  Contract Variables


uint256 public maxSupply = 4444;  //  maxSupply can only be reduced.
uint256 public wlReservedSupply = 150;
uint256 public constant maxFreeMint = 1500;
uint256 public constant teamReservedSupply = 81;

uint256 public mintPrice = 0.007 ether;
uint256 public maxMintPerWallet = 6;
uint256 public maxMintPerTx = 5; 

uint256 public teamMinted; 
uint256 public wlMinted; 
bool    public saleStatus = false;

bytes32 public root = 0x29038e5d54edab0ef9258adc31dd0e5bb01f4536881dbefbfaf9bf4aa9e3a6e1;
string  public baseTokenUrl = "ipfs://QmS27ifo6mTBhHHJynKgxhoqamT6f2WAkXgPvHejoUZvsY/";
string  public tokenUrlExtension = ".json";

mapping (address => uint256) public _numberMinted; 

address constant KITTEN1   = 0x69CC9A9E7f38117dc40d850dF43eC21b6B416A47 ; // Mojo Jojo
address constant KITTEN2   = 0xd8925d9BC9D55b7a25428D3593b1b425388c6287 ; // Blossom
address constant KITTEN3   = 0x8c1715Ac3466547193567e403752960114CB3147 ; // Bubbles
address constant KITTEN4   = 0xd2ECFb430B55E0726b77Eb84380FB531cfdE1EA9 ; // Buttercup

constructor () ERC721B( "Elephandary" , "ELEPHAN") {
    teamMint();
}


// Mint Functions


function freeMint () public onlyAccount() {

    require(saleStatus == true , "Mint is inactive.");
    uint256 _maxFreeMint = 1500 + 81 - wlReservedSupply + wlMinted;
    //Constant variables created again on memory to save gas. 
    require(_numberMinted[msg.sender] < 1, "You can't mint free anymore");
    require(totalSupply() + 1 <=  _maxFreeMint   , "Maximum free mint amount reached.");
    

    _numberMinted[msg.sender] += 1 ;
    _mint(msg.sender, 1);
  
}


function publicMint (uint256 amount_) public payable mintRequirements(amount_) onlyAccount() {
 
    _numberMinted[msg.sender] += amount_ ;
    _mint(msg.sender, amount_);

}


function teamMint() private {

    require( teamMinted <= teamReservedSupply ,   "No more Team mint" );
    teamMinted += 81;

    _mint(msg.sender, 1);
    _mint(KITTEN1, 20);
    _mint(KITTEN2, 20);
    _mint(KITTEN3, 20);
    _mint(KITTEN4, 20);

}


function wlMint (address to , bytes32[] memory proof) external {

    require(saleStatus == true , "Mint is inactive.");
    require(to == msg.sender ,  "You don't have permission to mint with other addresses.") ;
    require(isValid(proof , keccak256(abi.encodePacked(msg.sender))), "You are not allowed for WlMint.") ;
    require(wlMinted + 1 <= wlReservedSupply , "Wl spots are over.") ;
    require(_numberMinted[msg.sender] < 1, "You can't mint free anymore");
    require(totalSupply() + 1 <= maxSupply , "We are sold out!!");

    _numberMinted[msg.sender] += 1 ;
    wlMinted += 1;
    _mint(msg.sender, 1);

}


// Owner Functions


// This function can only reduce max supply. 
function reduceSupply (uint256 _maxSupply) external onlyOwner {
    require(_maxSupply < maxSupply, "Supply can not be increased, only reduce.") ;

    maxSupply = _maxSupply ;
}

function withdraw() external onlyOwner {
    uint256 balance = address(this).balance ;
    require (balance > 0 , "Zero balance, can not withdraw") ;

    _withdraw(KITTEN1, (balance * 250) / 1000) ;
    _withdraw(KITTEN2, (balance * 250) / 1000) ;
    _withdraw(KITTEN3, (balance * 250) / 1000) ;
    _withdraw(KITTEN4, (balance * 250) / 1000) ;
}

function _withdraw(address _address, uint256 _amount) private {
    (bool success, ) = _address.call{value: _amount}("");
    require(success, "Transfer failed.");   
}


// Variable Changers


function setMintPrice (uint256 mintPrice_) external onlyOwner {
    mintPrice = mintPrice_ ;
}

function setWlReservedSupply (uint256 wlReservedSupply_) external onlyOwner {
    require(wlMinted <= wlReservedSupply_ , "Reserved supply can not be less than minted WL amount.") ;
    wlReservedSupply = wlReservedSupply_ ;
}

function setMaxMintPerWallet (uint256 maxMintPerWallet_) external onlyOwner {
    maxMintPerWallet = maxMintPerWallet_ ;
}

function setMaxMintPerTx (uint256 maxMintPerTx_) external onlyOwner {
    maxMintPerTx = maxMintPerTx_ ;
}

function setSaleStatus (bool saleStatus_) external onlyOwner {
    saleStatus = saleStatus_ ;
}

function setBaseTokenUrl(string memory _baseTokenUrl) public onlyOwner {
    baseTokenUrl = _baseTokenUrl;
}

function setTokenUrlExtension(string memory _tokenUrlExtension) public onlyOwner {
    tokenUrlExtension = _tokenUrlExtension;
}

function setRoot(bytes32 _root) onlyOwner public {
    root = _root;  
}


// View Functions


function _baseURI() internal view returns (string memory) {
    return baseTokenUrl;
}

function _suffix() internal view virtual returns (string memory) {
    return tokenUrlExtension;
}

function tokenURI(uint256 tokenId) public view virtual override returns (string memory){
    if (!_exists(tokenId)) revert URIQueryForNonexistentToken();
    string memory baseURI = _baseURI();
    string memory suffix = _suffix();
    return bytes(baseURI).length != 0 ? string(abi.encodePacked(baseURI, tokenId.toString(), suffix)): "";
}

function isValid(bytes32[] memory proof, bytes32 leaf ) public view returns (bool) {
    return MerkleProof.verify(proof, root , leaf) ;
}


// Modifiers


modifier mintRequirements (uint256 _amount) {
    require(saleStatus == true , "Public mint is inactive");
    require(totalSupply() + _amount <= (maxSupply - wlReservedSupply + wlMinted)  , "Maximum mint amount reached"); 
    require(_amount > 0 , "Mint amount can not be 0");
    require(_numberMinted[msg.sender] + _amount <= maxMintPerWallet , "You've minted max amount" );
    require(_amount <= maxMintPerTx , "Max mint amount per tx exceed");
    require(msg.value >= _amount  * mintPrice , "Insufficient ETH");
    _;
}

modifier onlyAccount() {
    // Contracts are not allowed
    require(msg.sender == tx.origin, "Only accounts ser.");
    _;
}

}