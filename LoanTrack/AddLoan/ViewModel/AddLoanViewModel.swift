import Foundation
import Combine
import CoreData

@MainActor
class AddLoanViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var loanName: LoanNames = .personal
    @Published var loanType: LoanTypes = .lent
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
    private let coreDataManager = CoreDataManager.shared
    
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
            .map { amount in
                if amount <= 0 {
                    return "Amount must be greater than 0"
                }
                return nil
            }
            .assign(to: &$amountError)
        
        // Interest Rate Validation
        $interestRate
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map { rate in
                if rate < 0 {
                    return "Interest rate cannot be negative"
                }
                return nil
            }
            .assign(to: &$interestRateError)
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
    
    func saveLoan() async throws {
        guard isFormValid else {
            throw ValidationError.invalidInput
        }
        
        let loan = AddLoanModel(
            loanName: loanName,
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
            installAmount: installAmount,
            repaymentDay: repaymentDay
        )
        
        try await coreDataManager.createLoan(from: loan)
        clearForm()
    }
    
    func clearForm() {
        borrowerLentName = String.empty
        amount = 0.0
        interestRate = 0.0
        startDate = Date()
        repaymentDate = Date().addingTimeInterval(30*24*60*60)
        installAmount = 0.0
        repaymentDay = 0
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
