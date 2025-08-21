//
//  SearchCountryByTextUseCase.swift
//  InterfellTC
//
//  Created by Brayan Munoz Campos on 20/08/25.
//

class SearchCountryByTextUseCase: UseCase {
    typealias Input = String
    typealias Output = [Country]
    
    private let repository: CountryRepositoryProtocol
    
    init(repository: CountryRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(_ input: String) async throws -> [Country] {
        try await repository.searchCountry(by: input)
    }
}
