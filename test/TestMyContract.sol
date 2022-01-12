pragma solidity >=0.4.22 <0.9.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/MyContract.sol";


contract TestBuyItem {
  MyContract myContract = MyContract(DeployedAddresses.MyContract());
  
  //test parameters
  address constant erc20DefaultAddress = 0x11f4d0A3c12e86B4b5F39B213F7E19D048276DAe
  uint256 constant testAmount = 10;
  
  function testDeposit() public {
    bool returned = myContract.checkValidItem(erc20DefaultAddress, amount);
    bool expected = true;
    Assert.equal(returned, expected, "CheckValidItem Fail");
  }

  function testCheckCollateralValueInEth() public {
    uint256 returned = myContract.checkCollateralValueInEth();
    uint256 expected = testAmount;
    Assert.equal(returned, expected, "CheckValidItem Fail");
  }
  
  function testWithdraw() public {
    uint256 returned = myContract.checkValidItem(erc20DefaultAddress, amount);
    uint256 expected = true;
    Assert.equal(returned, expected, "CheckValidItem Fail");
  }
}
