# LoanDAO

Decentralizing the future of loans. 

In the world of decentralized finance, the ability for startups and projects to access capital required to grow their business is important. Smart contracts, which allow for the automated transfer of funds and the enforcement of pre-defined agreements between parties, are one popular way for organizations to do so. LoanDAO is a Clarity smart contract that allows Decentralized Autonomous Organizations (DAOs) to provide loans to startups that must be repaid in Stacks or Bitcoin (which can be sBTC when live) every 30 days. LoanDAO is an open source glimpse of what is possible with Stacks as we believe that it can be used to power decentralized loans in the future. LoanDAO allows for the following: 

+ The startup can set collateral that will be held until the loan is fully repaid by sending a transaction to the contract.

+ The startup can initiate a loan by sending a transaction with the requested loan amount, interest rate, and repayment period.

+ DAO members can approve the loan by sending a transaction with a pre-specified approval amount, which is added to the total approved amount of the loan.

+ The startup can withdraw the loan once it has been fully approved by sending a transaction for the full amount approved.

+ The startup can repay the loan every 30 days by sending a transaction containing the specified repayment amount and either Stacks or Bitcoin.

+ Once the loan has been fully repaid, the collateral will be returned to the startup.

+ DAO members can withdraw their share of the DAO's interest earned over the life of the loan by sending a transaction to the contract.

+ The smart contract includes functions for managing DAO membership, such as adding and removing members and calculating the DAO's total interest earned.

Overall, this smart contract enables DAOs to provide loans to startups with the security of collateral and regular repayments, while also allowing DAO members to earn interest on their investment. It is important to note that LoanDAO smart contract has not been audited, the legal implications have not been explored prior to the publishing of this open source Clarity smart contract and the potential tax implications of LoanDAO may carry varying outputs of fiscal responisbility in various jurisdictions around the world. Use at your own risk. 

NoCodeClarity believes in the power of Bitcoin and Stacks so it's important that LoanDAO is open source, especially as a hackathon submission for the [2023 Building on Bitcoin Hackathon](https://building-on-btc-hack.devpost.com/). 
