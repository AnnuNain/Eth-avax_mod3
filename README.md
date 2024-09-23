# EventParticipationToken (EPT)
EventParticipationToken (EPT) - A customizable token smart contract designed to manage event participation and reward systems.

## Description
EventParticipationToken (EPT) is a custom token contract deployed on the Avalanche network. It enables event organizers to mint tokens as rewards for participants, allows participants to transfer, redeem, and burn their tokens, and provides security features such as restricting minting to the contract owner. The contract includes redeemable event tiers, offering a gamified reward system where participants can unlock specific benefits based on token levels.

## Getting Started
### Installing
To compile and deploy the contract using Remix IDE:
1. Open Remix IDE in your browser.
2. reate a new file named EventParticipationToken.sol and paste the contract code below.
3. Compile the contract using the Solidity Compiler plugin in Remix.

### Modifications
You can modify the contract in the Remix IDE by adjusting parameters like the event tiers or reward conditions. Ensure to select the appropriate environment and account settings in Remix for contract deployment.

## Smart Contract Code

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
contract EventParticipationToken {
    string public name = "EventParticipation";
    string public symbol = "EPT";
    uint256 public totalSupply;
    address public organizer;

    mapping(address => uint256) public balances;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Mint(address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);

    modifier onlyOrganizer() {
        require(msg.sender == organizer, "Only the organizer can perform this action.");
        _;
    }

    constructor() {
        organizer = msg.sender;
    }

    // Mint new tokens (Only the organizer can mint)
    function mint(address to, uint256 amount) public onlyOrganizer {
        require(amount > 0, "Amount must be greater than zero.");
        balances[to] += amount;
        totalSupply += amount;
        emit Mint(to, amount);
    }

    // Burn tokens (Anyone can burn their tokens)
    function burn(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance to burn.");
        balances[msg.sender] -= amount;
        totalSupply -= amount;
        emit Burn(msg.sender, amount);
    }

    // Transfer tokens (Anyone can transfer)
    function transfer(address to, uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance to transfer.");
        require(to != address(0), "Cannot transfer to the zero address.");
        balances[msg.sender] -= amount;
        balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
    }

    // Redeem tokens for event tiers (Different reward levels)
    function redeem(uint256 amount, uint8 tier) public {
        require(balances[msg.sender] >= amount, "Insufficient tokens to redeem.");
        
        if (tier == 1) {
            require(amount >= 10, "Tier 1 requires at least 10 tokens.");
            burn(amount);
        } else if (tier == 2) {
            require(amount >= 50, "Tier 2 requires at least 50 tokens.");
            burn(amount);
        } else if (tier == 3) {
            require(amount >= 100, "Tier 3 requires at least 100 tokens.");
            burn(amount);
        } else {
            revert("Invalid event tier.");
        }
    }
}


## Executing Program
###### How to Deploy the Contract:
1.In Remix IDE, go to the Deploy & Run Transactions tab.
2. Select Injected Web3 as the environment if you are using MetaMask.
3. Connect your MetaMask to the Avalanche Fuji Testnet.
4. Click on Deploy to deploy the contract.   
###### How to Interact with the Contract:
1. Mint Tokens (Organizer only):
   contract.mint(address, amount);
2. Burn Tokens (Anyone):
   contract.burn(amount);
3. Transfer Tokens:
   contract.transfer(to_address, amount);
4. Redeem Tokens for Event Tiers:
   contract.redeem(amount, tier);

## Help
If you encounter issues during deployment, verify the environment settings in Remix. Ensure you are using the correct account in MetaMask and that it is connected to the Avalanche Fuji Testnet.

## Authors
Annu

## License
This project is licensed under the MIT License. See the LICENSE.md file for details
