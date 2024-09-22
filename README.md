# CustomERC20Token
CustomERC20Token - A simple and customizable ERC20-like token smart contract.

## Description
CustomERC20Token (MCT) is a custom ERC20 token that implements essential functionalities like minting, burning, and transferring tokens. The contract allows the owner to mint new tokens, up to a maximum supply of 1 million tokens, and lets any user burn their own tokens or transfer tokens to other addresses. This contract follows standard security practices, ensuring that only the owner can mint tokens while maintaining flexibility for users to manage their own token balances.

## Getting Started
### Installing
To compile and deploy the contract using Remix IDE:
1. Open Remix IDE in your browser: Remix.
2. Create a new file named CustomERC20Token.sol and paste the contract code.
3. Compile the contract using the Solidity Compiler plugin in Remix.
### Modifications
    _You can modify the contract in Remix by changing parameters like name, symbol, or maxSupply.
    _Ensure you adjust the environment and account settings in Remix for contract deployment.

## Smart Contract Code

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract CustomERC20Token {
    string public name = "MyCustomToken";
    string public symbol = "MCT";
    uint8 public decimals = 18;
    uint256 public totalSupply;
    address public owner;
    uint256 public maxSupply = 1000000 * (10 ** uint256(decimals)); // Max total supply is 1 million tokens

    mapping(address => uint256) public balanceOf;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Mint(address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can perform this action.");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    // Minting function: only owner can mint new tokens
    function mint(address to, uint256 amount) public onlyOwner {
        require(totalSupply + amount <= maxSupply, "Minting would exceed the max supply.");
        require(amount > 0, "Amount must be greater than zero.");
        balanceOf[to] += amount;
        totalSupply += amount;
        emit Mint(to, amount);
    }

    // Burning function: anyone can burn their own tokens
    function burn(uint256 amount) public {
        require(balanceOf[msg.sender] >= amount, "Insufficient balance to burn.");
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Burn(msg.sender, amount);
    }

    // Transfer function: anyone can transfer tokens to another address
    function transfer(address to, uint256 amount) public {
        require(balanceOf[msg.sender] >= amount, "Insufficient balance to transfer.");
        require(to != address(0), "Cannot transfer to the zero address.");
        
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
        emit Transfer(msg.sender, to, amount);
    } 
}

## Executing Program
How to Deploy the Contract:
1. In Remix IDE, go to the Deploy & Run Transactions tab.
2. Select the appropriate environment (e.g., JavaScript VM or Injected Web3 for MetaMask).
3. Click on Deploy.
How to Interact with the Contract:
1. Mint Tokens (Owner only):
   contract.mint(address, amount);
2. Burn Tokens (Anyone):
   contract.burn(amount);
3. Transfer Tokens:
   contract.transfer(to_address, amount);

## Help
If deployment issues occur, verify the environment settings in Remix.
Ensure you are using the correct account in MetaMask or the Remix VM.

## Authors
Annu

## License
This project is licensed under the MIT License. See the LICENSE.md file for details.
