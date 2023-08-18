//
//  CurrencyView.swift
//  KFH Test
//
//  Created by Mohammed Abid on 8/15/23.
//

import SwiftUI

struct CurrencyView: View {
    @StateObject var currencyVM = CurrencyViewModel()
    @State var inputAmount = "1"
    @State var baseCurrency = "KWD"
    @FocusState private var inputIsFocused: Bool
    
    var body: some View {
        VStack() {
            
            Text("Currency Converter")
                .font(.system(size: 30))
                .bold()
                .foregroundColor(Color.green)
                .padding(.top)
            
            VStack {
                Rectangle()
                    .frame(height: 8.0)
                    .foregroundColor(.green)
                    .opacity(0.90)
                TextField("Enter an amount" ,text: $inputAmount)
                    .padding()
                    .background(Color.gray.opacity(0.10))
                    .cornerRadius(20.0)
                    .padding()
                    .keyboardType(.decimalPad)
                    .focused($inputIsFocused)
                TextField("Enter a currency" ,text: $baseCurrency)
                    .padding()
                    .background(Color.gray.opacity(0.10))
                    .cornerRadius(20.0)
                    .padding()
                    .focused($inputIsFocused)
                    .disabled(true)
                Rectangle()
                    .frame(height: 8.0)
                    .foregroundColor(.green)
                    .opacity(0.90)
            }
            
            List {
                ForEach(currencyVM.currenciesData.sorted(by: >), id: \.key) { key, value in
                    LazyHStack {
                        Text(key)
                        Text(String(format: "%.2f", (value * (Double(inputAmount) ?? 0))))
                    }
                }
            }
            
        }.onAppear() {
            currencyVM.getCurrenciesData()
        }
    }
}

struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyView()
    }
}

