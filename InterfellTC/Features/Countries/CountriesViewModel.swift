//
//  CountriesViewModel.swift
//  InterfellTC
//
//  Created by Brayan Munoz Campos on 20/08/25.
//

import SwiftUI
import Combine

class CountriesViewModel: ObservableObject {
    private let coordinator: Coordinator
    private let factory: ViewModelFactory
    private let fetchAllCountriesUseCase: FetchAllCountriesUseCase
    private let searchCountryByTextUseCase: SearchCountryByTextUseCase
    private var cancellables = Set<AnyCancellable>()
    
    @Published var searchText = ""
    @Published var countries: [Country] = []
    @Published var isLoading = false
    @Published var filteredCountries: [Country] = []
    
    var path: Binding<NavigationPath> {
        Binding(
            get: { self.coordinator.path },
            set: { self.coordinator.path = $0 }
        )
    }
    
    init(
        coordinator: Coordinator,
        fetchAllCountriesUseCase: FetchAllCountriesUseCase,
        searchCountryByTextUseCase: SearchCountryByTextUseCase
    ) {
        self.coordinator = coordinator
        self.factory = ViewModelFactory(coordinator: coordinator)
        self.fetchAllCountriesUseCase = fetchAllCountriesUseCase
        self.searchCountryByTextUseCase = searchCountryByTextUseCase
    }
    
    func onStart() {
        setupSearchFiltering()
        loadCountries()
    }
    
    private func loadCountries() {
        Task { @MainActor [weak self] in
            guard let self else { return }
            
            isLoading = true
            defer { isLoading = false }
            
            do {
                let request = FetchCountriesParams.all
                let loadedCountries = try await fetchAllCountriesUseCase.execute(request)
                self.countries = loadedCountries
            } catch let error {
                print("Error loading countries: \(error)")
                self.countries = []
            }
        }
    }
    
    private func setupSearchFiltering() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                self?.handleSearch(with: searchText)
            }
            .store(in: &cancellables)
    }
    
    private func handleSearch(with searchText: String) {
        if searchText.count < 2 {
            loadCountries()
        } else {
            searchCountries(with: searchText)
        }
    }
    
    private func searchCountries(with searchText: String) {
        Task { @MainActor [weak self] in
            guard let self else { return }
            
            isLoading = true
            defer { isLoading = false }
            
            do {
                let loadedCountries = try await searchCountryByTextUseCase.execute(searchText)
                self.countries = loadedCountries
            } catch let error {
                print("Error loading countries: \(error)")
                self.countries = []
            }
        }
    }
    
    @ViewBuilder
    func buildDestination(for route: Route) -> some View {
        switch route {
        case .countryDetail(let country):
            CountryDetailView(viewModel: factory.makeCountryDetailViewModel(country: country))
        default:
            AnyView(EmptyView())
        }
    }
    
    func navigateToCountryDetail(_ country: Country) {
        coordinator.push(.countryDetail(country))
    }
}
