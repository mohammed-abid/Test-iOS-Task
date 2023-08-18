//
//  CurrencyVM.swift
//  KFH Test
//
//  Created by Mohammed Abid on 8/15/23.
//

import Foundation
import Combine
import Alamofire

class CurrencyViewModel: ObservableObject {
    
    @Published var currenciesData:[String: Double] =  [String: Double]()
    @Published var showAlert: Bool = false
    private var cancellableSet : Set<AnyCancellable> = []
    var dataManager: ServiceProtocol
    var cancellation: AnyCancellable?
    init( dataManager: ServiceProtocol = Service.shared) {
        self.dataManager = dataManager
    }
    
    func getCurrenciesData() {
        dataManager.getCurrenciesData()
            .sink(receiveCompletion: { result in
                switch result{
                case .finished:
                    print("Fetch Success")
                case .failure(let error):
                    print("Failure error:", error.localizedDescription) 
                    
                }
            }, receiveValue: {response in
                if response.success {
                    self.currenciesData = response.rates
                    print(self.currenciesData)
                }
            }).store(in: &cancellableSet)
    }
    
    
    
}
