//
//  LoanRowView.swift
//  LoanTrack
//
//  Created by Manoj Somineni on 20/05/25.
//

import SwiftUI

struct LoanRowView: View {
    let loan: Loan

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(loan.name.uppercased()) Loan - \(loan.person)")
                    .font(.headline)
                Text("Due: \(loan.dueDate.formattedString)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("₹\(Int(loan.amount))")
                    .font(.headline)
                Text(loan.type.displayName)
                    .font(.subheadline)
                    .foregroundColor(loan.type == .lent ? .green : .red)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .center)
    }
}
