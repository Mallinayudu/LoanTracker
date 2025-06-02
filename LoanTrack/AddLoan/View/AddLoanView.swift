//
//  AddLoanView.swift
//  LoanTrack
//
//  Created by Manoj Somineni on 20/05/25.
//

import SwiftUI

struct AddLoanView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = AddLoanViewModel()
    
    var body: some View {
        Form {
            Section {
                
                Picker(AppStrings.Labels.loan, selection: $viewModel.loanName) {
                    ForEach(LoanNames.allCases, id: \.self) {
                        Text($0.rawValue.localizedCapitalized)
                    }
                }
                .pickerStyle(.menu)
                
                Picker(AppStrings.Labels.type, selection: $viewModel.loanType) {
                    ForEach(LoanTypes.allCases, id: \.self) {
                        Text($0.displayName)
                    }
                }
                .pickerStyle(.menu)
                
                TextField(viewModel.loanType == .borrowedFromBank ? AppStrings.Placeholders.enterBankName : AppStrings.Placeholders.enterName,
                         text: $viewModel.borrowerLentName)
                .onSubmit {
                    hideKeyboard()
                }
                if let error = viewModel.borrowerNameError {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                HStack {
                    Text("₹")
                    TextField(AppStrings.Placeholders.enterAmount, value: $viewModel.amount, format: .number)
                        .keyboardType(.decimalPad)
                }
                if let error = viewModel.amountError {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                Picker(AppStrings.Labels.rateOfInterestType, selection: $viewModel.rateOfInterestType) {
                    ForEach(RateOfInterestTypes.allCases, id: \.self) {
                        Text($0.rawValue.localizedCapitalized)
                    }
                }
                .pickerStyle(.menu)
                
                TextField(AppStrings.Labels.interest, value: $viewModel.interestRate, format: .number)
                    .keyboardType(.decimalPad)
                if let error = viewModel.interestRateError {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                DatePicker(viewModel.loanType == .lent ? AppStrings.Labels.givenDate : AppStrings.Labels.takenDate,
                          selection: $viewModel.startDate,
                          displayedComponents: .date)
                
                Picker(AppStrings.Labels.tenure, selection: $viewModel.tenure) {
                    ForEach(LoanTenure.allCases, id: \.self) {
                        Text($0.displayName)
                    }
                }
                .pickerStyle(.menu)
            }
            
            Section {
                Picker(AppStrings.Labels.rePaymentType, selection: $viewModel.repaymentType) {
                    ForEach(RePaymentType.allCases, id: \.self) {
                        Text($0.displayName)
                    }
                }
                .pickerStyle(.menu)
                
                if viewModel.repaymentType == .once {
                    DatePicker(AppStrings.Labels.paymentDate,
                             selection: $viewModel.repaymentDate,
                             displayedComponents: .date)
                } else {
                    Picker(viewModel.repaymentType.repayMentDayTitleText,
                          selection: $viewModel.repaymentDay) {
                        ForEach(1...31, id: \.self) { day in
                            Text("\(day)").tag(day)
                        }
                    }.pickerStyle(.menu)
                }
                
                HStack {
                    Text("₹")
                    TextField(AppStrings.Placeholders.enterAmount, value: $viewModel.installAmount, format: .number)
                        .keyboardType(.decimalPad)
                }
            }
            
            Section {
                Button(action: {
                    print("Add Loan Clicked......")
                    Task {
                        do {
                            try await viewModel.saveLoan()
                            await MainActor.run {
                                presentationMode.wrappedValue.dismiss()
                            }
                        } catch {
                            await MainActor.run {
                                viewModel.showAlert = true
                                viewModel.alertMessage = error.localizedDescription
                            }
                        }
                    }
                }) {
                    Text(AppStrings.Buttons.add)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .disabled(!viewModel.isFormValid)
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
        .navigationTitle("Add Loan")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(false)
        .alert("Error", isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.alertMessage)
        }
    }
}

#Preview {
    AddLoanView()
}
