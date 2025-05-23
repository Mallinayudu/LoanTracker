import Foundation
import Combine

@MainActor
class AddLoanViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var loanName: LoanNames = .personal
    @Published var loanType: LoanType = .lent
    @Published var borrowerLentName: String = String.empty
    @Published var amount: Double = 0.0
    @Published var rateOfInterestType: RateOfInterestTypes = .rupees
    @Published var interestRate: Double = 0.0
    @Published var startDate: Date = Date()
    @Published var createdDate: Date = Date()
    @Published var tenure: LoanTenure = .threeMonths
    @Published var repaymentType: RePaymentType = .monthly
    @Published var repaymentDate: Date = Date().addingTimeInterval(30*24*60*60)
    @Published var installAmount: Double = 0.0
    @Published var repaymentDay: Int = 0
    
    // MARK: - Validation Properties
    @Published var borrowerNameError: String?
    @Published var amountError: String?
    @Published var interestRateError: String?
    @Published var dateError: String?
    
    // MARK: - State Properties
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = String.empty
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupValidation()
    }
    
    private func setupValidation() {
        // Borrower Name Validation
        $borrowerLentName
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map { name in
                if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    return "Borrower name is required"
                }
                return nil
            }
            .assign(to: &$borrowerNameError)
        
        // Amount Validation
        $amount
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map { amountStr in
//                guard let amount = Double(amountStr) else {
//                    return "Please enter a valid amount"
//                }
                if self.amount <= 0 {
                    return "Amount must be greater than 0"
                }
                return nil
            }
            .assign(to: &$amountError)
        
        // Interest Rate Validation
        $interestRate
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map { rateStr in
//                guard let rate = Double(rateStr) else {
//                    return "Please enter a valid interest rate"
//                }
                if self.interestRate < 0 {
                    return "Interest rate cannot be negative"
                }
                return nil
            }
            .assign(to: &$interestRateError)
        
        // Date Validation
//        Publishers.CombineLatest($startDate, $dueDate)
//            .map { startDate, dueDate in
//                if dueDate < startDate {
//                    return "Due date must be after start date"
//                }
//                return nil
//            }
//            .assign(to: &$dateError)
    }
    
    var isFormValid: Bool {
        guard borrowerNameError == nil,
              amountError == nil,
              interestRateError == nil,
              dateError == nil,
              !borrowerLentName.isEmpty,
              amount != 0 else {
            return false
        }
        return true
    }
    
    func createLoan() async throws -> AddLoanModel {
//        guard let amountValue = Double(amount),
//              let interestRateValue = Double(interestRate) else {
//            throw ValidationError.invalidInput
//        }
        
        return AddLoanModel(loanName: loanName,
                            loanType: loanType,
                            borrowerLentName: borrowerLentName,
                            amount: amount,
                            rateOfInterestType: rateOfInterestType,
                            interestRate: interestRate,
                            startDate: startDate,
                            createdAt: createdDate,
                            tenure: tenure,
                            repaymentType: repaymentType,
                            repaymentDate: repaymentDate,
                            instsllAmount: installAmount,
                            repaymentDay: repaymentDay)
    }
    
    func clearForm() {
        borrowerLentName = String.empty
        amount = 0.0
        interestRate = 0.0
        startDate = Date()
//        dueDate = Date().addingTimeInterval(30*24*60*60)
    }
}

// MARK: - Errors
extension AddLoanViewModel {
    enum ValidationError: LocalizedError {
        case invalidInput
        
        var errorDescription: String? {
            switch self {
            case .invalidInput:
                return "Please check your input and try again"
            }
        }
    }
} 
