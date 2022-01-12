// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/MyContract.sol";


contract TestBuyItem {
  MyContract myContract = MyContract(DeployedAddresses.MyContract());
  
  //test parameters
  address constant erc20DefaultAddress = 0x11f4d0A3c12e86B4b5F39B213F7E19D048276DAe;
  uint256 constant testAmount = 10;
  
  function testDeposit() public {
    bool returned = myContract.deposit(erc20DefaultAddress, testAmount);
    bool expected = true;
    Assert.equal(returned, expected, "Deposit Fail");
  }

  function testCheckCollateralValueInEth() public {
    uint256 returned = myContract.checkCollateralValueInEth(erc20DefaultAddress);
    uint256 expected = testAmount;
    Assert.equal(returned, expected, "CheckCollateralValueInEth Fail");
  }
  
  function testWithdraw() public {
    uint256 returned = myContract.withdraw(erc20DefaultAddress, testAmount);
    uint256 expected = testAmount;
    Assert.equal(returned, expected, "Withdraw Fail");
  }
}
