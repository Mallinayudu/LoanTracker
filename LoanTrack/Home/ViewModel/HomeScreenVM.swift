//
//  HomeScreenVM.swift
//  LoanTrack
//
//  Created by Manoj Somineni on 21/05/25.
//

import Foundation
import Combine

enum LoanType: Codable {
    case borrowed
    case lent
    
    var displayName: String {
        switch self {
        case .borrowed:
            return AppStrings.Labels.borrowed
                case .lent:
            return AppStrings.Labels.lent
        }
    }
}

struct Loan: Identifiable {
    let id = UUID()
    let name: String
    let person: String
    let amount: Double
    let type: LoanType
    let dueDate: Date
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
    
    // Computed filtered lists
        var borrowedLoans: [Loan] {
            loans.filter { $0.type == .borrowed }
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
            loadDummyData() // For testing; remove in production
        }
        
        // MARK: - Methods
        func addLoan(_ loan: Loan) {
            loans.append(loan)
        }

        func loadDummyData() {
            loans = [
                Loan(name: "Home Loan", person: "Bank", amount: 50000, type: .borrowed, dueDate: Date()),
                Loan(name: "Friend Help", person: "John", amount: 12000, type: .lent, dueDate: Date()),
                Loan(name: "Bike Loan", person: "Finance Corp", amount: 30000, type: .borrowed, dueDate: Date()),
            ]
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
}
