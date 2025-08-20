//
//  CountryItemView.swift
//  InterfellTC
//
//  Created by Brayan Munoz Campos on 20/08/25.
//

import SwiftUI

struct CountryItemView: View {
    private let country: Country
    private let tapAction: () -> Void
    
    init(country: Country, tapAction: @escaping () -> Void) {
        self.country = country
        self.tapAction = tapAction
    }
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: country.flags?.png ?? "")) { image in
                image
                    .resizable()
                    .frame(width: 120, height: 40)
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.3))
                    .overlay(
                        ProgressView()
                            .scaleEffect(0.5)
                    )
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(country.name?.common ?? "")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(country.name?.official ?? "")
                    .font(.subheadline)
                    .foregroundColor(.primary)
                
                Text(country.capital?.first ?? "N/A")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .onTapGesture {
            tapAction()
        }
    }
}

#Preview {
    CountryItemView(
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
        ), tapAction: {
            // empty
        }
    )
}
