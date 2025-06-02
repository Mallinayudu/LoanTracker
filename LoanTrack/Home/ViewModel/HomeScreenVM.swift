//
//  HomeScreenVM.swift
//  LoanTrack
//
//  Created by Manoj Somineni on 21/05/25.
//

import Foundation
import Combine
import CoreData

enum LoanType:String, Codable {
    case borrowedFromBank
    case borrowedFromFriend
    case lent
    
    var displayName: String {
        switch self {
        case .borrowedFromBank:
            return "Borrowed"
        case .borrowedFromFriend:
            return "Borrowed"
        case .lent:
            return AppStrings.Labels.lent
        }
    }
    
    static let defaultValue: LoanType = .lent
}

struct Loan: Identifiable, Hashable {
    let id: UUID
    let name: String
    let person: String
    let amount: Double
    let type: LoanType
    let dueDate: Date
    let interestRate: Double
    let rateOfInterestType: String
    let startDate: Date
    let tenure: String
    let repaymentType: String
    let installAmount: Double
    let repaymentDay: Int
    
    init(from entity: LoanEntity) {
        self.id = entity.id ?? UUID()
        self.name = entity.loanName ?? String.empty
        self.person = entity.borrowerLentName ?? String.empty
        self.amount = entity.amount
        self.type = LoanType(rawValue: entity.loanType ?? String.empty) ?? .defaultValue
        self.dueDate = entity.repaymentDate ?? Date()
        self.interestRate = entity.interestRate
        self.rateOfInterestType = entity.rateOfInterestType ?? String.empty
        self.startDate = entity.startDate ?? Date()
        self.tenure = entity.tenure ?? String.empty
        self.repaymentType = entity.repaymentType ?? String.empty
        self.installAmount = entity.installAmount
        self.repaymentDay = Int(entity.repaymentDay)
    }
}

enum ListTypes: String, CaseIterable {
    case all
    case borrowed
    case lent
    
    var displayName: String {
        switch self {
        case .all:
            return AppStrings.Labels.all
        case .borrowed:
            return AppStrings.Labels.borrowed
        case .lent:
            return AppStrings.Labels.lent
        }
    }
}

class HomeScreenVM: ObservableObject {
    // MARK: - Published Properties
    @Published var screenTitle: String = AppStrings.ScreenTitles.dasboard
    @Published var loans: [Loan] = []
    
    private let coreDataManager = CoreDataManager.shared
    
    // Computed filtered lists
    var borrowedLoans: [Loan] {
        loans.filter { $0.type == .borrowedFromBank || $0.type == .borrowedFromFriend }
    }
    
    var lentLoans: [Loan] {
        loans.filter { $0.type == .lent }
    }
    
    var totalBorrowed: Double {
        borrowedLoans.reduce(0) { $0 + $1.amount }
    }
    
    var totalLent: Double {
        lentLoans.reduce(0) { $0 + $1.amount }
    }
    
    // MARK: - Initializer
    init() {
        fetchLoans()
    }
    
    // MARK: - Methods
    func fetchLoans() {
        let loanEntities = coreDataManager.fetchLoans()
        loans = loanEntities.map { Loan(from: $0) }
    }
    
    func getLoans(loanTypes: ListTypes) -> [Loan] {
        switch loanTypes {
        case .all:
            return loans
        case .borrowed:
            return borrowedLoans
        case .lent:
            return lentLoans
        }
    }
    
    func deleteLoan(loan: Loan) {
        coreDataManager.deleteLoan(with: loan.id)
        fetchLoans()
    }
}

@propertyWrapper
struct Capitalized {
    private var value: String = ""
    
    var wrappedValue: String {
        get { value }
        set { value = newValue.capitalized }
    }
    
    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
}
