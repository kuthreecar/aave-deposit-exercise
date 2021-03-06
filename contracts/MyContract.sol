// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

// Import interface for ERC20 standard
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ILendingPool} from "@aave/protocol-v2/contracts/interfaces/ILendingPool.sol";
import {ILendingPoolAddressesProvider} from "@aave/protocol-v2/contracts/interfaces/ILendingPoolAddressesProvider.sol";

interface IMyContract {

    /// @dev Deposit ERC20 tokens on behalf of msg.sender to Aave Protocol
    /// @param _erc20Contract The address fo the underlying asset to deposit to Aave Protocol v2
    /// @param _amount The amount of the underlying asset to deposit
    /// @return success Whether the deposit operation was successful or not
    function deposit(address _erc20Contract, uint256 _amount) external returns (bool success);

    /// @dev Withdraw ERC20 tokens on behalf of msg.sender from Aave Protocol
    /// @param _erc20Contract The address of the underlyng asset being withdrawn
    /// @param _amount The amount to be withdrawn
    /// @return amountWithdrawn The actual amount withdrawn from Aave
    function withdraw(address _erc20Contract, uint256 _amount) external returns (uint256 amountWithdrawn);

    /// @dev Read only function 
    /// @return amountInEth Returns the value locked as collateral posted by msg.sender
    function checkCollateralValueInEth(address _erc20Contract) external view returns (uint256 amountInEth);
}

contract MyContract is IMyContract {

    address constant pool = 0x7d2768dE32b0b80b7a3454c06BdAc94A69DDc7A9;

    function deposit(address _erc20Contract, uint256 _amount) external override returns (bool success)
    {
        // Retrieve LendingPool address
        ILendingPool lendingPool = ILendingPool(pool);

        // Input variables
        address daiAddress = address(0x6B175474E89094C44Da98b954EedeAC495271d0F); // mainnet DAI
        uint256 amount = 1000 * 1e18;
        //address onBehalfOf = msg.sender;
        address onBehalfOf = _erc20Contract;
        uint16 referral = 0;

        IERC20 dai = IERC20(daiAddress);

        dai.approve(address(lendingPool), _amount);

        //lendingPool.deposit(daiAddress, _amount, msg.sender, 0);
        lendingPool.deposit(daiAddress, _amount, onBehalfOf, 0);

        return true;
    }

    function withdraw(address _erc20Contract, uint256 _amount) external override returns (uint256 amountWithdrawn)
    {
        // Retrieve LendingPool address
        //LendingPool lendingPool = LendingPool(provider.getLendingPool());

        // Withdraw
        return ILendingPool(pool).withdraw(_erc20Contract, _amount, msg.sender);
   }
   
    function checkCollateralValueInEth(address _erc20Contract) external view override returns (uint256 amountInEth)
    {
        // Retrieve LendingPool address
        //LendingPool lendingPool = LendingPool(provider.getLendingPool());

        // Get Reserve Data
        (uint256 totalCollateralETH,,,,,) = ILendingPool(pool).getUserAccountData(_erc20Contract);
        return totalCollateralETH;
    }
    
}
