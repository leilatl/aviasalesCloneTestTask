//
//  ConcertProvider.swift
//  AviasalesCloneTestTask
//
//  Created by Leila Serebrova on 31.05.2024.
//

import Combine
import Foundation

class ConcertProvider {
    @Published var concerts: [ConcertModel] = []

    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchConcerts()
    }

    private func fetchConcerts() {
        guard let url = URL(string: "https://run.mocky.io/v3/214a1713-bac0-4853-907c-a1dfc3cd05fd") else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Response.self, decoder: JSONDecoder())
            .map(\.offers)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            }, receiveValue: { [weak self] receivedConcerts in
                self?.concerts = receivedConcerts
            })
            .store(in: &cancellables)
    }
}
