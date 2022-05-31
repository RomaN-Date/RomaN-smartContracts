const RomanToken = artifacts.require("../contracts/ethereum/RomanToken.sol");

contract("RomanToken", accounts => {
  it("...should mint a token only once.", async () => {
    const romanTokenInstance = await RomanToken.deployed();

    // mint a token
    await romanTokenInstance.safeMint(accounts[0]);

    // Get balance of account[0]
    const balanceOf = await romanTokenInstance.balanceof(accounts[0]);

    assert.equal(balanceOf, 1, "address can mint more than one nft.");
  });

  
  it("should not transfer token,", async() => {
    const romanTokenInstance = await RomanToken.deployed();
    // user0 mint a token
    await romanTokenInstance.safeMint(accounts[0]);
    // user0 transfer token to user1
    await romanTokenInstance.transferFrom(accounts[0], accounts[1], 1);
    // get balance of user1
    const balanceOf = await romanTokenInstance.balanceof(accounts[1]);

    assert.equal(balanceOf, 0, "can transfer nft ownership");
  })
});
