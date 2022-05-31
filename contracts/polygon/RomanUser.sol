// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts/utils/Counters.sol";

contract RomanUser {

    using Counters for Counters.Counter;
    
    // user structure
    struct User {
        address userId;
        uint256 nftId;
        uint8 behavior; // 100% for all users --> decrement by 1% for each time the user is blcoked 
    }

    // mapping all users --> get address by tokenId
    mapping(uint => User) public allUsers; // todo change var name to allTokens

    //mapping users add by nftid
    mapping (address => uint256) public allAdd;

    // mapping behaviror by address
    mapping (address => uint8) public userBeh;

    // init counter
    Counters.Counter public allUsersCounter; // todo increment by 1 so user1 --> nft1

    // create a new user
    function createUser(address userId, uint256 nftId) external {
        User memory user = User({
            userId: userId,
            nftId: nftId,
            behavior: 100
        });

        allAdd[userId] = nftId;
        userBeh[userId] = 100;
        allUsers[allUsersCounter.current()] = user;
        allUsersCounter.increment();
    }

    //  delete user
    function removeUser(uint256 nftId) external {
        require(msg.sender == allUsers[nftId].userId, "you are not the owner of this token");
        delete allUsers[nftId];
    }

    // get all users
    function getAllUsers() public view returns (User[] memory) {
      User[] memory data = new User[](allUsersCounter.current());
      for (uint i = 0; i < allUsersCounter.current(); i++) {
          User memory user = allUsers[i];
          data[i] = user;
      }
      return data;
    }

    // get User by tokenId
    function getUser(uint256 nftID) public view returns(User memory) {
    return allUsers[nftID];
    }


    function blockUser(uint256 _from, uint256 _to) public {
        require(allUsers[_from].userId == msg.sender, "sender is not msg.sender"); // **** TODO modifier
        require(allUsers[_from].nftId != 0 , "Mint a RomanToken first");
        require(allUsers[_to].userId != msg.sender, "why you are blocking yourself.. !!?" );
        
        // @DEV IMPORTANT SECURITY ISSUE ATTENTION underflow
        allUsers[_to].behavior -= 1;     
    }

    function unblockUser(uint256 _from, uint256 _to) public {
        // require from blocked to

        // require from == msg.sender
        require(allUsers[_from].userId == msg.sender, "sender is not msg.sender"); // **** TODO modifier

        // overflow
        allUsers[_to].behavior += 1;
    }

    // get nftid user by address
    function getTokenIdByAddress(address add) external view returns(uint256) {
                return allAdd[add];
        }

    // get user behavior
    // @dev TODO return 0
    function getBehavior(address add) external view returns(uint8) {
        return userBeh[add];

    }
}