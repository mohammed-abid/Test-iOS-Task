//
//  IbanView.swift
//  KFH Test
//
//  Created by Mohammed Abid on 8/16/23.
//

import SwiftUI

struct IbanView: View {
    @StateObject var ibanVM = IbanVM()
    @State var ibanText = ""
    @State private var showResultText = false
    @FocusState private var inputIsFocused: Bool
    
    var body: some View {
        VStack {
            
            Text("Validate IBAN")
                .font(.system(size: 30))
                .bold()
                .foregroundColor(Color.green)
            
            TextField("Enter IBAN Number" ,text: $ibanText)
                .padding()
                .background(Color.gray.opacity(0.10))
                .cornerRadius(20.0)
                .padding()
                .keyboardType(.decimalPad)
                .focused($inputIsFocused)
            
            Button(action: {
                showResultText.toggle()
                ibanVM.checkIbanValidation(enteredText: ibanText)
            }) {
                Text("Validate")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(.system(size: 18))
                    .padding()
                    .foregroundColor(isTextFieldEmpty ? Color.green.opacity(0.2) : Color.green)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(isTextFieldEmpty ? Color.green.opacity(0.2) : Color.green, lineWidth: 5)
                    )
            }
            .disabled(isTextFieldEmpty ? true : false)
            .background(Color.white)
            .cornerRadius(20)
            .padding()
            
            if showResultText {
                Text(isValidIban ? "Valid IBAN" : "Not a valid IBAN")
                    .foregroundColor(ibanVM.isValidIban == true ? Color.green : Color.red)
            }
        }
    }
    
    var isTextFieldEmpty: Bool {
        return ibanText.isEmpty
    }
    
    var isValidIban: Bool {
        return ibanVM.isValidIban == true
    }
}

struct IbanView_Previews: PreviewProvider {
    static var previews: some View {
        IbanView()
    }
}
