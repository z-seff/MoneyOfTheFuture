// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/presets/ERC721PresetMinterPauserAutoId.sol";

contract NFTFactory is ERC721PresetMinterPauserAutoId {

  address private _contractAddress;
  string private _baseTokenURI;

  constructor(string memory name, string memory symbol, string memory baseTokenURI, address contractAddress) ERC721(name, symbol) {
      _baseTokenURI = baseTokenURI;
      _contractAddress = contractAddress;

      _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
      _setupRole(MINTER_ROLE, _contractAddress);
      _setupRole(PAUSER_ROLE, _msgSender());
  }

  /* function mint (string memory title, string memory dates, string memory place, uint8 Id, address to) public virtual {
    require(msg.sender == trustedAddress, "You cannot mint new tickets");
  } */
}
