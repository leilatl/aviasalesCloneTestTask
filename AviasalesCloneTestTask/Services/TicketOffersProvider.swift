//
//  TicketOffersProvider.swift
//  AviasalesCloneTestTask
//
//  Created by Leila Serebrova on 05.06.2024.
//

import Combine
import Foundation

class TicketOffersProvider {
    @Published var ticketOffers: [TicketOfferModel] = []

    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchTickets()
    }

    private func fetchTickets() {
        guard let url = URL(string: "https://run.mocky.io/v3/7e55bf02-89ff-4847-9eb7-7d83ef884017") else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: TicketOfferResponse.self, decoder: JSONDecoder())
            .map(\.tickets_offers)
            .map { Array($0.prefix(3)) } 
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            }, receiveValue: { [weak self] receivedOffers in
                self?.ticketOffers = receivedOffers
            })
            .store(in: &cancellables)
    }
}
