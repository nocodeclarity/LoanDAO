# LoanDAO
Decentralizing the future of loans. 

In the world of decentralized finance, the ability for startups and projects to access capital required to grow their business is important. Smart contracts, which allow for the automated transfer of funds and the enforcement of pre-defined agreements between parties, are one popular way for organizations to do so. LoanDAO is a Clarity smart contract that allows Decentralized Autonomous Organizations (DAOs) to provide loans to startups that must be repaid in Stacks or Bitcoin (which can be sBTC when live) every 30 days. LoanDAO is an open source glimpse of what is possible with Stacks as we believe that it can be used to power decentralized loans in the future. LoanDAO allows for the following: 

+ By sending a transaction to the contract, the startup can set collateral that will be held until the loan is fully repaid.

+ A loan can be initiated by the startup by sending a transaction containing the requested loan amount, interest rate, and repayment period.

+ DAO members can approve the loan by sending a transaction with a specified approval amount, which is added to the loan's total approved amount.

+ Once the loan has been fully approved, the startup can withdraw it by sending a transaction for the full amount approved.

+ Every 30 days, the startup can repay the loan by sending a transaction containing the specified repayment amount and either Stacks or Bitcoin.

+ The collateral will be returned to the startup once the loan has been fully repaid.

+ By sending a transaction to the contract, DAO members can withdraw their share of the DAO's interest earned over the life of the loan.

+ The contract includes DAO membership management functions, such as adding and removing members and calculating the DAO's total interest earned.

Overall, this smart contract enables DAOs to provide loans to startups with the security of collateral and regular repayments, while also allowing DAO members to earn interest on their investment. It is important to note that LoanDAO has not been audited and the legal implications have not been explored prior to the publishing of this open source Clarity smart contract. Use at your own risk. 

NoCodeClarity believes in the power of Bitcoin and Stacks so it's important that LoanDAO is open source, especially as a hackathon submission for the [2023 Building on Bitcoin Hackathon](https://building-on-btc-hack.devpost.com/). 
