const NFTFactory = artifacts.require("NFTFactory");

module.exports = function (deployer) {
  deployer.deploy(NFTFactory, "NFTFactory","NFT","http","0x636bcc830Bd8dC6437856AE05f3962Eaa1004ed1");
  // deployer.deploy("moneyofthefuture","MTF","http",0x636bcc830Bd8dC6437856AE05f3962Eaa1004ed1);
};
