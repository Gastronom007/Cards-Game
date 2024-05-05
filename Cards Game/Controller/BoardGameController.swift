//
//  BoardGameController.swift
//  Cards Game
//
//  Created by Gastronom on 5.05.24.
//

import UIKit

class BoardGameController: UIViewController {
    
    var cardsPairsCounts = 8
    lazy var game: Game = getNewGame()
    lazy var startButtonView = getStartButtonView()
    
    override func loadView() {
        super.loadView()
        view.addSubview(startButtonView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func getNewGame() -> Game {
        
        let game = Game()
        game.cardsCount = self.cardsPairsCounts
        game.generateCards()
        
        return game
    }
    
    private func getStartButtonView() -> UIButton {
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        
        button.center.x = view.center.x
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows[0]
        let topPadding = window?.safeAreaInsets.top
        button.frame.origin.y = topPadding!
        button.setTitle("Start game", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 10
        
        button.addTarget(nil, action: #selector(startGame(_:)), for: .touchUpInside)
        
        return button
    }
    
    @objc func startGame(_ sender: UIButton) {
        print("Button was pressed")
    }
    


}
