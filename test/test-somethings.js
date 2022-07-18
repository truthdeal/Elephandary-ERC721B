const API_URL = "HTTP://127.0.0.1:7545";
const PUBLIC_KEY = "0x19B97Aa71D5569C9796598d572Dde641cb3e2B1c";
const PRIVATE_KEY = "f0f3de945f8ec29be79b977fc8d937954bbeab0c4b00bf64e001dbbc4f235e7f";

const Web3 = require('web3') ;

const web3 = new Web3(API_URL) ;

const contract = require("../artifacts/contracts/Elephandary.sol/Elephandary.json");

const contractAddress = "0x948f023Ec5742bA7E45bF3b8f0965f128e83E5C0";
const nftContract = new web3.eth.Contract(contract.abi, contractAddress);

async function publicmint(tokenCount) {
    
    const nonce = await web3.eth.getTransactionCount(PUBLIC_KEY, 'latest'); //get latest nonce
    //the transaction
    const tx = {
      'from': PUBLIC_KEY,
      'to': contractAddress,
      'nonce': nonce ,
      'gas': 130000,
      'maxPriorityFeePerGas': 51000000000,
      'data': nftContract.methods.publicMint(tokenCount).encodeABI()
    };
    
console.log("Before sending tx") ;

    const signedTx = await web3.eth.accounts.signTransaction(tx, PRIVATE_KEY);

console.log("After signing.") ;

    const transactionReceipt = await web3.eth.sendSignedTransaction(signedTx.rawTransaction);

    console.log("after sending tx") ;

    }

publicmint(5) ;