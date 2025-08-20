//
//  CountryRepositoryProtocol.swift
//  InterfellTC
//
//  Created by Brayan Munoz Campos on 20/08/25.
//

protocol CountryRepositoryProtocol {
    func fetchCountries(params: FetchCountriesParams) async throws -> [Country]
}
