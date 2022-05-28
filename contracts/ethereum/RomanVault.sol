// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "./RomanToken.sol";

contract RomanVault {


    uint public totalSupply;
    mapping(address => uint) public balances;

    // init RomanToken contract
    // @dev TODO add the correct contract adderess after deploy
    address _rAdd = 0x358AA13c52544ECCEF6B0ADD0f801012ADAD5eE3;
    RomanToken _r = RomanToken(_rAdd);

    
    modifier rDidMint(address add) {
        require(_r.didMint(add) == true, "Mint a RomaNToken first");
        _;
    }

    // deposit function
    function deposit() public payable rDidMint(msg.sender) {
        require(msg.value >= 1, "deposit must be greater than 1");	
        balances[msg.sender] += msg.value;
        totalSupply += msg.value;
    }

    // withdraw function
    function withdraw(uint _amount) public payable {
        require(balances[msg.sender] >= _amount);
        balances[msg.sender] -= _amount;
        totalSupply -= _amount;
        payable(msg.sender).transfer(_amount);
    }

    // transfer function
    // @dev TODO add the behavior of the user and commission
    function transfer(address _to, uint _amount) public rDidMint(msg.sender) rDidMint(_to) {
        require(balances[msg.sender] >= _amount);
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
    }
}