//
//  TicketListViewModel.swift
//  AviasalesCloneTestTask
//
//  Created by Leila Serebrova on 05.06.2024.
//

import Foundation

class TicketListViewModel: ObservableObject {
    enum Event {
        case goBack
    }

    @Published var route: Route
    @Published var ticketList: [TicketModel] = []

    var onAction: ((Event) -> Void)?
    
    var formattedDepartureDate: String {
        Self.formatDate(route.departureDate)
    }
    
    var ticketListProvider: TicketListProvider

    init(route: Route, ticketListProvider: TicketListProvider) {
        self.route = route
        self.ticketListProvider = ticketListProvider

        ticketListProvider.$tickets
            .assign(to: &$ticketList)
    }

    func flightDuration(for ticket: TicketModel) -> String {
        guard let departureDate = departureDate(for: ticket),
              let arrivalDate = arrivalDate(for: ticket) else { return "" }
        let duration = arrivalDate.timeIntervalSince(departureDate)
        let hours = Int(duration) / 3600
        return String(format: "%2d", hours)
    }

    func formattedDepartureTime(for ticket: TicketModel) -> String {
        guard let date = departureDate(for: ticket) else { return "" }
        return timeString(from: date)
    }

    func formattedArrivalTime(for ticket: TicketModel) -> String {
        guard let date = arrivalDate(for: ticket) else { return "" }
        return timeString(from: date)
    }
}

private extension TicketListViewModel {
    func departureDate(for ticket: TicketModel) -> Date? {
        return dateFromString(ticket.departure.date)
    }

    func arrivalDate(for ticket: TicketModel) -> Date? {
        return dateFromString(ticket.arrival.date)
    }

    func dateFromString(_ dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter.date(from: dateString)
    }

    func timeString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }

    static func formatDate(_ date: Date?) -> String {
        guard let date else { return "" }
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "dd MMMM"
        let formattedDate = formatter.string(from: date)
        return formattedDate.replacingOccurrences(of: ".", with: "")
    }
}
