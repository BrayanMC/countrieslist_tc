//
//  ViewModelFactory.swift
//  InterfellTC
//
//  Created by Brayan Munoz Campos on 20/08/25.
//

protocol ViewModelFactoryProtocol {
    func makeHomeMainViewModel() -> HomeMainViewModel
    func makeCountriesViewModel(displayType: CountriesDisplayType) -> CountriesViewModel
    func makeCountryDetailViewModel(country: Country) -> CountryDetailViewModel
}

class ViewModelFactory: ViewModelFactoryProtocol {
    private let coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func makeHomeMainViewModel() -> HomeMainViewModel {
        HomeMainViewModel(coordinator: coordinator)
    }
    
    func makeCountriesViewModel(displayType: CountriesDisplayType = .overview) -> CountriesViewModel {
        let countryRemoteDataSource: CountryRemoteDataSourceProtocol = CountryRemoteDataSource()
        let repository: CountryRepositoryProtocol = CountryRepository(remoteDataSource: countryRemoteDataSource)
        let fetchAllCountriesUseCase = FetchAllCountriesUseCase(repository: repository)
        return CountriesViewModel(
            coordinator: coordinator,
            fetchAllCountriesUseCase: fetchAllCountriesUseCase
        )
    }
    
    func makeCountryDetailViewModel(country: Country) -> CountryDetailViewModel {
        CountryDetailViewModel(country: country, coordinator: coordinator)
    }
}
