//
//  IbanModel.swift
//  KFH Test
//
//  Created by Mohammed Abid on 8/16/23.
//

import Foundation

// MARK: - Welcome
struct IBAN: Codable {
    //    let bankData: BankData
    //    let countryIbanExample
    //    let iban: String
    //    let ibanData: IbanData
    let valid: Bool
    
    //    enum CodingKeys: String, CodingKey {
    //        case bankData = "bank_data"
    //        case countryIbanExample = "country_iban_example"
    //        case iban
    //        case ibanData = "iban_data"
    //        case valid
    //    }
}

// MARK: - BankData
struct BankData: Codable {
    let bankCode, bic, city, name: String
    let zip: String
    
    enum CodingKeys: String, CodingKey {
        case bankCode = "bank_code"
        case bic, city, name, zip
    }
}

// MARK: - IbanData
struct IbanData: Codable {
    let bban, accountNumber, bankCode, branch: String
    let checksum, country, countryCode, countryIbanFormatAsRegex: String
    let countryIbanFormatAsSwift, nationalChecksum: String
    let sepaCountry: Bool
    
    enum CodingKeys: String, CodingKey {
        case bban = "BBAN"
        case accountNumber = "account_number"
        case bankCode = "bank_code"
        case branch, checksum, country
        case countryCode = "country_code"
        case countryIbanFormatAsRegex = "country_iban_format_as_regex"
        case countryIbanFormatAsSwift = "country_iban_format_as_swift"
        case nationalChecksum = "national_checksum"
        case sepaCountry = "sepa_country"
    }
}
