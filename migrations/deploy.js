const RomanUser = artifacts.require("RomanUser");
const RomanToken = artifacts.require("RomanToken");
const RomanVault = artifacts.require("RomanVault");


module.exports = function (deployer) {
  deployer.deploy(RomanUser);
  deployer.deploy(RomanToken);
  deployer.deploy(RomanVault);
};
