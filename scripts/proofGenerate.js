const keccak256 = require("keccak256");
const { default: MerkleTree } = require("merkletreejs");

const addresses = [
    "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4",
    "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2",
    "0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db",
    "0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db",
    "0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db",
    "0x17F6AD8Ef982297579C203069C1DbfFE4348c372",
    "0x5c6B0f7Bf3E7ce046039Bd8FABdfD3f9F5021678",
    "0x03C6FcED478cBbC9a4FAB34eF9f40767739D1Ff7",
    "0x03C6FcED478cBbC9a4FAB34eF9f40767739D1Ff7",
    "0x0A098Eda01Ce92ff4A4CCb7A4fFFb5A43EBC70DC",
    ]


    const leaves = addresses.map(x => keccak256(x)) ;
    const tree = new MerkleTree(leaves , keccak256 , {sortPairs: true}) ;
    const buf2hex = x => '0x' + x.toString('hex') ;
    
    console.log("The root is :");
    console.log(buf2hex(tree.getRoot())) ;

// bu adresleri iki dosyada da tutma birinden otomatik çektir veya web kısmında hallet

const leaf = keccak256(addresses[1]) ; // buradaki adresses[0] kısmına mintlemek isteyen kimse onun aresi gelecek
const proof = tree.getProof(leaf).map(x => buf2hex(x.data)) ;
//Gelen proof bir bytes arrayi

console.log("The proof is:");
console.log(proof);

//proofu yazarken ' ' olanları "" arasına çevirmek gerekiyor
 
//contractla etkileşime girmek için
/*

contract.wlMint(addresses[0] , proof) ;
gibi

*/


