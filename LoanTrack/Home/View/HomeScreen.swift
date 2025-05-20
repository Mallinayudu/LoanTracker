//
//  HomeScreen.swift
//  LoanTrack
//
//  Created by Manoj Somineni on 20/05/25.
//

import SwiftUI

struct HomeScreen: View {
    
    @State private var showAddLoanView = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    
                    // MARK: - Summary Cards
                    HStack(spacing: 16) {
                        SummaryCard(title: "Total Borrowed", amount: 12000, color: .red)
                        SummaryCard(title: "Total Lent", amount: 8000, color: .green)
                    }
                    .padding(.horizontal)

                    // MARK: - Upcoming Payments
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Upcoming Payments")
                            .font(.headline)
                            .padding(.horizontal)

                        ForEach(sampleLoans.prefix(3)) { loan in
                            NavigationLink(destination: AddLoanView()) {
                                LoanRowView(loan: loan)
                                            }
                        }
                    }

                    // MARK: - All Loans
                    VStack(alignment: .leading, spacing: 8) {
                        Text("All Loans")
                            .font(.headline)
                            .padding(.horizontal)

                        ForEach(sampleLoans) { loan in
                            LoanRowView(loan: loan)
                        }
                    }
                }
                .padding(.vertical)
                .sheet(isPresented: $showAddLoanView) {
                    AddLoanView()
                }
            }
            .navigationTitle("Dashboard")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                                   Button(action: {
                                       showAddLoanView = true
                                   }) {
                                       Image(systemName: "plus")
                                   }
                               }
            }
        }
    }
}

#Preview {
    HomeScreen()
}

struct Loan: Identifiable {
    let id = UUID()
    let title: String
    let type: String // "Borrowed" or "Lent"
    let dueDate: String
    let amount: Double
}

let sampleLoans = [
    Loan(title: "Car Loan - Dad", type: "Borrowed", dueDate: "25 May 2025", amount: 5000),
    Loan(title: "Personal Loan - Ravi", type: "Lent", dueDate: "1 June 2025", amount: 3000),
    Loan(title: "Home Loan", type: "Borrowed", dueDate: "15 June 2025", amount: 7000)
]
