//
//  TicketOfferModel.swift
//  AviasalesCloneTestTask
//
//  Created by Leila Serebrova on 05.06.2024.
//

import Foundation

struct TicketOfferResponse: Decodable {
    let tickets_offers: [TicketOfferModel]
}

struct TicketOfferModel: Decodable, Identifiable {
    let id: Int
    let title: String
    let time_range: [String]
    let price: PriceModel
}
