;; LoanDAO
;; Cultivated by NoCodeClarity, Inc.
;; Dedicated to the dreamers and builders

(define-data-var is-collateralized false)
(define-data-var collateral 0)
(define-data-var loan-amount 0)
(define-data-var repayment-amount 0)
(define-data-var interest-rate 0)
(define-data-var repayment-period 0)
(define-data-var next-payment-timestamp 0)
(define-data-var contract-owner (get-tx-sender))
(define-data-var startup "")

(define-public (init-startup-contract startup-wallet)
  (define is-collateralized false)
  (define collateral 0)
  (define loan-amount 0)
  (define repayment-amount 0)
  (define interest-rate 0)
  (define repayment-period 0)
  (define next-payment-timestamp 0)
  (define contract-owner (get-tx-sender))
  (define startup startup-wallet))

(define-public (set-collateral)
  (if (is-equal-tx-sender? startup)
      (begin
        (assert (= is-collateralized false) "Collateral already set")
        (transfer (stx-contract-caller) contract-owner collateral-amount)
        (define is-collateralized true)
        (define-data-var is-collateralized is-collateralized)))
  (err "Unauthorized sender: only the startup can set collateral"))

(define-public (get-collateral)
  collateral)

(define-public (get-loan-amount)
  loan-amount)

(define-public (get-repayment-amount)
  repayment-amount)

(define-public (get-interest-rate)
  interest-rate)

(define-public (get-repayment-period)
  repayment-period)

(define-public (get-next-payment-timestamp)
  next-payment-timestamp)

(define-public (get-contract-owner)
  contract-owner)

(define-public (get-startup)
  startup)

