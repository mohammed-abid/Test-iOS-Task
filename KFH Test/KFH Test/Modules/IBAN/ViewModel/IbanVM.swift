//
//  IbanVM.swift
//  KFH Test
//
//  Created by Mohammed Abid on 8/16/23.
//

import Foundation
import Combine
import Alamofire

class IbanVM: ObservableObject {
    
    @Published var isValidIban: Bool = false
    @Published var showAlert: Bool = false
    private var cancellableSet : Set<AnyCancellable> = []
    var dataManager: ServiceProtocol
    var cancellation: AnyCancellable?
    init( dataManager: ServiceProtocol = Service.shared) {
        self.dataManager = dataManager
    }
    
    func checkIbanValidation(enteredText: String) {
        dataManager.validateIbanNo(enteredText: enteredText)
            .sink(receiveCompletion: { result in
                switch result{
                case .finished:
                    print("validation Success")
                case .failure:
                    print("validation Failed")
                    self.isValidIban = false
                    
                }
            }, receiveValue: {response in
                self.isValidIban = response.valid
            }).store(in: &cancellableSet)
    }
}


