//
//  DestinationSearchView.swift
//  AviasalesCloneTestTask
//
//  Created by Leila Serebrova on 04.06.2024.
//

import SwiftUI

struct DestinationSearchView: View {
    @StateObject var viewModel: DestinationSearchViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            dragBarView
            ticketSearchView
            hintsView
            destinationsListView
            Spacer()
        }
        .background(Color.theme.grey2)
    }
}

extension DestinationSearchView {
    var dragBarView: some View {
        RoundedRectangle(cornerRadius: 2)
            .frame(width: 38, height: 4)
            .foregroundStyle(Color.theme.grey6)
            .padding(.top, 16)
    }

    var ticketSearchView: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                Image.local.flyingAirplane
                    .foregroundStyle(Color.theme.grey6)
                CyrillicTextField(
                    text: $viewModel.departure,
                    placeholder: "Откуда - Москва"
                )
                .frame(height: 21)
            }

            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.theme.grey4)

            HStack(spacing: 8) {
                Image.local.magnifyingGlass
                    .foregroundStyle(.white)

                CyrillicTextField(
                    text: $viewModel.arrival,
                    placeholder: "Куда - Турция",
                    onEnter: {
                        if !viewModel.arrival.isEmpty {
                            viewModel.onAction?(.destinationChosen(
                                Route(departure: viewModel.departure, arrival: viewModel.arrival)
                            ))
                        }
                    }
                )
                .frame(height: 21)

                Button(
                    action: {
                        viewModel.arrival = ""
                    }, label: {
                        Image.local.close
                            .foregroundStyle(.white)
                    })
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.theme.grey3)
                .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
        )
        .padding(.horizontal, 16)
        .padding(.top, 30)
    }

    var hintsView: some View {
        HStack(alignment: .top) {
            hintView(
                image: Image.local.difficultRoute,
                color: Color.theme.green,
                title: "Сложный маршрут",
                action: { viewModel.onAction?(.difficultRouteChosen) }
            )
            hintView(
                image: Image.local.globe,
                color: Color.theme.blue,
                title: "Куда угодно",
                action: {
                    viewModel.arrival = "Куда угодно"
                    viewModel.onAction?(
                        .destinationChosen(
                            Route(
                                departure: viewModel.departure,
                                arrival: "Куда угодно")
                        )
                    )
                }
            )
            hintView(
                image: Image.local.holiday,
                color: Color.theme.darkBlue,
                title: "Выходные",
                action: { viewModel.onAction?(.holidaysChosen) }
            )
            hintView(
                image: Image.local.flame,
                color: Color.theme.red,
                title: "Горячие билеты",
                action: { viewModel.onAction?(.hotTicketsChosen) }
            )
        }
        .padding(.top, 26)
    }

    func hintView(
        image: Image,
        color: Color,
        title: String,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: {
            action()
        }, label: {
            VStack(spacing: 8) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(color)
                        .frame(width: 50, height: 50)

                    image
                        .foregroundStyle(.white)
                }
                Text(title)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 14))
            }
            .frame(width: 90)
        })
    }

    var destinationsListView: some View {
        VStack {
            destinationView(
                image: Image.local.stambul,
                destinationTitle: "Стамбул",
                destinationSubtitle: "Популярное направление"
            )
            destinationView(
                image: Image.local.sochi,
                destinationTitle: "Cочи",
                destinationSubtitle: "Популярное направление"
            )
            destinationView(
                image: Image.local.phuket,
                destinationTitle: "Пхукет",
                destinationSubtitle: "Популярное направление"
            )
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.theme.grey3)
        )
        .padding(.horizontal, 16)
        .padding(.top, 26)
    }

    func destinationView(
        image: Image,
        destinationTitle: String,
        destinationSubtitle: String
    ) -> some View {
        Button(action: {
            viewModel.arrival = destinationTitle
            viewModel.onAction?(
                .destinationChosen(
                    Route(
                        departure: viewModel.departure,
                        arrival: viewModel.arrival)
                )
            )
        }, label: {
            VStack {
                HStack {
                    image
                    VStack(alignment: .leading) {
                        Text(destinationTitle)
                            .foregroundStyle(.white)
                            .font(.system(size: 16, weight: .semibold))
                        Text(destinationSubtitle)
                            .foregroundStyle(Color.theme.grey5)
                            .font(.system(size: 14))
                    }
                    Spacer()
                }
                Rectangle()
                    .foregroundStyle(Color.theme.grey4)
                    .frame(height: 1)
            }
        })
    }
}
