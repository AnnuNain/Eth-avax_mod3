# CustomERC20Token
This project involves creating and deploying an ERC20 token smart contract using the Remix IDE. The contract includes functions to mint, burn, and transfer tokens, each with specific permissions and conditions.

## Description
The CustomERC20Token contract allows users to interact with a custom ERC20 token. The contract owner can mint new tokens, while any user can burn or transfer tokens. The contract also imposes a cap on the total supply, ensuring that the maximum supply does not exceed 1 million tokens.

This contract has been tested and deployed using the Remix IDE, and the functionalities are explained in a Loom video.

## Getting Started
### Executing the Program
To compile and deploy the contract using Remix IDE:
1. Open Remix in your browser at remix.ethereum.org.
2. Create a new file and copy the contract code below into it.
3. Press CTRL + S to save the contract.
4. To compile, press CTRL + SHIFT + P, then select Solidity: Compile Contract.
5. Once compiled, deploy the contract to your chosen Ethereum network through Remix.

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
## Functions Overview
#### Minting Function:
Access: Owner only
Adds new tokens to a user’s balance as long as the total supply does not exceed the maximum limit.

#### Burning Function:
Access: Public
Allows any user to burn their own tokens, reducing the total supply.

#### Transfer Function:
Access: Public
Users can transfer their tokens to other addresses.

## Authors
Annu

## License
This project is licensed under the MIT License. See the LICENSE.md file for details.
