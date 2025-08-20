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
        fetchAllCountriesUseCase: FetchAllCountriesUseCase
    ) {
        self.coordinator = coordinator
        self.factory = ViewModelFactory(coordinator: coordinator)
        self.fetchAllCountriesUseCase = fetchAllCountriesUseCase
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
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                self?.filterCountries(with: searchText)
            }
            .store(in: &cancellables)
        
        $countries
            .sink { [weak self] countries in
                self?.filterCountries(with: self?.searchText ?? "")
            }
            .store(in: &cancellables)
    }
    
    private func filterCountries(with searchText: String) {
        if searchText.count < 2 {
            filteredCountries = countries
        } else {
            filteredCountries = countries.filter {
                ($0.name?.common?.localizedCaseInsensitiveContains(searchText) ?? false) ||
                ($0.name?.official?.localizedCaseInsensitiveContains(searchText) ?? false)
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
