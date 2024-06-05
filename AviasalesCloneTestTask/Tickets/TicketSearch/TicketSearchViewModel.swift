//
//  TicketSearchViewModel.swift
//  AviasalesCloneTestTask
//
//  Created by Leila Serebrova on 04.06.2024.
//

import Foundation
import SwiftUI

class TicketSearchViewModel: ObservableObject {
    enum Event {
        case goBack
        case goToTicketsList
    }

    @Published var route: Route
    var formattedDepartureDate: String {
        Self.formatDate(route.departureDate)
    }
    var formattedDepartureDateWeek: String {
        Self.formatDateWeek(route.departureDate)
    }
    var formattedReturnDate: String {
        Self.formatDate(route.returnDate)
    }
    var formattedReturnDateWeek: String {
        Self.formatDateWeek(route.returnDate)
    }
    var onAction: ((Event) -> Void)?
    
    var returnDateBinding: Binding<Date> {
        Binding(
            get: { self.route.returnDate ?? Date() },
            set: { self.route.returnDate = $0 }
        )
    }
    var departureDateBinding: Binding<Date> {
        Binding(
            get: { self.route.departureDate ?? Date() },
            set: { self.route.departureDate = $0 }
        )
    }

    @Published var ticketOffers: [TicketOfferModel] = []
    var ticketOffersProvider: TicketOffersProvider

    init(route: Route, ticketOffersProvider: TicketOffersProvider) {
        self.route = route
        self.ticketOffersProvider = ticketOffersProvider
        self.route.departureDate = Date()
        
        ticketOffersProvider.$ticketOffers
            .assign(to: &$ticketOffers)
    }
    
    func swapRoute() {
        let oldArrival = route.arrival
        route.arrival = route.departure
        route.departure = oldArrival
    }
    
    func ticketColor(for ticketOffer: TicketOfferModel) -> Color {
        if ticketOffer.id == 1 {
            return Color.theme.red
        } else if ticketOffer.id == 10 {
            return Color.theme.blue
        } else {
            return Color.white
        }
    }
}

private extension TicketSearchViewModel {
    static func formatDate(_ date: Date?) -> String {
        guard let date else { return "" }
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "dd MMM"
        let formattedDate = formatter.string(from: date)
        return formattedDate.replacingOccurrences(of: ".", with: "")
    }

    static func formatDateWeek(_ date: Date?) -> String {
        guard let date else { return "" }
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "E"
        return formatter.string(from: date).lowercased()
    }
}
