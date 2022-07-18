# Basic Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, a sample script that deploys that contract, and an example of a task implementation, which simply lists the available accounts.

Try running some of the following tasks:

```shell
npx hardhat accounts
npx hardhat compile
npx hardhat clean
npx hardhat test
npx hardhat node
node scripts/sample-script.js
npx hardhat help
```

Sırasıyla adımlar :

Dosya dizini açıldı

npm init

ile npm projesi başlatıldı

npm install --save-dev "hardhat@^2.9.7"

Hardhat indirildi

npm install --save-dev @nomiclabs/hardhat-waffle 'ethereum-waffle@^3.0.0' @nomiclabs/hardhat-ethers 'ethers@^5.0.0'

Hardhat Waffle ve Hardhat Ethers indirildi

npm i web3

Web3 indirildi

npx hardhat

açılarak basic sample project açıldı

npm install --save-dev erc721a

ERC721A indirildi

npm install --save-dev @beskay/erc721b

ERC721B indirildi

npm install @openzeppelin/contracts

Openzeppelin contractları indirildi

npm install merkletreejs

Merkle tree indirildi wl mintler için

npm install keccak256

şifreleme yapabilmek için prooflarda keccak256 algoritması indirildi

---

npm install --save-dev @nomiclabs/hardhat-etherscan

hardhat etherscan için indirildi
https://hardhat.org/plugins/nomiclabs-hardhat-etherscan nasıl yapılacağı burada yazıyor

require("@nomiclabs/hardhat-etherscan");

Hardhat confige eklendi

---

npm install dotenv --save

Dotenv .env dosyası için eklendi

Etherscandan api key oluşturuldu

.env dosyasına infura mainnet api key , polygon mainnet api key, Ropsten api key, rinkeby api key, Etherscan api, public key , private key eklendi

hardhat.config dosyasına
require("@nomiclabs/hardhat-ethers");
const { API_URL, POLYGON_API_URL, ROPSTEN_API_URL , RINKEBY_API_URL , ETHERSCAN_API,PRIVATE_KEY, } = process.env;

eklendi

hardhat config dosyasının module export kısmına
etherscan: {
apiKey: ETHERSCAN_API
}

eklendi

verify için son adım
npx hardhat verify --network mainnet DEPLOYED_CONTRACT_ADDRESS "Constructor argument 1"
bunu kendimize göre düzenliycez, constructor argumentimiz yok networkü ayarlicaz contract adresi yazıcaz

Remixten deploylanan contract hardhatten onaylandı AMA OPTIMIZER kapalıyken, optimizer açıkken dene
solidity: {
version: "0.8.4",
settings: {
optimizer: {
enabled: true,
runs: 200
}
}
},

bununla optimization açılıyor

https://docs.alchemy.com/alchemy/tutorials/hello-world-smart-contract ŞURDAN DEVAMINA BAK

---

https://github.com/HashLips/hashlips_art_engine/releases/tag/v1.1.2_patch_v6

Hashlips art engine indirildi
layerların sonuna #10 diye rarity için ekleme yapıldı
layerlar layers dosyasına kopyalandı
config.js dosyasında traitler düzenlendi

main.js dosyasında 116. satırda resolution: 300ppi eklendi

node index.js

Build dosyasına metadatalarla geliyor

---

contract deploymenttan sonra bir tane owner mint gerekiyor ondan sonra opensea sayfası gelecek
sayfayı düzenledikten sonra mint zamanı base token uri değiştirilerek minte başlanacak
