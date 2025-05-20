//
//  AddLoanModel.swift
//  LoanTrack
//
//  Created by Manoj Somineni on 20/05/25.
//

enum LoanNames: String, CaseIterable {
    case personal
    case home
    case vehical
    case hand
}

enum LoanTypes: String, CaseIterable {
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

enum RateOfInterestTypes: String, CaseIterable {
    case rupees
    case percentage
}

enum LoanTenure: String, CaseIterable {
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

enum RePaymentType: String, CaseIterable {
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
