//
//  TicketListView.swift
//  AviasalesCloneTestTask
//
//  Created by Leila Serebrova on 05.06.2024.
//

import SwiftUI

struct TicketListView: View {
    @StateObject var viewModel: TicketListViewModel

    var body: some View {
        VStack {
            navigationView
            ScrollView {
                ticketsList
            }
            Spacer()
        }
        .padding(16)
        .background(Color.black)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

extension TicketListView {
    var navigationView: some View {
        HStack(spacing: 8) {
            Button(action: {
                viewModel.onAction?(.goBack)
            }, label: {
                Image.local.arrowLeft
                    .foregroundStyle(Color.theme.blue)
            })
            VStack(alignment: .leading, spacing: 4) {
                Text("\(viewModel.route.departure)-\(viewModel.route.arrival)")
                    .foregroundStyle(.white)
                    .font(.system(size: 16, weight: .semibold))
                Text("\(viewModel.formattedDepartureDate), 1 пассажир")
                    .foregroundStyle(Color.theme.grey6)
                    .font(.system(size: 14, weight: .medium))
            }
            Spacer()
        }
        .padding(8)
        .background(
            Rectangle()
                .fill(Color.theme.grey2)
        )
    }

    var ticketsList: some View {
        VStack {
            ForEach(viewModel.ticketList) { ticket in
                ZStack(alignment: .topLeading) {
                    ticketCardView(
                        price: NumberFormatter.formatPrice(ticket.price.value),
                        departureTime: viewModel.formattedDepartureTime(for: ticket),
                        arrivalTime: viewModel.formattedArrivalTime(for: ticket),
                        departureAirport: ticket.departure.airport,
                        arrivalAirport: ticket.arrival.airport,
                        timeInFlight: viewModel.flightDuration(for: ticket),
                        isBadged: ticket.badge != nil
                    )
                    .padding(.top, ticket.badge == nil ? 0 : 8)

                    if let badge = ticket.badge {
                        badgeView(badgeTitle: badge)
                    }
                }
            }
        }
        .padding(.top, 25)
        .frame(maxWidth: .infinity)
    }

    func badgeView(badgeTitle: String) -> some View {
        Text(badgeTitle)
            .padding(.vertical, 2)
            .padding(.horizontal, 10)
            .foregroundStyle(.white)
            .font(.system(size: 14, weight: .medium))
            .italic()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.theme.blue)
            )
    }

    func ticketCardView(
        price: String,
        departureTime: String,
        arrivalTime: String,
        departureAirport: String,
        arrivalAirport: String,
        timeInFlight: String,
        isBadged: Bool
    ) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("\(price) ₽")
                .foregroundStyle(.white)
                .font(.system(size: 22, weight: .semibold))

            HStack(spacing: 8) {
                Circle()
                    .foregroundStyle(Color.theme.red)
                    .frame(width: 24, height: 24)
                HStack(alignment: .top, spacing: 0) {
                    VStack {
                        Text(departureTime)
                            .foregroundStyle(.white)
                            .font(.system(size: 14, weight: .medium))
                            .italic()
                        Text(departureAirport)
                            .foregroundStyle(Color.theme.grey6)
                            .font(.system(size: 14, weight: .medium))
                            .italic()
                    }

                    Text(" - ")
                        .foregroundStyle(Color.theme.grey6)
                        .font(.system(size: 14, weight: .medium))
                        .italic()

                    VStack {
                        Text(arrivalTime)
                            .foregroundStyle(.white)
                            .font(.system(size: 14, weight: .medium))
                            .italic()
                        Text(arrivalAirport)
                            .foregroundStyle(Color.theme.grey6)
                            .font(.system(size: 14, weight: .medium))
                            .italic()
                    }

                    Text("\(timeInFlight)ч в пути / Без пересадок")
                        .foregroundStyle(.white)
                        .font(.system(size: 14))
                        .frame(maxWidth: .infinity)
                        .padding(.leading, 16)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
        .padding(.top, isBadged ? 21 : 16)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.theme.grey1)
        )
    }
}
