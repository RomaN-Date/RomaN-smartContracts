// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "./RomanToken.sol";

contract RomanVault {


    uint public totalSupply;
    mapping(address => uint) public balances;

     // init RomanToken contract
    // @dev TODO add the correct contract adderess after deploy
    address _rAdd = 0xd9145CCE52D386f254917e481eB44e9943F39138;
    RomanToken _r = RomanToken(_rAdd);

    
    modifier rDidMint() {
        require(_r.didMint(msg.sender) == true, "Mint a RomaNToken first");
        _;
    }

    // deposit function
    function deposit() public payable rDidMint() {
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
    function transfer(address _to, uint _amount) public {
        require(balances[msg.sender] >= _amount);
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
    }
}