pragma solidity ^0.5.16;

import "./AToken.sol";
import "./PriceOracle.sol";

contract UnitrollerAdminStorage {
    /**
    * @notice Administrator for this contract
    */
    address public admin;

    /**
    * @notice Pending administrator for this contract
    */
    address public pendingAdmin;

    /**
    * @notice Active brains of Unitroller
    */
    address public comptrollerImplementation;

    /**
    * @notice Pending brains of Unitroller
    */
    address public pendingComptrollerImplementation;
}

contract ComptrollerStorage is UnitrollerAdminStorage {

    /**
     * @notice Oracle which gives the price of any given asset
     */
    PriceOracle public oracle;

    /**
     * @notice Multiplier used to calculate the maximum repayAmount when liquidating a borrow
     */
    uint public closeFactorMantissa;

    /**
     * @notice Multiplier representing the discount on collateral that a liquidator receives
     */
    uint public liquidationIncentiveMantissa;

    /**
     * @notice Max number of assets a single account can participate in (borrow or use as collateral)
     */
    uint public maxAssets;

    /**
     * @notice Per-account mapping of "assets you are in", capped by maxAssets
     */
    mapping(address => AToken[]) public accountAssets;

    struct Market {
        /// @notice Whether or not this market is listed
        bool isListed;

        /**
         * @notice Multiplier representing the most one can borrow against their collateral in this market.
         *  For instance, 0.9 to allow borrowing 90% of collateral value.
         *  Must be between 0 and 1, and stored as a mantissa.
         */
        uint collateralFactorMantissa;

        /// @notice Per-market mapping of "accounts in this asset"
        mapping(address => bool) accountMembership;

        /// @notice Whether or not this market receives Atlantis
        bool isAtled;
    }

    /**
     * @notice Official mapping of aTokens -> Market metadata
     * @dev Used e.g. to determine if a market is supported
     */
    mapping(address => Market) public markets;


    /**
     * @notice The Pause Guardian can pause certain actions as a safety mechanism.
     *  Actions which allow users to remove their own assets cannot be paused.
     *  Liquidation / seizing / transfer can only be paused globally, not by market.
     */
    address public pauseGuardian;
    bool public _mintGuardianPaused;
    bool public _borrowGuardianPaused;
    bool public transferGuardianPaused;
    bool public seizeGuardianPaused;
    mapping(address => bool) public mintGuardianPaused;
    mapping(address => bool) public borrowGuardianPaused;

    struct AtlantisMarketState {
        /// @notice The market's last updated atlantisBorrowIndex or atlantisSupplyIndex
        uint224 index;

        /// @notice The block number the index was last updated at
        uint32 block;
    }

    /// @notice A list of all markets
    AToken[] public allMarkets;

    /// @notice The rate at which the flywheel distributes Atlantis, per block
    uint public atlantisRate;

    /// @notice The portion of atlantisRate that each market currently receives
    mapping(address => uint) public atlantisSpeeds;

    /// @notice The Atlantis market supply state for each market
    mapping(address => AtlantisMarketState) public atlantisSupplyState;

    /// @notice The Atlantis market borrow state for each market
    mapping(address => AtlantisMarketState) public atlantisBorrowState;

    /// @notice The Atlantis borrow index for each market for each supplier as of the last time they accrued Atlantis
    mapping(address => mapping(address => uint)) public atlantisSupplierIndex;

    /// @notice The Atlantis borrow index for each market for each borrower as of the last time they accrued Atlantis
    mapping(address => mapping(address => uint)) public atlantisBorrowerIndex;

    /// @notice The Atlantis accrued but not yet transferred to each user
    mapping(address => uint) public atlantisAccrued;

    /// @notice Atlantis token contract address
    address public atlantisAddress;

     // @notice The borrowCapGuardian can set borrowCaps to any number for any market. Lowering the borrow cap could disable borrowing on the given market.
    address public borrowCapGuardian;

    // @notice Borrow caps enforced by borrowAllowed for each aToken address. Defaults to zero which corresponds to unlimited borrowing.
    mapping(address => uint) public borrowCaps;

    /// @notice The portion of Atlantis that each contributor receives per block
    mapping(address => uint) public atlantisContributorSpeeds;

    /// @notice Last block at which a contributor's Atlantis rewards have been allocated
    mapping(address => uint) public lastContributorBlock;
}


contract ComptrollerV1Storage is ComptrollerStorage {
    // @notice The rate at which atlantis is distributed to the corresponding borrow market (per block)
    mapping(address => uint) public atlantisBorrowSpeeds;

    /// @notice The rate at which atlantis is distributed to the corresponding supply market (per block)
    mapping(address => uint) public atlantisSupplySpeeds;
}