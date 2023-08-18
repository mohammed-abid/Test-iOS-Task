//
//  ContentView.swift
//  KFH Test
//
//  Created by Mohammed Abid on 8/15/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CurrencyView()
                .tabItem {
                    Label("Currency", systemImage: "house.fill")
                    
                }
            
            IbanView()
                .tabItem {
                    Label("IBAN", systemImage: "square.and.pencil")
                    
                }
            
        }
        .accentColor(.green)
        .foregroundColor(.green)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
