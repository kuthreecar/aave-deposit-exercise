pragma solidity >=0.4.22 <0.9.0;

// Import interface for ERC20 standard
import "openzeppelin-solidity/contracts/token/ERC20/IERC20.sol";
import {ILendingPool} from "@aave/protocol-v2/contracts/interfaces/ILendingPool.sol";

interface MyContract {

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
    function checkCollateralValueInEth() external view returns (uint256 amountInEth);
}

contract MyContract1 is MyContract {

    LendingPoolAddressesProvider provider;
    address mainnetPoolProvider = 0x24a42fD28C976A61Df5D00D0599C34c4f90748c8;
    address reserveAddress;

    constructor () public{
        LendingPoolAddressesProvider provider = LendingPoolAddressesProvider(mainnetPoolProvider); 
    }

    function deposit(address _erc20Contract, uint256 _amount) external override returns (bool success)
    {
        // Retrieve LendingPool address
        LendingPool lendingPool = LendingPool(provider.getLendingPool());

        // Input variables
        uint16 referral = 0;

        // Deposit 
        lendingPool.deposit(_erc20Contract, _amount, referral);

        return true;
    }

    function withdraw(address _erc20Contract, uint256 _amount) external override returns (uint256 amountWithdrawn)
    {
        /// Retrieve LendingPool address
        LendingPool lendingPool = LendingPool(provider.getLendingPool());

        /// If repaying own loan
        lendingPool.repay(daiAddress, amount, msg.sender);

        /// If repaying on behalf of someone else
        address userAddress = _erc20Contract;
        IERC20(daiAddress).approve(provider.getLendingPoolCore(), _amount); // Approve LendingPool contract
        lendingPool.repay(daiAddres, amount, userAddress);

        return 0;
   }
   
    function checkCollateralValueInEth() external view override returns (uint256 amountInEth)
    {
        LendingPool lendingPool = LendingPool(provider.getLendingPool());
        uint256 amountInEth = lendingPool.getReserveData(reserveAddress).totalLiquidity;
        return amountInEth;
    }
}

