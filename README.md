# PlainVanillaBond Smart Contract

The VanillaBond smart contract is a basic implementation of a bond tokenization system on the Ethereum blockchain. It allows users to invest in a bond and receive coupon payments and principal repayment based on the specified terms.

## Features

- Whitelist: Only whitelisted investors can invest in the bond.
- KYC Approval: Investors need to go through a KYC (Know Your Customer) procedure and get approval to invest.
- High-Risk Customer Restriction: High-risk customers are not allowed to invest.
- Coupon Payments: Periodic coupon payments are made to investors based on the bond's coupon rate and frequency.
- Principal Repayment: At maturity, the principal amount is repaid to the investors.
- Settlement: Investors can settle the bond to receive both the coupon payments and the principal amount.

## Contract Structure

The contract is structured as follows:

- `PlainVanillaBond.sol`: This is the main contract that implements the bond tokenization system. It includes functions for adding/removing investors to/from the whitelist, KYC approval/rejection, handling investments, coupon payments, principal repayment, and bond settlement.

- `MyToken.sol`: This is a basic ERC-20 token contract used as the underlying token for the bond. It provides the standard token functionalities such as transfer, approve, and allowance.

## Usage

1. Deploy the `PlainVanillaBond` contract on the Ethereum network.
2. Deploy the `MyToken` contract or provide the address of an existing ERC-20 token contract to use as the bond's underlying token.
3. Configure the bond parameters such as coupon rate, maturity, and coupon frequency in the `PlainVanillaBond` constructor.
4. Add investors to the whitelist and approve their KYC.
5. Investors can then invest in the bond by calling the `invest` function, providing the desired investment amount.
6. The bond contract will handle the transfer of tokens from the investor to the contract and update the invested amount for the investor.
7. Periodic coupon payments will be made to the investors based on the coupon rate and frequency.
8. At bond maturity, the principal amount will be repaid to the investors.
9. Investors can settle the bond to receive both the coupon payments and the principal amount.

## Development

To set up the development environment and run tests:

1. Install the required dependencies using `npm install`.
2. Run the tests using `npm test`.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
