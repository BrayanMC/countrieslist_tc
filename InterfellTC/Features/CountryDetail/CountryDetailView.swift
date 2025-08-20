//
//  CountryDetailView.swift
//  InterfellTC
//
//  Created by Brayan Munoz Campos on 20/08/25.
//

import SwiftUI

struct CountryDetailView: View {
    @ObservedObject var viewModel: CountryDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                countryHeader
                countryInfoSection
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 20)
        }
        .ignoresSafeArea(edges: .bottom)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    viewModel.back()
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "chevron.backward")
                        Text("Countries")
                    }
                    .foregroundColor(.blue)
                }
            }
        }
    }
    
    private var countryHeader: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                AsyncImage(url: URL(string: viewModel.country.flags?.png ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.3))
                        .overlay(ProgressView())
                }
                .frame(width: 120, height: 80)
                
                Text(viewModel.country.name?.common ?? "")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(viewModel.country.name?.official ?? "")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
    }
    
    private var countryInfoSection: some View {
        VStack(spacing: 16) {
            HStack(alignment: .top, spacing: 20) {
                VStack(alignment: .leading, spacing: 12) {
                    coatOfArms
                    regionRow
                    subregionRow
                    capitalRow
                    areaRow
                }
                
                VStack(spacing: 12) {
                    populationRow
                    languagesRow
                    carDriverSideRow
                    currenciesRow
                    timezonesRow
                }
            }
        }
    }
    
    private var coatOfArms: some View {
        HStack {
            VStack(spacing: 8) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.blue.opacity(0.1))
                    .frame(width: 60, height: 60)
                    .overlay(
                        Image(systemName: "shield.fill")
                            .font(.title)
                            .foregroundColor(.blue)
                    )
                
                Text("Coat of Arms")
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            
            Spacer()
        }
    }
    
    private var populationRow: some View {
        InfoRowView(label: "Population", value: viewModel.country.formattedPopulation)
    }
    
    private var languagesRow: some View {
        InfoRowView(label: "Language(s)", value: viewModel.country.formattedLanguages)
    }
    
    private var carDriverSideRow: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Car Driver Side")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                
                HStack(spacing: 8) {
                    Text("LEFT")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(
                            (viewModel.country.car?.side?.lowercased() == "left") ? .primary : .secondary
                        )
                    
                    Image(systemName: "car.fill")
                        .font(.caption)
                        .foregroundColor(.primary)
                    
                    Text("RIGHT")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(
                            (viewModel.country.car?.side?.lowercased() == "right") ? .primary : .secondary
                        )
                }
            }
            
            Spacer()
        }
    }
    
    private var regionRow: some View {
        InfoRowView(label: "Region", value: viewModel.country.region ?? "N/A")
    }
    
    private var subregionRow: some View {
        InfoRowView(label: "Subregion", value: viewModel.country.subregion ?? "N/A")
    }
    
    private var capitalRow: some View {
        InfoRowView(label: "Capital", value: viewModel.country.capital?.first ?? "N/A")
    }
    
    private var areaRow: some View {
        InfoRowView(label: "Area", value: viewModel.country.formattedArea)
    }
    
    private var currenciesRow: some View {
        InfoRowView(label: "Currencies", value: viewModel.country.formattedCurrencies)
    }
    
    private var timezonesRow: some View {
        InfoRowView(label: "Timezone(s)", value: viewModel.country.formattedTimezones)
    }
}

#Preview {
    NavigationStack {
        CountryDetailView(
            viewModel: ViewModelFactory(coordinator: Coordinator()).makeCountryDetailViewModel(
                country: Country(
                    flags: Country.Flags(
                        png: "https://flagcdn.com/w320/tn.png",
                        svg: "https://flagcdn.com/tn.svg",
                        alt: "The flag of Tunisia has a red field. A white circle bearing a five-pointed red star within a fly-side facing red crescent is situated at the center of the field."
                    ),
                    name: Country.Name(
                        common: "Tunisia",
                        official: "Tunisian Republic",
                        nativeName: [
                            "ara": Country.Name.NativeName(
                                official: "الجمهورية التونسية",
                                common: "تونس"
                            )
                        ]
                    ),
                    currencies: [
                        "TND": Country.Currency(
                            name: "Tunisian dinar",
                            symbol: "د.ت"
                        )
                    ],
                    capital: ["Tunis"],
                    region: "Africa",
                    subregion: "Northern Africa",
                    languages: ["ara": "Arabic"],
                    area: 163610,
                    population: 11818618,
                    timezones: ["UTC+01:00"],
                    car: Country.Car(
                        side: "LEFT"
                    )
                )
            )
        )
    }
}
