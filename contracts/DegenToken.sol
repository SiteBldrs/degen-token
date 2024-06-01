// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {
    constructor() ERC20("Degen", "DGN") Ownable(msg.sender){}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
    // 0xB6B0746f8137Db1E788597CFcD818e2B3bfF6324
    // 100

    function decimals() override public pure returns (uint8) {
        return 0;
    }

    function getBalance() external view returns (uint256) {
        return this.balanceOf(msg.sender);
    }

    function transferTokens(address _receiver, uint256 _value) external {
        require(balanceOf(msg.sender) >= _value, "Not enough Token");
        approve(msg.sender, _value);
        transferFrom(msg.sender, _receiver, _value);
    }

    function burnTokens(uint256 _value) external {
        require(balanceOf(msg.sender) >= _value, "Not enough Token");
        burn(_value);
    }

    function showStoreItems() external pure returns (string memory) {
        return "The following items are available for purchase:\nSelection 1. Official Degen NFT\nSelection 2. Official Degen NFT\nSelection 3. Official Degen NFT";
    }

    function redeemTokens(uint8 _userChoice) external payable returns (bool) {
        if (_userChoice == 1) {
            require(this.balanceOf(msg.sender) >= 100, "Not enough Token");
            approve(msg.sender, 100);
            transferFrom(msg.sender, owner(), 100);
            return true;
        }
        else if (_userChoice == 2) {
            require(this.balanceOf(msg.sender) >= 75, "Not enough Token");
            approve(msg.sender, 75);
            transferFrom(msg.sender, owner(), 75);
            return true;
        }
        else if (_userChoice == 3) {
            require(this.balanceOf(msg.sender) >= 50, "Not enough Token");
            approve(msg.sender, 50);
            transferFrom(msg.sender, owner(), 50);
            return true;
        }
        else {
            return false;
        }
    }
}