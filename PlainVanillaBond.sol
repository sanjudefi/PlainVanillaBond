// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./MyToken.sol";

contract PlainVanillaBond {
    struct Bond {
        uint256 couponRate;
        uint256 maturity;
        uint256 couponFrequency;
        address issuer;
        mapping(address => bool) whitelist;
        mapping(address => bool) kycApproved;
        mapping(address => bool) highRiskCustomers;
        mapping(address => uint256) couponPayments;
        mapping(address => uint256) investedAmounts;
    }

    Bond public bond;
    MyToken public bondToken;

    constructor(address tokenAddress) {
        bond.couponRate = 5; // 5% coupon rate
        bond.maturity = block.timestamp + 10 minutes; // Maturity in 10 minutes
        bond.couponFrequency = 10 minutes; // Coupon payment every 10 minutes
        bond.issuer = msg.sender; // Issuer's address
        bondToken = MyToken(tokenAddress);
    }

    modifier onlyWhitelisted() {
        require(bond.whitelist[msg.sender], "Only whitelisted investors can perform this action.");
        require(bond.kycApproved[msg.sender], "KYC not approved.");
        require(!bond.highRiskCustomers[msg.sender], "High-risk customers are not allowed.");
        _;
    }

    function addToWhitelist(address investor) external {
        require(msg.sender == bond.issuer, "Only the issuer can add investors to the whitelist.");
        bond.whitelist[investor] = true;
    }

    function removeFromWhitelist(address investor) external {
        require(msg.sender == bond.issuer, "Only the issuer can remove investors from the whitelist.");
        bond.whitelist[investor] = false;
    }

    function approveKYC(address investor) external {
        require(msg.sender == bond.issuer, "Only the issuer can approve KYC.");
        bond.kycApproved[investor] = true;
    }

    function rejectKYC(address investor) external {
        require(msg.sender == bond.issuer, "Only the issuer can reject KYC.");
        bond.kycApproved[investor] = false;
    }

    function addHighRiskCustomer(address customer) external {
        require(msg.sender == bond.issuer, "Only the issuer can add high-risk customers.");
        bond.highRiskCustomers[customer] = true;
    }

    function removeHighRiskCustomer(address customer) external {
        require(msg.sender == bond.issuer, "Only the issuer can remove high-risk customers.");
        bond.highRiskCustomers[customer] = false;
    }



    function invest(uint256 amount) external onlyWhitelisted {
        require(amount > 0, "Investment amount must be greater than zero.");

        // Check investor's token balance
        uint256 tokenBalance = bondToken.balanceOf(msg.sender);
        require(tokenBalance >= amount, "Insufficient token balance.");

        // Approve the transfer from the investor's address to the contract address
        bool approvalSuccess = bondToken.approve(address(this), amount);
        require(approvalSuccess, "Token transfer approval failed.");

        // Transfer the tokens from the investor to the contract
        bool transferSuccess = bondToken.transferFrom(msg.sender, address(this), amount);
        require(transferSuccess, "Token transfer failed.");

        // Update the invested amount for the investor
        bond.investedAmounts[msg.sender] += amount;
    }


    function getInvestedAmount(address investor) external view returns (uint256) {
        return bond.investedAmounts[investor];
    }
    function payCoupon() external onlyWhitelisted {
        require(block.timestamp < bond.maturity, "Bond has already matured.");
        require(block.timestamp % bond.couponFrequency == 0, "Not a coupon payment date.");

        // Perform coupon payment logic here
        uint256 couponAmount = (bond.investedAmounts[msg.sender] * bond.couponRate) / 100;
        require(couponAmount > 0, "Coupon amount is zero.");

        // Update coupon payment for the investor
        bond.couponPayments[msg.sender] += couponAmount;
    }

    function repayPrincipal() external onlyWhitelisted {
        require(block.timestamp >= bond.maturity, "Bond has not yet matured.");

        // Perform principal repayment logic here
        uint256 principalAmount = bond.investedAmounts[msg.sender];
        require(principalAmount > 0, "Principal amount is zero.");

        // Transfer the principal amount to the investor
        bondToken.transfer(msg.sender, principalAmount);

        // Reset invested amount and coupon payment for the investor
        bond.investedAmounts[msg.sender] = 0;
        bond.couponPayments[msg.sender] = 0;
    }

   function settleBond() external onlyWhitelisted {
    require(block.timestamp >= bond.maturity, "Bond has not yet matured.");

    // Perform settlement logic here
    uint256 couponPayment = (bond.investedAmounts[msg.sender] * bond.couponRate) / 100;
    uint256 principalAmount = bond.investedAmounts[msg.sender];

    require(couponPayment + principalAmount > 0, "No funds available for settlement.");

    // Transfer the coupon payment and principal amount to the investor
    bondToken.transfer(msg.sender, couponPayment + principalAmount);

    // Reset invested amount and coupon payment for the investor
    bond.investedAmounts[msg.sender] = 0;
    bond.couponPayments[msg.sender] = 0;
    }
}
