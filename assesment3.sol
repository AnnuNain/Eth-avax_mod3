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
