// const RomanUser = artifacts.require("RomanUser");
const RomanToken = artifacts.require("RomanToken");
// const RomanVault = artifacts.require("RomanVault");

// @dev can't read from other contract when init in constructor
// module.exports = async function(deployer) {
//   await deployer.deploy(RomanUser);
//   await deployer.deploy(RomanToken, RomanUser.address);
//   await deployer.deploy(RomanVault, RomanUser.address, RomanToken.address);
// };

module.exports =  function(deployer) {
  // deployer.deploy(RomanUser);
  deployer.deploy(RomanToken);
  // deployer.deploy(RomanVault);
};