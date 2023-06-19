## PlainVanillaBond Contract Functions

1. `constructor()`: Initializes the bond struct with the specified values for principal, couponRate, maturity, couponFrequency, and issuer. It adds the deployer of the contract as the initial owner.

2. `addToWhitelist(address investor)`: Adds an investor to the whitelist. Only investors in the whitelist can perform certain actions. It checks if the caller is an owner and adds the investor to the whitelist.

3. `removeFromWhitelist(address investor)`: Removes an investor from the whitelist. It verifies that the caller is an owner and removes the investor from the whitelist.

4. `approveKYC(address investor)`: Approves the KYC status of an investor. It verifies that the caller is an owner and approves the KYC status for the investor.

5. `rejectKYC(address investor)`: Rejects the KYC status of an investor. It checks if the caller is an owner and rejects the KYC status for the investor.

6. `addHighRiskCustomer(address customer)`: Adds a customer to the list of high-risk customers. It verifies that the caller is an owner and adds the customer to the list.

7. `removeHighRiskCustomer(address customer)`: Removes a customer from the list of high-risk customers. It checks if the caller is an owner and removes the customer from the list.

8. `payCoupon()`: Allows whitelisted investors to pay the coupon amount. It verifies that the bond has not yet matured and that the current timestamp is a valid coupon payment date. If the conditions are met, the function calculates the coupon amount and updates the couponPayments mapping.

9. `repayPrincipal()`: Allows whitelisted investors to repay the principal amount. It verifies that the bond has matured and checks if the principal amount is greater than zero. If the conditions are met, the function transfers the principal amount to the investor.

10. `settleBond()`: Allows whitelisted investors to settle the bond by claiming the coupon payment and principal amount. It verifies that the bond has matured and checks if the total payment is less than or equal to the contract balance. If the conditions are met, the function transfers the total payment to the investor and resets the couponPayments mapping.

11. `addOwner(address newOwner)`: Allows existing owners to add a new owner to the bond contract. It checks if the caller is an existing owner and adds the new owner's address to the owners array.

12. `removeOwner(address ownerToRemove)`: Allows existing owners to remove an owner from the bond contract. It verifies that the caller is an existing owner and removes the specified owner from the owners array.

13. `isOwner(address account)`: Internal function to check if the specified address is an owner. It iterates through the owners array and compares each address. If the address is found, it returns true; otherwise, it returns false.

These functions provide various functionalities related to managing the whitelist, KYC status, high-risk customers, coupon payments, principal repayment, bond settlement, and ownership of the bond contract.
