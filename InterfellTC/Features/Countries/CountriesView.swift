//
//  CountriesView.swift
//  InterfellTC
//
//  Created by Brayan Munoz Campos on 19/08/25.
//

import SwiftUI

struct CountriesView: View {
    @ObservedObject var viewModel: CountriesViewModel
    
    var body: some View {
        NavigationStack(path: viewModel.path) {
            VStack {
                searchField
                countriesList
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(.init("**Countries**"))
                        .foregroundStyle(.black)
                }
            }
            .navigationDestination(for: Route.self) { route in
                viewModel.buildDestination(for: route)
            }
            .onAppear {
                viewModel.onStart()
            }
        }
    }
    
    private var searchField: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Search", text: $viewModel.searchText)
                .textFieldStyle(.plain)
            
            Image(systemName: "mic.fill")
                .foregroundColor(.gray)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal, 16)
    }
    
    private var countriesList: some View {
        List {
            ForEach(viewModel.countries, id: \.self) { country in
                CountryItemView(
                    country: country,
                    tapAction: {
                        viewModel.navigateToCountryDetail(country)
                    }
                )
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .background(Color.white)
    }
}

#Preview {
    CountriesView(
        viewModel: ViewModelFactory(coordinator: Coordinator()).makeCountriesViewModel()
    )
}
