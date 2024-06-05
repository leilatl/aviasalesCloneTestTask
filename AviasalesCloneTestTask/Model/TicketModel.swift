//
//  TicketModel.swift
//  AviasalesCloneTestTask
//
//  Created by Leila Serebrova on 05.06.2024.
//

import Foundation

struct TicketListResponse: Decodable {
    let tickets: [TicketModel]
}

struct TicketModel: Decodable, Identifiable {
    let id: Int
    let badge: String?
    let price: PriceModel
    let provider_name: String
    let company: String
    let departure: FlightInfo
    let arrival: FlightInfo
    let has_transfer: Bool
    let has_visa_transfer: Bool
    let luggage: Luggage
    let hand_luggage: HandLuggage
    let is_returnable: Bool
    let is_exchangable: Bool
}

struct FlightInfo: Decodable {
    let town: String
    let date: String
    let airport: String
}

struct Luggage: Decodable {
    let has_luggage: Bool
    let price: PriceModel?
}

struct HandLuggage: Decodable {
    let has_hand_luggage: Bool
    let size: String?
}
