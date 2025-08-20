//
//  Country.swift
//  InterfellTC
//
//  Created by Brayan Munoz Campos on 20/08/25.
//

import Foundation

struct Country: Codable, Hashable {
    let flags: Flags?
    let name: Name?
    let currencies: [String: Currency]?
    let capital: [String]?
    let region: String?
    let subregion: String?
    let languages: [String: String]?
    let area: Double?
    let population: Int?
    let timezones: [String]?
    let car: Car?
    
    struct Flags: Codable, Hashable {
        let png: String?
        let svg: String?
        let alt: String?
    }

    struct Name: Codable, Hashable {
        let common: String?
        let official: String?
        let nativeName: [String: NativeName]?
        
        struct NativeName: Codable, Hashable {
            let official: String?
            let common: String?
        }
    }

    struct Currency: Codable, Hashable {
        let name: String?
        let symbol: String?
    }
    
    struct Car: Codable, Hashable {
        let side: String?
    }
    
    var formattedPopulation: String {
        guard let population = population else { return "N/A" }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: population)) ?? "\(population)"
    }
    
    var formattedLanguages: String {
        guard let languages = languages else { return "N/A" }
        return Array(languages.values).joined(separator: ", ")
    }
    
    var formattedArea: String {
        guard let area = area else { return "N/A" }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: area)) ?? "\(area)"
    }
    
    var formattedCurrencies: String {
        guard let currencies = currencies else { return "N/A" }
        return currencies.values.compactMap { currency in
            if let name = currency.name, let symbol = currency.symbol {
                return "\(name) (\(symbol))"
            }
            return currency.name
        }.joined(separator: ", ")
    }
    
    var formattedTimezones: String {
        guard let timezones = timezones else { return "N/A" }
        return timezones.joined(separator: ", ")
    }
}
