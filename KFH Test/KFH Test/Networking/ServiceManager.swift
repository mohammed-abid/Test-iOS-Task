//
//  ServiceManager.swift
//  KFH Test
//
//  Created by Mohammed Abid on 8/15/23.
//

import Foundation
import Combine
import Alamofire

enum NetworkErrors: Error{
    case urlError
    case responseError
    case decoderError
    case unknownError
}

protocol ServiceProtocol {
    func getCurrenciesData()-> AnyPublisher<Currency,Error>
    func validateIbanNo(enteredText: String) -> AnyPublisher<IBAN,Error>
    
}

class Service {
    static let shared = Service()
    private init(){}
    private var baseCurrency = "KWD"
    var session : Session?
    
    var baseURL: URL {
        URL(string: "https://api.apilayer.com")!
    }
    
    enum Endpoint {
        
        case currenciesdata
        case validateiban
        
        var path: String {
            switch self {
            case .currenciesdata: return "/fixer/latest"
            case .validateiban: return "/bank_data/iban_validate"
            }
        }
    }
    
    func generateEndpointURL(for endpoint: Endpoint) -> URL {
        return URL(string: "\(baseURL)\(endpoint.path)")!
    }
    
    var headers: HTTPHeaders {
        return ["apikey": "we5v67eJpkAAsTqfaiAtLSvbHBkWCiaR"]
    }
    
    func pinningComponents() {
        let evaluators: [String : ServerTrustEvaluating] = [
            "sni.cloudflaressl.com": PinnedCertificatesTrustEvaluator()
        ]
        let manager = ServerTrustManager(allHostsMustBeEvaluated: false, evaluators: evaluators)
        
        self.session = Session.init(serverTrustManager:manager)
    }
}


extension Service: ServiceProtocol{
    
    func getCurrenciesData() -> AnyPublisher<Currency,Error> {
        
        pinningComponents()
        
        guard var components = URLComponents(url: generateEndpointURL(for: .currenciesdata), resolvingAgainstBaseURL: true)
        else { fatalError("Couldn't create URLComponents") }
        
        components.queryItems = [URLQueryItem(name: "symbols", value: ""),
                                 URLQueryItem(name: "base", value: baseCurrency)]
        
        return self.session!.request(components.url!,method: .get, headers: headers)
            .validate()
            .publishDecodable(type: Currency.self)
            .value()
            .mapError { error -> Error in
                return error
            }
            .eraseToAnyPublisher()
    }
    
    
    func validateIbanNo(enteredText: String) -> AnyPublisher<IBAN,Error> {
        
        pinningComponents()
        
        guard var components = URLComponents(url: generateEndpointURL(for: .validateiban), resolvingAgainstBaseURL: true)
        else { fatalError("Couldn't create URLComponents") }
        
        components.queryItems = [URLQueryItem(name: "iban_number", value: enteredText)]
        
        return self.session!.request(components.url!,method: .get, headers: headers)
            .publishDecodable(type: IBAN.self)
            .value()
            .mapError { error -> Error in
                return error
            }
            .eraseToAnyPublisher()
    }
    
}
