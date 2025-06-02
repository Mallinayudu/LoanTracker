//
//  HomeScreen.swift
//  LoanTrack
//
//  Created by Manoj Somineni on 20/05/25.
//

import SwiftUI

struct HomeScreen: View {
    
    @StateObject private var viewModel = HomeScreenVM()
    @State private var listTypes: ListTypes = .all
    @State private var selectedLoan: Loan?
    
    var body: some View {
            VStack(spacing: 16) {
                // MARK: - Summary Cards
                HStack(spacing: 16) {
                    SummaryCard(title: AppStrings.Labels.totalBorrowed,
                                amount: viewModel.totalBorrowed,
                                color: .red)
                    SummaryCard(title: AppStrings.Labels.totalLent,
                                amount: viewModel.totalLent,
                                color: .green)
                }
                .padding(.horizontal)
                
                Picker(String.empty, selection: $listTypes) {
                        ForEach(ListTypes.allCases, id: \.self) {
                            Text($0.displayName)
                        }
                 }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)

                let filteredLoans = viewModel.getLoans(loanTypes: listTypes)
                if filteredLoans.isEmpty {
                    EmptyStateView(
                        message: "No \(listTypes.displayName.lowercased()) loans available.\nTap + to add a new loan.",
                        systemImage: "creditcard"
                    )
                    .padding(.vertical)
                } else {
                    List(filteredLoans) { loan in
                        Button {
                            selectedLoan = loan
                         } label: {
                             LoanRowView(loan: loan)
                         }
                         .listRowSeparator(.hidden)
                         .listRowBackground(Color.clear)
                         .buttonStyle(PlainButtonStyle())
                         .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    viewModel.deleteLoan(loan: loan)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                          }
                    }
                    .listStyle(.inset)
                    .scrollContentBackground(.hidden)
                    .navigationDestination(item: $selectedLoan) { loan in
                        LoanDetailView(loan: loan)
                    }
                }
            }
            .navigationTitle(viewModel.screenTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                NavigationLink(destination: AddLoanView()) {
                    Image(systemName: "plus")
                }
            }
            .onAppear {
                viewModel.fetchLoans()
            }
    }
}

#Preview {
    HomeScreen()
}
