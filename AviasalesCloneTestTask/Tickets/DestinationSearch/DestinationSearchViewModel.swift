//
//  TicketSearchViewModel.swift
//  AviasalesCloneTestTask
//
//  Created by Leila Serebrova on 04.06.2024.
//

import Combine
import Foundation

class DestinationSearchViewModel: ObservableObject {
    enum Event {
        case difficultRouteChosen
        case holidaysChosen
        case hotTicketsChosen
        case destinationChosen(Route)
    }
    
    @Published var departure: String
    @Published var arrival: String = ""

    var onAction: ((Event) -> Void)?

    init(departure: String) {
        self.departure = departure
    }
}
