//
//  CountryField.swift
//  InterfellTC
//
//  Created by Brayan Munoz Campos on 20/08/25.
//

enum CountryField: String, CaseIterable {
    case name = "name"
    case flags = "flags"
    case capital = "capital"
    case area = "area"
    case population = "population"
    case languages = "languages"
    case region = "region"
    case subregion = "subregion"
    case timezones = "timezones"
    case currencies = "currencies"
    
    var stringValue: String {
        return self.rawValue
    }
}
