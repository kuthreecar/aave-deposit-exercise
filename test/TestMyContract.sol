// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/MyContract.sol";


contract TestMyContract {
  MyContract myContract = MyContract(DeployedAddresses.MyContract());
  
  //test parameters
  address constant erc20DefaultAddress = 0x679EAE4AF989AE33c9150673422263397b63F27F;
  uint256 constant testAmount = 1 * 10 ** 18; //1 eth
  
  function testCheckCollateralValueInEth1() public {
    uint256 returned = myContract.checkCollateralValueInEth(erc20DefaultAddress);
    uint256 expected = 0;
    Assert.equal(returned, expected, "CheckCollateralValueInEth1 Fail");
  }

  function testDeposit() public {
    bool returned = myContract.deposit(erc20DefaultAddress, testAmount);
    bool expected = true;
    Assert.equal(returned, expected, "Deposit Fail");
  }

  function testCheckCollateralValueInEth2() public {
    uint256 returned = myContract.checkCollateralValueInEth(erc20DefaultAddress);
    uint256 expected = testAmount;
    Assert.equal(returned, expected, "CheckCollateralValueInEth2 Fail");
  }
  
  function testWithdraw() public {
    uint256 returned = myContract.withdraw(erc20DefaultAddress, testAmount);
    uint256 expected = testAmount;
    Assert.equal(returned, expected, "Withdraw Fail");
  }
}
