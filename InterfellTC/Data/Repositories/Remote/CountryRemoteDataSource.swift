//
//  CountryRemoteDataSource.swift
//  InterfellTC
//
//  Created by Brayan Munoz Campos on 20/08/25.
//

class CountryRemoteDataSource: CountryRemoteDataSourceProtocol {
    private let serviceManager: ServiceManager
    
    init(serviceManager: ServiceManager = ServiceManager()) {
        self.serviceManager = serviceManager
    }
    
    func fetchCountries(params: FetchCountriesParams) async throws -> [CountryResponse] {
        let request = CountriesApi.all(params: params)
        let response: FetchCountryResponse? = try await serviceManager.request(request, type: FetchCountryResponse.self)
        return response ?? []
    }
    
    func searchCountry(by text: String) async throws -> [CountryResponse] {
        let request = CountriesApi.byName(name: text, fullText: false)
        let response: FetchCountryResponse? = try await serviceManager.request(request, type: FetchCountryResponse.self)
        return response ?? []
    }
}
