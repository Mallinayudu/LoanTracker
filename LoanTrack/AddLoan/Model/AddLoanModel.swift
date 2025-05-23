//
//  AddLoanModel.swift
//  LoanTrack
//
//  Created by Manoj Somineni on 20/05/25.
//
import Foundation

enum LoanNames: String, CaseIterable, Codable {
    case personal
    case home
    case vehical
    case hand
}

enum LoanTypes: String, CaseIterable, Codable {
    case borrowedFromBank
    case borrowedFromFriend
    case lent
    
    var displayName: String {
        switch self {
                case .borrowedFromBank:
            return AppStrings.Labels.borrowedFromBank
                case .borrowedFromFriend:
                    return AppStrings.Labels.borrowedFromBank
                case .lent:
                    return AppStrings.Labels.lent
        }
    }
}

enum RateOfInterestTypes: String, CaseIterable, Codable {
    case rupees
    case percentage
}

enum LoanTenure: String, CaseIterable , Codable{
    case threeMonths
    case sixMonths
    case nineMonths
    case oneYear
    case twoYears
    case threeYeas
    case fourYears
    case fiveYears
    
    var displayName: String {
        switch self {
                case .threeMonths:
                    return "Three Months"
                case .sixMonths:
                    return "Six Months"
                case .nineMonths:
                    return "Nine Months"
        case .oneYear:
            return "One Year"
        case .twoYears:
            return "Two Years"
        case .threeYeas:
            return "Three Years"
        case .fourYears:
            return "Four Years"
        case .fiveYears:
            return "Five Years"
        }
    }
}

enum RePaymentType: String, CaseIterable, Codable {
    case monthly
    case quarterly
    case halfYearly
    case yearly
    case once
    
    var displayName: String {
        switch self {
                case .monthly:
                    return "Monthly"
                case . quarterly:
                    return "Quartely"
                case .halfYearly:
                    return "Half Yearly"
                case .yearly:
                    return "Yearly"
        case .once:
            return "Once at a time"
        }
    }
    
    var repayMentDayTitleText: String {
        switch self {
                case .monthly:
                    return "On the same day for every Month"
                case . quarterly:
                    return "On the same day for every Quarter"
                case .halfYearly:
                    return "On the same day for every Half Year"
                case .yearly:
                    return "On the same day for every Year"
        case .once:
            return "Once at a time"
        }
    }
}

struct AddLoanModel: Identifiable, Codable {
    var id: UUID = UUID()
    var loanName: LoanNames?
    var loanType: LoanType?
    var borrowerLentName: String
    var amount: Double
    var rateOfInterestType: RateOfInterestTypes?
    var interestRate: Double
    var startDate: Date
    var createdAt: Date = Date()
    var tenure: LoanTenure?
    var repaymentType: RePaymentType?
    var repaymentDate: Date?
    var instsllAmount: Double?
    var repaymentDay: Int?
    
    init(loanName: LoanNames? = nil, loanType: LoanType? = nil, borrowerLentName: String, amount: Double, rateOfInterestType: RateOfInterestTypes? = nil, interestRate: Double, startDate: Date, createdAt: Date, tenure: LoanTenure? = nil, repaymentType: RePaymentType? = nil, repaymentDate: Date? = nil, instsllAmount: Double? = nil, repaymentDay: Int? = nil) {
        self.loanName = loanName
        self.loanType = loanType
        self.borrowerLentName = borrowerLentName
        self.amount = amount
        self.rateOfInterestType = rateOfInterestType
        self.interestRate = interestRate
        self.startDate = startDate
        self.createdAt = createdAt
        self.tenure = tenure
        self.repaymentType = repaymentType
        self.repaymentDate = repaymentDate
        self.instsllAmount = instsllAmount
        self.repaymentDay = repaymentDay
    }
}

// MARK: - Computed Properties
extension AddLoanModel {
    var remainingDays: Int {
        let calendar = Calendar.current
        return calendar.dateComponents([.day], from: Date(), to: startDate).day ?? 0
    }
    
    var interestAmount: Double {
        let numberOfDays = Double(Calendar.current.dateComponents([.day], from: startDate, to: startDate).day ?? 0)
        return (amount * interestRate * numberOfDays) / (100 * 365)
    }
    
    var totalAmount: Double {
        return amount + interestAmount
    }
}
