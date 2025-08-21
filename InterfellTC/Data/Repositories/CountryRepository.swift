//
//  CountryRepository.swift
//  InterfellTC
//
//  Created by Brayan Munoz Campos on 20/08/25.
//

class CountryRepository: CountryRepositoryProtocol {
    private let remoteDataSource: CountryRemoteDataSourceProtocol
    
    init(remoteDataSource: CountryRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    func fetchCountries(params: FetchCountriesParams) async throws -> [Country] {
        let countryResponses = try await remoteDataSource.fetchCountries(params: params)
        
        let countries: [Country] = countryResponses.compactMap { countryResponse in
            countryResponse.toDomain()
        }
        
        return countries
    }
    
    func searchCountry(by text: String) async throws -> [Country] {
        let countryResponses = try await remoteDataSource.searchCountry(by: text)
        
        let countries: [Country] = countryResponses.compactMap { countryResponse in
            countryResponse.toDomain()
        }
        
        return countries
    }
}
