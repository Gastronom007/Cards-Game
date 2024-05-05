//
//  Game.swift
//  Cards Game
//
//  Created by Gastronom on 5.05.24.
//

import Foundation

class Game {
    
    var cardsCount = 0
    var cards = [Card]()
    
    // random cards array generation
    func generateCards() {
        var cards = [Card]()
        
        for _ in 0...cardsCount {
            let randomElement = (type: CardType.allCases.randomElement()!, color: CardColor.allCases.randomElement()!)
            cards.append(randomElement)
        }
        self.cards = cards
    }
    
    // equivalence check
    func checkCards(_ firstCard: Card, _ secondCard: Card) -> Bool {
        if firstCard == secondCard {
            return true
        }
        return false
    }
}
