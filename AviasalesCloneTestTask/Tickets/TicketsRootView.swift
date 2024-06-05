//
//  TicketsView.swift
//  AviasalesCloneTestTask
//
//  Created by Leila Serebrova on 31.05.2024.
//

import SwiftUI

struct TicketsRootView: View {
    @StateObject var viewModel: TicketsRootViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            title
            ticketSearchView
            musicalTripsView
            Spacer()
        }
        .background(Color.black)
    }
}

private extension TicketsRootView {
    var title: some View {
        Text("Поиск дешевых авиабилетов")
            .foregroundStyle(Color.white)
            .font(.system(size: 22, weight: .semibold))
            .frame(maxWidth: .infinity, alignment: .center)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 100)
    }

    var ticketSearchView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(Color.theme.grey3)
                .frame(height: 122)

            HStack(spacing: 16) {
                Image.local.magnifyingGlass
                    .foregroundColor(.gray)
                VStack(alignment: .leading) {
                    CyrillicTextField(
                        text: $viewModel.departure,
                        placeholder: "Откуда - Москва"
                    )
                    .frame(height: 21)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.theme.grey6)
                    CyrillicTextField(
                        text: $viewModel.arrival,
                        placeholder: "Куда - Турция",
                        onActivate: { viewModel.onAction?(.arrivalTextfieldActivated(viewModel.departure)) }
                    )
                    .frame(height: 21)
                }
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.theme.grey4)
                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
            )
            .padding(.horizontal, 16)
        }
        .padding(.top, 38)
        .padding(.horizontal, 16)
    }

    var musicalTripsView: some View {
        VStack(alignment: .leading) {
            Text("Музыкально отлететь")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color.white)
                .font(.system(size: 22, weight: .semibold))

            ScrollView(.horizontal) {
                HStack(spacing: 67) {
                    ForEach(viewModel.concerts) { concert in
                        concertView(
                            image: Image("\(concert.id)"),
                            title: concert.title,
                            city: concert.town,
                            price: NumberFormatter.formatPrice(concert.price.value)
                        )
                    }
                }
            }
            .padding(.top, 16)
        }
        .padding(.top, 32)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity)
    }

    func concertView(
        image: Image,
        title: String,
        city: String,
        price: String
    ) -> some View {
        Button(action: {
            viewModel.arrival = city
            viewModel.onAction?(
                .destinationChosen(
                    Route(
                        departure: viewModel.departure,
                        arrival: viewModel.arrival
                    )
                )
            )
        }, label: {
            VStack(spacing: 0) {
                image

                Text(title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(Color.white)
                    .font(.system(size: 16, weight: .semibold))
                    .padding(.top, 8)

                Text(city)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(Color.white)
                    .font(.system(size: 14))
                    .padding(.top, 4)

                HStack(spacing: 0) {
                    Image.local.airplane
                        .foregroundStyle(Color.theme.grey6)
                        .frame(width: 24, height: 24)

                    Text("от \(price) ₽")
                        .foregroundStyle(Color.white)
                        .font(.system(size: 14))
                    Spacer()
                }
            }
        })
    }
}
