//
//  Cards.swift
//  Cards Game
//
//  Created by Gastronom on 5.05.24.
//

import UIKit


protocol FlippableView: UIView {
    var isFlipped: Bool { get set }
    var flipCompletionHandler: ((FlippableView) -> Void)? { get set }
    func flip()
}

//MARK: CardView
class CardView<ShapeType: ShapeLayerProtocol> :UIView, FlippableView {
    
    private var margine: Int = 10
    var cornerRadius = 20
    private var anchorPointCard: CGPoint = CGPoint(x: 0, y: 0)
    private var startTouchPoint: CGPoint!
    
    lazy var frontSideView: UIView = self.getFrontSideView()
    lazy var backSideView: UIView = self.getBackSideView()
    
    var color: UIColor!
    
    var isFlipped:Bool = false {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var flipCompletionHandler: ((FlippableView) -> Void)? // Some code run after a card was flipped
    var moveSubviewTOFrontCompletionHandler: ((FlippableView) -> Void)?
    
    func flip() {
        
        // define between whitch views take place transition
        let fromView = isFlipped ? frontSideView : backSideView
        let toView = isFlipped ? backSideView : frontSideView
        
        // transition animation
        UIView.transition(from: fromView, to: toView, duration: 0.5, options: .transitionFlipFromTop) { _ in
            self.flipCompletionHandler?(self)
        }
        
        isFlipped = !isFlipped
    }
    
    // return view for a face side of a card
    private func getFrontSideView() -> UIView {
        
        // main view
        let view = UIView(frame: self.bounds)
        view.backgroundColor = .white
        
        // subview
        let shapeView = UIView(frame: CGRect(x: margine, y: margine, width: Int(self.bounds.width) - margine * 2, height: Int(self.bounds.height) - margine * 2))
        view.addSubview(shapeView)
        
        // creating a layer with a shape
        let shapeLayer = ShapeType(size: shapeView.frame.size, fillColor: color.cgColor)
        shapeView.layer.addSublayer(shapeLayer)
        
        view.layer.masksToBounds = true
        view.layer.cornerRadius = CGFloat(cornerRadius)
        
        return view
        
    }
    
    // return view for a back side of a card
    private func getBackSideView() -> UIView {
        
        let view = UIView(frame: self.bounds)
        view.backgroundColor = .white
        
        // random pattern selection for a back side a card
        switch ["circle", "line"].randomElement()! {
        case "circle" :
            let layer = BackSideCircle(size: self.bounds.size, fillColor: UIColor.black.cgColor)
            view.layer.addSublayer(layer)
        case "line":
            let layer = BackSideLine(size: self.bounds.size, fillColor: UIColor.black.cgColor)
            view.layer.addSublayer(layer)
        default:
            break
        }
        
        view.layer.masksToBounds = true
        view.layer.cornerRadius = CGFloat(cornerRadius)
        
        return view
    }
    
    private func setupBoards() {
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    override func draw(_ rect: CGRect) {
        backSideView.removeFromSuperview()
        frontSideView.removeFromSuperview()
        
        if isFlipped {
            self.addSubview(backSideView)
            self.addSubview(frontSideView)
        } else {
            self.addSubview(frontSideView)
            self.addSubview(backSideView)
        }
    }
    
    init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        self.color = color
        setupBoards()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        anchorPointCard.x = touches.first!.location(in: window).x - frame.minX
        anchorPointCard.y = touches.first!.location(in: window).y - frame.minY
        
//        self.moveSubviewTOFrontCompletionHandler?(self)
        
        startTouchPoint =  frame.origin
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.frame.origin.x = touches.first!.location(in: window).x - anchorPointCard.x
        self.frame.origin.y = touches.first!.location(in: window).y - anchorPointCard.y
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if self.frame.origin == startTouchPoint {
            flip()
        }
    }
    
}
