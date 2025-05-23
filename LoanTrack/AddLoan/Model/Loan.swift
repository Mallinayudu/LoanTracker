import Foundation

//struct Loan: Identifiable, Codable {
//    var id: UUID = UUID()
//    var borrowerName: String
//    var amount: Double
//    var interestRate: Double
//    var startDate: Date
//    var dueDate: Date
//    var isRepaid: Bool = false
//    var notes: String?
//    var createdAt: Date = Date()
//    var updatedAt: Date = Date()
//    
//    init(borrowerName: String = "",
//         amount: Double = 0.0,
//         interestRate: Double = 0.0,
//         startDate: Date = Date(),
//         dueDate: Date = Date().addingTimeInterval(30*24*60*60),
//         notes: String? = nil) {
//        self.borrowerName = borrowerName
//        self.amount = amount
//        self.interestRate = interestRate
//        self.startDate = startDate
//        self.dueDate = dueDate
//        self.notes = notes
//    }
//}
//
//// MARK: - Computed Properties
//extension Loan {
//    var remainingDays: Int {
//        let calendar = Calendar.current
//        return calendar.dateComponents([.day], from: Date(), to: dueDate).day ?? 0
//    }
//    
//    var interestAmount: Double {
//        let numberOfDays = Double(Calendar.current.dateComponents([.day], from: startDate, to: dueDate).day ?? 0)
//        return (amount * interestRate * numberOfDays) / (100 * 365)
//    }
//    
//    var totalAmount: Double {
//        return amount + interestAmount
//    }
//} 
