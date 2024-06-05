//
//  TicketListProvider.swift
//  AviasalesCloneTestTask
//
//  Created by Leila Serebrova on 05.06.2024.
//

import Combine
import Foundation

class TicketListProvider {
    @Published var tickets: [TicketModel] = []

    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchTickets()
    }

    private func fetchTickets() {
        guard let url = URL(string: "https://run.mocky.io/v3/670c3d56-7f03-4237-9e34-d437a9e56ebf") else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: TicketListResponse.self, decoder: JSONDecoder())
            .map(\.tickets)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    print("Error: \(error)")
                }
            }, receiveValue: { [weak self] receivedTickets in
                self?.tickets = receivedTickets
            })
            .store(in: &cancellables)
    }
}
