// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "./RomanUser.sol";
import "./RomanToken.sol";

contract RomanVault {

    uint public totalSupply;

    mapping(address => uint) public balances;

    // init RomanUser and RomanToken contracts
    RomanUser _ru = RomanUser(0xf104e44A7d2809E877847bfcF2b9051da89109E4);
    RomanToken _rt = RomanToken(0xF4217Bc232DDE826Bf8172BDB7b5CdD21e2dddaF);

    // @dev TODO can use balanceOf function from ERC721 contract
    modifier rDidMint(address add) {
        require(_rt.didMint(add) == true, "Mint a RomaNToken first");
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
    // @dev TODO charges go to dev
    function transfer(address to, uint amount) public rDidMint(msg.sender) rDidMint(to) {
        require(balances[msg.sender] >= amount);
        uint256 charges = calculateCharge(to, amount);
        
        balances[msg.sender] -= amount;
        balances[to] = balances[to] + amount - charges;
    }


    // get user behavior
    function getBehavior(address user) public view returns (uint8) {
        return _ru.getBehavior(user);
    }

    // calculate charges for user depending on the behavior
    // @dev TODO add the amount list for each interaction example(view profile=10, message=8, comment=5, like=3,....)
    // @dev TODO add dev commission paymentSplitter
    function calculateCharge(address user, uint256 amount) internal view returns(uint256) {
        uint8 behavior = getBehavior(user);
        return amount - (amount * behavior / 100);

    }
}