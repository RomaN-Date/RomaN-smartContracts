const RomanToken = artifacts.require("RomanToken");

module.exports = function (deployer) {
  deployer.deploy(RomanToken);
};
