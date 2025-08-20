//
//  FetchAllCountriesUseCase.swift
//  InterfellTC
//
//  Created by Brayan Munoz Campos on 20/08/25.
//

class FetchAllCountriesUseCase: UseCase {
    typealias Input = FetchCountriesParams
    typealias Output = [Country]
    
    private let repository: CountryRepositoryProtocol
    
    init(repository: CountryRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(_ input: FetchCountriesParams) async throws -> [Country] {
        try await repository.fetchCountries(params: input)
    }
}
