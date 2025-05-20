//
//  View+Extension.swift
//  LoanTrack
//
//  Created by Manoj Somineni on 20/05/25.
//
import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
