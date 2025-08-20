//
//  CountryRemoteDataSourceProtocol.swift
//  InterfellTC
//
//  Created by Brayan Munoz Campos on 20/08/25.
//

protocol CountryRemoteDataSourceProtocol {
    func fetchCountries(params: FetchCountriesParams) async throws -> [CountryResponse]
}
