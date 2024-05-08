//
//  CardViewFactory.swift
//  Cards Game
//
//  Created by Gastronom on 6.05.24.
//

import UIKit

class CardViewFactory {
    
    func get(_ shape: CardType, withSize size: CGSize, andColor color: CardColor) -> UIView {
        let frame = CGRect(origin: .zero, size: size)
        let viewColor = getViewColorBy(modelColor: color)
        
        // generate and return a card
        switch shape {
        case .circle:
            return CardView<CircleShape>(frame: frame, color: viewColor)
        case .cross:
            return CardView<CrossShape>(frame: frame, color: viewColor)
        case .square:
            return CardView<SquareShape>(frame: frame, color: viewColor)
        case .fill:
            return CardView<FillShape>(frame: frame, color: viewColor)
        case .noFilledCircle:
            return CardView<NoFilledCircle>(frame: frame, color: viewColor)
        }
    }
    
    private func getViewColorBy(modelColor: CardColor) -> UIColor {
        
        // convertion model color to view color
        switch modelColor {
        case .black:
            return .black
        case .red:
            return .red
        case .green:
            return .green
        case .gray:
            return .gray
        case .brown:
            return .brown
        case .yellow:
            return .yellow
        case .purple:
            return .purple
        case .orange:
            return .orange
        }
    }
}
