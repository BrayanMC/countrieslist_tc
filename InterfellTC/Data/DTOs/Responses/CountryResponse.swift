//
//  CountryResponse.swift
//  InterfellTC
//
//  Created by Brayan Munoz Campos on 20/08/25.
//

typealias FetchCountryResponse = [CountryResponse]

struct CountryResponse: APIResponseConvertible {
    let flags: FlagsResponse?
    let name: NameResponse?
    let currencies: [String: CurrencyResponse]?
    let capital: [String]?
    let region: String?
    let subregion: String?
    let languages: [String: String]?
    let area: Double?
    let population: Int?
    let timezones: [String]?
    let car: CarResponse?
    
    struct FlagsResponse: Codable {
        let png: String?
        let svg: String?
        let alt: String?
    }

    struct NameResponse: Codable {
        let common: String?
        let official: String?
        let nativeName: [String: NativeNameResponse]?
        
        struct NativeNameResponse: Codable {
            let official: String?
            let common: String?
        }
    }

    struct CurrencyResponse: Codable {
        let name: String?
        let symbol: String?
    }
    
    struct CarResponse: Codable {
        let side: String?
    }
}
