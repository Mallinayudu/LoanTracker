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
    
    @State private var personName: String = ""
    @State private var loanName: String = ""
    @State private var person: String = ""
    @State private var amount: String = ""
    @State private var interest: String = ""
    
    @State private var dueDate: Date = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                
                    Picker("Loan", selection: $loan) {
                        ForEach(LoanNames.allCases, id: \.self) {
                            Text($0.rawValue.localizedCapitalized)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    Picker("Type", selection: $loanType) {
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
                    
                    Picker("Rate Of Interest Type", selection: $rateOfInterestType) {
                        ForEach(RateOfInterestTypes.allCases, id: \.self) {
                            Text($0.rawValue.localizedCapitalized)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    TextField("Interest", text: $interest)
                            .keyboardType(.decimalPad)

                    DatePicker(loanType == .lent ? "Given Date" : "Taken Date",
                               selection: $dueDate,
                               displayedComponents: .date)
                   
                    Picker("Tenure", selection: $loanTenure) {
                        ForEach(LoanTenure.allCases, id: \.self) {
                            Text($0.displayName)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section {
                    Picker("Re-Payment Type", selection: $rePaymentType) {
                        ForEach(RePaymentType.allCases, id: \.self) {
                            Text($0.displayName)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    if rePaymentType == .once {
                        DatePicker("Payment Date",
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
                        TextField("Amount", text: $amount)
                            .keyboardType(.decimalPad)
                    }
                }

                Section {
                    Button(action: {
                        // Handle save action here
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Add")
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
        }
    }
}

#Preview {
    AddLoanView()
}
