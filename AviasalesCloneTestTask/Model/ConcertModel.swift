//
//  ConcertModel.swift
//  AviasalesCloneTestTask
//
//  Created by Leila Serebrova on 31.05.2024.
//

import Foundation

struct Response: Decodable {
    let offers: [ConcertModel]
}

struct ConcertModel: Decodable, Identifiable {
    let id: Int
    let title: String
    let town: String
    let price: PriceModel
}

struct PriceModel: Decodable {
    let value: Int
}
