//
//  Image.swift
//  AviasalesCloneTestTask
//
//  Created by Leila Serebrova on 05.06.2024.
//

import SwiftUI

extension Image {
    static let local = LocalImages()
}

struct LocalImages {
    let airplane = Image("airplane")
    let arrowRight = Image("arrow_right")
    let arrows = Image("arrows")
    let bell = Image("bell")
    let difficultRoute = Image("difficult_route")
    let filter = Image("filter")
    let flame = Image("flame")
    let flyingAirplane = Image("flying_airplane")
    let globe = Image("globe")
    let holiday = Image("holiday")
    let hotels = Image("hotels")
    let magnifyingGlass = Image("magnifying_glass")
    let pinIcon = Image("pin_icon")
    let profile = Image("profile")
    let plane = Image("plane")
    let phuket = Image("Пхукет")
    let sochi = Image("Сочи")
    let stambul = Image("Стамбул")
    let close = Image(systemName: "xmark")
    let arrowLeft = Image(systemName: "arrow.left")
    let plus = Image(systemName: "plus")
}
