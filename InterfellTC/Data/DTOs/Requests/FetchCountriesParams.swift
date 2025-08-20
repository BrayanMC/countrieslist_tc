//
//  FetchCountriesParams.swift
//  InterfellTC
//
//  Created by Brayan Munoz Campos on 20/08/25.
//

struct FetchCountriesParams {
    let fields: [CountryField]?
    
    init(fields: [CountryField]? = nil) {
        self.fields = fields
    }
    
    static var all: FetchCountriesParams {
        FetchCountriesParams(
            fields: [
                .name,
                .flags,
                .capital,
                .area,
                .population,
                .languages,
                .region,
                .subregion,
                .timezones,
                .currencies
            ]
        )
    }
    
    var fieldsAsStrings: [String]? {
        return fields?.map { $0.stringValue }
    }
}
