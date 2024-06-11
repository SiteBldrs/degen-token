// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {
    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {}

    struct RedeemedItem {
        string itemName;
        uint256 redeemedAt;
    }

    // mapping to store redeemed items for each user
    mapping(address => RedeemedItem[]) private redeemedItems;

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function decimals() public pure override returns (uint8) {
        return 0;
    }

    function getBalance() external view returns (uint256) {
        return balanceOf(msg.sender);
    }

    function transferTokens(address _receiver, uint256 _value) external {
        require(balanceOf(msg.sender) >= _value, "Not enough Token");
        transfer(_receiver, _value);
    }

    function burnTokens(uint256 _value) external {
        require(balanceOf(msg.sender) >= _value, "Not enough Token");
        burn(_value);
    }

    function showStoreItems() external pure returns (string memory) {
        return
            "The following items are available for purchase:\n1. Official Degen NFT - 100 Tokens\n2. Official Degen T-shirt - 75 Tokens\n3. Official Degen Sticker - 50 Tokens";
    }

    function redeemTokens(uint8 _userChoice) external returns (bool) {
        if (_userChoice == 1) {
            require(balanceOf(msg.sender) >= 100, "Not enough Token");
            transfer(owner(), 100);
            redeemedItems[msg.sender].push(
                RedeemedItem("Official Degen NFT", block.timestamp)
            );
            return true;
        } else if (_userChoice == 2) {
            require(balanceOf(msg.sender) >= 75, "Not enough Token");
            transfer(owner(), 75);
            redeemedItems[msg.sender].push(
                RedeemedItem("Official Degen T-shirt", block.timestamp)
            );
            return true;
        } else if (_userChoice == 3) {
            require(balanceOf(msg.sender) >= 50, "Not enough Token");
            transfer(owner(), 50);
            redeemedItems[msg.sender].push(
                RedeemedItem("Official Degen Sticker", block.timestamp)
            );
            return true;
        } else {
            return false;
        }
    }

    function getRedeemedItem(
        uint256 index
    ) external view returns (RedeemedItem memory item) {
        require(
            index < redeemedItems[msg.sender].length,
            "Index out of bounds"
        );
        return redeemedItems[msg.sender][index];
    }

    function getRedeemedItemsCount() external view returns (uint256) {
        return redeemedItems[msg.sender].length;
    }
}
