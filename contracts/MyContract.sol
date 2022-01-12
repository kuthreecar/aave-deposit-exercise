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
    function checkCollateralValueInEth(address _erc20Contract) external view returns (uint256 amountInEth);
}

contract MyContractImpl is MyContract {

    LendingPoolAddressesProvider provider;
    address constant mainnetPoolProvider = 0x24a42fD28C976A61Df5D00D0599C34c4f90748c8;

    constructor () public{
        LendingPoolAddressesProvider provider = LendingPoolAddressesProvider(mainnetPoolProvider); 
    }

    function deposit(address _erc20Contract, uint256 _amount) external override returns (bool success)
    {
        // Retrieve LendingPool address
        LendingPool lendingPool = LendingPool(provider.getLendingPool());

        // Deposit 
        lendingPool.deposit(_erc20Contract, _amount, msg.sender);

        return true;
    }

    function withdraw(address _erc20Contract, uint256 _amount) external override returns (uint256 amountWithdrawn)
    {
        // Retrieve LendingPool address
        LendingPool lendingPool = LendingPool(provider.getLendingPool());

        // Withdraw
        uint256 amountWithdrawn = lendingPool.withdraw(_erc20Contract, _amount, msg.sender);

        return amountWithdrawn;
   }
   
    function checkCollateralValueInEth(address _erc20Contract) external view override returns (uint256 amountInEth)
    {
        // Retrieve LendingPool address
        LendingPool lendingPool = LendingPool(provider.getLendingPool());

        // Get Reserve Data
        uint256 amountInEth = lendingPool.totalCollateralETH(_erc20Contract);

        return amountInEth;
    }
}
