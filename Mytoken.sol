// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyToken {
    // Public variables
    string public tokenName = "NinjaHathori";
    string public tokenAbbrv = "NJT";
    uint256 public totalSupply = 0;

    // Mapping to track balances
    mapping(address => uint256) public balances;

    // Events for minting and burning
    event Mint(address indexed account, uint256 amount);
    event Burn(address indexed account, uint256 amount);

    // Only owner modifier
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this");
        _;
    }

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // Mint function with onlyOwner modifier
    function mint(address account, uint256 amount) public onlyOwner {
        require(account != address(0), "Invalid address");
        totalSupply += amount;
        balances[account] += amount;
        emit Mint(account, amount);
    }

    // Burn function
    function burn(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        totalSupply -= amount;
        balances[msg.sender] -= amount;
        emit Burn(msg.sender, amount);
    }

    // Transfer function
    function transfer(address to, uint256 value) public {
        require(to != address(0), "Invalid address");
        require(balances[msg.sender] >= value, "Insufficient balance");
        
        balances[msg.sender] -= value;
        balances[to] += value;

        emit Transfer(msg.sender, to, value);
    }

    // Transfer event
    event Transfer(address indexed from, address indexed to, uint256 value);
}
