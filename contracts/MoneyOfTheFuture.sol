// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";
/* import "@openzeppelin/contracts/utils/math/SafeMath.sol"; */
import "@openzeppelin/contracts/utils/Counters.sol";
import "./NFTFactory.sol";
import "./PriceConsumerV3.sol";

contract MoneyOfTheFuture is Ownable,NFTFactory,PriceConsumerV3 {
  /* using SafeMath for int256;
  using SafeMath for uint256; */
  using Counters for Counters.Counter;

  // Token address on NFT factory
  address public nftTokenAddress;

  // Permanent data for of conference
  string constant title = "Money of the future";
  string constant dates = "25.09.2021 - 26.09.2021";
  string constant place = "Vinnytsia, Ukraine";

  // Ticket's prices
  int public userPrice = 100000000000;
  int public userVipPrice = 300000000000;
  int public userAfterPartyPrice = 150000000000;
  int private priceUsdinUahRate = 27;

  // Functions
  function setNFTTokenAddressFactory (address _nftTokenAddress) onlyOwner public {
    nftTokenAddress = _nftTokenAddress;
  }

  // Price functions
  function setPriceEthUsdRate (int _priceUsdinUahRate) onlyOwner public {
      priceUsdinUahRate = _priceUsdinUahRate;
  }

  function _getuserPrice() internal virtual returns (int) {
    int priceEthInUSD = PriceConsumerV3.getThePrice();
    int priceEthInUAH = priceEthInUSD * priceUsdinUahRate;
    int ticketPrice = userPrice / priceEthInUAH;
    return ticketPrice;
  }

  function _getuserVipPrice() internal virtual returns (int) {
    int priceEthInUSD = PriceConsumerV3.getThePrice();
    int priceEthInUAH = priceEthInUSD * priceUsdinUahRate;
    int ticketPrice = userVipPrice / priceEthInUAH;
    return ticketPrice;
  }

  function _getuserAfterPartyPrice() internal virtual returns (int) {
    int priceEthInUSD = PriceConsumerV3.getThePrice();
    int priceEthInUAH = priceEthInUSD * priceUsdinUahRate;
    int ticketPrice = userAfterPartyPrice / priceEthInUAH;
    return ticketPrice;
  }

  // Purchase functions
  function buyTicketToTheConferenceAsUser () public payable returns (uint) {
    int price = _getuserPrice();
    require(msg.sender != address(0), "Address cannot be empty");
    require (int(msg.value) == price,"Amount is not correct");
    NFTFactory(nftTokenAddress).mint(title,dates,place,_msgSender());
    uint tokenId = _tokenIdTracker.current()-1;
    return tokenId;
 }

 function buyTicketToTheConferenceAsUserVip () public payable returns(uint) {
   int price = _getuserPrice();
   require(msg.sender != address(0), "Address cannot be empty");
   require (int(msg.value) == price,"Amount is not correct");
   NFTFactory(nftTokenAddress).mint(title,dates,place,_msgSender());
   uint tokenId = _tokenIdTracker.current()-1;
   return tokenId;
 }

 function buyTicketToTheConferenceAsUserAfterParty () public payable returns(uint) {
   int price = _getuserPrice();
   require(msg.sender != address(0), "Address cannot be empty");
   require (int(msg.value) == price,"Amount is not correct");
   NFTFactory(nftTokenAddress).mint(title,dates,place,_msgSender());
   uint tokenId = _tokenIdTracker.current()-1;
   return tokenId;
 }
}