(define-private (calculate-next-payment-timestamp)
  (define current-time (chain-get-block-info 'timestamp))
  (+ current-time repayment-period))

(define-private (calculate-interest)
  (define total-outstanding (getTotalOutstandingAmount))
  (* total-outstanding (/ interest-rate 100)))

(define-private (isStartupEligibleForLoan)
  ; Add code to check if the startup is eligible for the loan based on certain criteria
)

(define-private (isCollateralSufficient)
  ; Add code to check if the collateral provided by the startup is sufficient to cover the loan amount and interest
)

(define-private (getTotalOutstandingAmount)
  (+ loan-amount (calculate-interest)))

(define-public (makeLoanRequest loan-amount-p repayment-amount-p interest-rate-p repayment-period-p)
  (if (is-equal-tx-sender? startup)
      (begin
        (assert (not is-collateralized) "Collateral already set")
        (assert (isStartupEligibleForLoan) "Startup not eligible for loan")
        (define loan-amount loan-amount-p)
        (define repayment-amount repayment-amount-p)
        (define interest-rate interest-rate-p)
        (define repayment-period repayment-period-p)
        (define next-payment-timestamp (calculate-next-payment-timestamp))
        (define-data-var loan-amount loan-amount)
        (define-data-var repayment-amount repayment-amount)
        (define-data-var interest-rate interest-rate)
        (define-data-var repayment-period repayment-period)
        (define-data-var next-payment-timestamp next-payment-timestamp)
        (set-collateral)))
  (err "Unauthorized sender: only the startup can request a loan"))

  (define-public (makeRepayment)
  (if (is-equal-tx-sender? startup)
      (define current-time (chain-get-block-info 'timestamp))
      (if (< current-time next-payment-timestamp)
          (err "Loan repayment not yet due")
          (begin
            (assert (isCollateralSufficient) "Collateral is insufficient")
            (define total-outstanding (getTotalOutstandingAmount))
            (transfer (stx-contract-caller) contract-owner repayment-amount)
            (define new-outstanding (- total-outstanding repayment-amount))
            (define new-interest (calculate-interest))
            (define new-next-payment-timestamp (calculate-next-payment-timestamp))
            (if (< new-outstanding 0)
                (begin
                  (transfer contract-owner (stx-contract-caller) (- new-outstanding))
                  (define-data-var loan-amount 0)
                  (define-data-var repayment-amount 0)
                  (define-data-var interest-rate 0)
                  (define-data-var repayment-period 0)
                  (define-data-var next-payment-timestamp 0)
                  (define is-collateralized false)
                  (define-data-var is-collateralized is-collateralized))
                (begin
                  (define-data-var loan-amount new-outstanding)
                  (define-data-var interest-rate new-interest)
                  (define-data-var next-payment-timestamp new-next-payment-timestamp)))))) 
  (err "Unauthorized sender: only the startup can make a repayment"))

(define-public (getOutstandingAmount)
  (getTotalOutstandingAmount))

(define-public (getTotalInterest)
  (calculate-interest))

(define-public (payoffLoan)
  (if (is-equal-tx-sender? startup)
      (begin
        (assert (isCollateralSufficient) "Collateral is insufficient")
        (define total-outstanding (getTotalOutstandingAmount))
        (transfer (stx-contract-caller) contract-owner total-outstanding)
        (define-data-var loan-amount 0)
        (define-data-var repayment-amount 0)
        (define-data-var interest-rate 0)
        (define-data-var repayment-period 0)
        (define-data-var next-payment-timestamp 0)
        (define is-collateralized false)
        (define-data-var is-collateralized is-collateralized))
      (err "Unauthorized sender: only the startup can pay off the loan"))

(define-data-var dao-contract "")
(define-data-var dao-members '())

(define-private (calculate-dao-interest dao-balance)
  ; Add code to calculate the interest earned by the DAO
)

(define-public (createDao dao-contract-wallet)
  (if (is-equal-tx-sender? contract-owner)
      (begin
        (define dao-contract dao-contract-wallet)
        (define-data-var dao-contract dao-contract)))
  (err "Unauthorized sender: only the contract owner can create a DAO"))

(define-public (addMemberToDao member-wallet)
  (if (is-equal-tx-sender? contract-owner)
      (begin
        (set dao-members (append dao-members (list member-wallet)))))
  (err "Unauthorized sender: only the contract owner can add a member to the DAO"))

(define-private (getTotalDaoMembers)
  (length dao-members))

  (define-public (payDaoMembers)
  (if (is-equal-tx-sender? startup)
      (begin
        (define dao-balance (get-balance dao-contract))
        (define dao-members-count (getTotalDaoMembers))
        (define dao-interest (calculate-dao-interest dao-balance))
        (define total-amount-to-pay-per-member (+ (/ dao-balance dao-members-count) dao-interest))
        (dolist (member dao-members)
          (transfer dao-contract member total-amount-to-pay-per-member))
        )
      (err "Unauthorized sender: only the startup can pay DAO members")
      )
  )

(define-public (depositToContract)
  (if (is-equal-tx-sender? startup)
      (begin
        (transfer (stx-contract-caller) contract-owner (get-balance (stx-contract-caller)))
        )
      (err "Unauthorized sender: only the startup can deposit funds")
      )
  )

(define-public (withdrawFromContract amount)
  (if (is-equal-tx-sender? contract-owner)
      (begin
        (assert (< amount (get-balance contract-owner)) "Withdrawal amount is greater than available balance")
        (transfer contract-owner (stx-contract-caller) amount)
        )
      (err "Unauthorized sender: only the contract owner can withdraw funds")
      )
  )

(define-public (getContractBalance)
  (get-balance contract-address)
  )

(define-public (getDaoContractBalance)
  (get-balance dao-contract)
  )

(define-public (set-collateral)
  (if (is-equal-tx-sender? startup)
      (begin
        (define collateral-amount (tx-sender-collateral))
        (define loan-amount (getTotalOutstandingAmount))
        (define required-collateral (* loan-amount collateralization-factor))
        (if (>= collateral-amount required-collateral)
            (begin
              (define is-collateralized true)
              (define-data-var is-collateralized is-collateralized)
              )
            (err "Collateral is insufficient")
            )
        )
      (err "Unauthorized sender: only the startup can set collateral")
      )
  )

(define-public (getCollateralizationRatio)
  (if (is-collateralized)
      (/ (tx-sender-collateral) (getTotalOutstandingAmount))
      0)
  )

(define-public (isCollateralSufficient)
  (define loan-amount (getTotalOutstandingAmount))
  (define required-collateral (* loan-amount collateralization-factor))
  (>= (tx-sender-collateral) required-collateral)
  )

(define-public (getLoanDetails)
  (list
   (cons "Loan Amount" loan-amount)
   (cons "Repayment Amount" repayment-amount)
   (cons "Interest Rate" interest-rate)
   (cons "Repayment Period" repayment-period)
   (cons "Next Payment Timestamp" next-payment-timestamp)
   (cons "Is Collateralized" is-collateralized)
   (cons "Collateralization Ratio" (getCollateralizationRatio))
   )
  )

(define-public (getDaoMembers)
  dao-members
  )

(define-public (getDaoContract)
  dao-contract
  )

(define-public (getTotalOutstandingAmount)
  (define principal (data-var loan-amount))
  (define total-repaid (data-var total-amount-repaid))
  (- principal total-repaid)
  )

(define-private (getTotalDaoMembers)
  (length dao-members)
  )

(define-private (calculate-dao-interest dao-balance)
  (* dao-balance dao-interest-rate))

(define-private (updateNextPaymentTimestamp)
  (define current-timestamp (now))
  (define next-timestamp (+ current-timestamp repayment-period))
  (define-data-var next-payment-timestamp next-timestamp))

(define-private (updateTotalAmountRepaid)
  (define current-total-repaid (data-var total-amount-repaid))
  (define-data-var total-amount-repaid (+ current-total-repaid repayment-amount)))

(define-private (addToDaoMembers wallet)
  (set! dao-members (cons wallet dao-members)))

(define-private (removeFromDaoMembers wallet)
  (set! dao-members (filter (lambda (member) (not (equal? wallet member))) dao-members)))

;; This has been created for the 2023 Building on Bitcoin Hackathon
