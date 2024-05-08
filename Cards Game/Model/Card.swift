//
//  Card.swift
//  Cards Game
//
//  Created by Gastronom on 5.05.24.
//

import UIKit


enum CardType: CaseIterable {
    case circle
    case cross
    case square
    case fill
    case noFilledCircle
}

enum CardColor: CaseIterable {
    case red
    case green
    case black
    case gray
    case brown
    case yellow
    case purple
    case orange
}

typealias Card = (type: CardType, color: CardColor)
