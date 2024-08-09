// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";

/**
 * @title OceanToken
 * @dev OceanToken is a ERC20 token that: gives rewards bases on  blocks mined
 * @notice  70% of the tokens will be saved for the company
 * @notice 30% of the tokens will be distributed to the miners
 * @notice What the is the perfect utility for a token that is not used for transactions?
 */
contract OceanToken is ERC20Capped, ERC20Burnable {
    address payable public owner;
    uint256 public blockReward;

    constructor(uint256 cap, uint256 reward) ERC20("OceanToken", "OCT") ERC20Capped(cap * (10 **decimals())) {
        owner = payable(msg.sender);
        _mint(owner, 70000000 * (10 ** decimals()));
        blockReward = reward * (10 ** decimals());
    }

    function _mintMinersReward() internal {
        _mint(block.coinbase, blockReward);
    }

    function _update(address from, address to, uint256 value) internal virtual override(ERC20Capped, ERC20){
        if(from != address(0) && to != block.coinbase && block.coinbase != address(0)){
        _mintMinersReward();
        }
        super._update(from, to, value);
    }

   function withdrawERC20(IERC20 token) public onlyOwner {
    uint256 balance = token.balanceOf(address(this));
    require(balance > 0, "No tokens to withdraw");
    
    require(token.transfer(owner, balance), "Transfer failed");
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }
}  
