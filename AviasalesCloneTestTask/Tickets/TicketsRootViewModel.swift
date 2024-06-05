//
//  TicketsViewModel.swift
//  AviasalesCloneTestTask
//
//  Created by Leila Serebrova on 31.05.2024.
//

import Combine
import Foundation

class TicketsRootViewModel: ObservableObject {
    enum Event {
        case arrivalTextfieldActivated(String)
        case destinationChosen(Route)
    }

    @Published var concerts: [ConcertModel] = []
    @Published var arrival: String = ""
    @Published var departure: String {
        didSet {
            UserDefaultsService.shared.set(value: departure, for: .departure)
        }
    }

    var onAction: ((Event) -> Void)?
    var concertProvider: ConcertProvider
    
    private var cancellables = Set<AnyCancellable>()

    init(concertProvider: ConcertProvider) {
        self.departure = UserDefaultsService.shared.get(for: .departure, defaultValue: "")
        self.concertProvider = concertProvider

        concertProvider.$concerts
            .assign(to: &$concerts)
    }
}
