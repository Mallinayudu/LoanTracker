//
//  AddLoanView.swift
//  LoanTrack
//
//  Created by Manoj Somineni on 20/05/25.
//

import SwiftUI

struct AddLoanView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var loan: LoanNames = .personal
    @State private var loanType: LoanTypes = .lent
    @State private var rateOfInterestType: RateOfInterestTypes = .rupees
    @State private var loanTenure: LoanTenure = .threeYeas
    @State private var rePaymentType: RePaymentType = .monthly
    @State private var selectedDay: Int = 1
    
    @State private var personName: String = String.empty
    @State private var loanName: String = String.empty
    @State private var person: String = String.empty
    @State private var amount: String = String.empty
    @State private var interest: String = String.empty
    
    @State private var dueDate: Date = Date()
    
    var body: some View {
//        NavigationView {
            Form {
                Section {
                
                    Picker(AppStrings.Labels.loan, selection: $loan) {
                        ForEach(LoanNames.allCases, id: \.self) {
                            Text($0.rawValue.localizedCapitalized)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    Picker(AppStrings.Labels.type, selection: $loanType) {
                        ForEach(LoanTypes.allCases, id: \.self) {
                            Text($0.displayName)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    TextField(loanType == .borrowedFromBank  ? AppStrings.Placeholders.enterBankName : AppStrings.Placeholders.enterName,
                              text: $personName).onSubmit {
                        hideKeyboard()
                    }
                    
                    HStack {
                        Text("₹")
                        TextField(AppStrings.Placeholders.enterAmount, text: $amount)
                            .keyboardType(.decimalPad)
                    }
                    
                    Picker(AppStrings.Labels.rateOfInterestType, selection: $rateOfInterestType) {
                        ForEach(RateOfInterestTypes.allCases, id: \.self) {
                            Text($0.rawValue.localizedCapitalized)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    TextField(AppStrings.Labels.interest, text: $interest)
                            .keyboardType(.decimalPad)

                    DatePicker(loanType == .lent ? AppStrings.Labels.givenDate : AppStrings.Labels.takenDate,
                               selection: $dueDate,
                               displayedComponents: .date)
                   
                    Picker(AppStrings.Labels.tenure, selection: $loanTenure) {
                        ForEach(LoanTenure.allCases, id: \.self) {
                            Text($0.displayName)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section {
                    Picker(AppStrings.Labels.rePaymentType, selection: $rePaymentType) {
                        ForEach(RePaymentType.allCases, id: \.self) {
                            Text($0.displayName)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    if rePaymentType == .once {
                        DatePicker(AppStrings.Labels.paymentDate,
                                   selection: $dueDate,
                                   displayedComponents: .date)
                    } else {
                        Picker(rePaymentType.repayMentDayTitleText,
                               selection: $selectedDay) {
                                    ForEach(1...31, id: \.self) { day in
                                        Text("\(day)").tag(day)
                                    }
                        }.pickerStyle(.menu)
                    }
                    
                    HStack {
                        Text("₹")
                        TextField(AppStrings.Placeholders.enterAmount, text: $amount)
                            .keyboardType(.decimalPad)
                    }
                }

                Section {
                    Button(action: {
                        // Handle save action here
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text(AppStrings.Buttons.add)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
            }.onTapGesture {
                self.hideKeyboard()
            }
            .navigationTitle("Add Loan")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(false)
//        }
    }
}

#Preview {
    AddLoanView()
}
