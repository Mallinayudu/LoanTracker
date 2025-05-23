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
    
    var body: some View {
//        NavigationView {
            ScrollView {
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
                        VStack(alignment: .center, spacing: 8) {
                            ForEach(filteredLoans) { loan in
                                NavigationLink(destination: AddLoanView()) {
                                    LoanRowView(loan: loan)
                                        .frame(maxWidth: .infinity)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity)
            }
            .navigationTitle(viewModel.screenTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                NavigationLink(destination: AddLoanView()) {
                    Image(systemName: "plus")
                }
            }
//        }
    }
}

#Preview {
    HomeScreen()
}


//struct InlineNavigationModifier: ViewModifier {
//    let title: String
//    let displayBackButton: Bool
//
//    func body(content: Content) -> some View {
//        content
//            .navigationTitle(title)
//            .navigationBarTitleDisplayMode(.inline)
//            .navigationBarBackButtonHidden(!displayBackButton)
//            .navigationBarBackButtonDisplayMode(.minimal)
//    }
//}
//
//extension View {
//    func inlineNavigation(title: String, showBackButton: Bool = true) -> some View {
//        self.modifier(InlineNavigationModifier(title: title, displayBackButton: showBackButton))
//    }
//}
