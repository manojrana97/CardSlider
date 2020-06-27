//
//  TinderShuffleViewController.swift
//  CardSlider
//
//  Created by manoj on 25/06/20.
//  Copyright © 2020 Manoj. All rights reserved.
//

import UIKit
import Shuffle_iOS
import ObjectMapper

class TinderShuffleViewController: UIViewController {
    //MARK:- Properties
    var cardDetails:[CardDetail] = []
    let cardStack = SwipeCardStack()
    
    //MARK:- IBOutlets
    @IBOutlet weak private var swipableView:UIView!
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        cardDetails = CommonUtilities.getCardDetail()
        swipableView.addSubview(cardStack)
        cardStack.frame = view.frame
        cardStack.dataSource = self
    }
    
    
    @IBAction func showPreviousCardTapped(_ sender: UIButton) {
        cardStack.undoLastSwipe(animated: true)
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        cardStack.reloadData()
    }
    
    
    

    
    //MARK:- Swipeable Card creation
    func card(from text: String, pageNumber: Int) -> SwipeCard {
        let card = SwipeCard()
        card.swipeDirections = [.left, .right]
        let cardView = Bundle.main.loadNibNamed("CardView", owner: nil, options: nil)?[0] as? CardView
        cardView?.setCardDetails(text: text, pageNumber: "\(pageNumber)/\(self.cardDetails.count)")
        card.content = cardView!
        return card
    }
    
}

//MARK:- ShuffleCard DataSource
extension TinderShuffleViewController:SwipeCardStackDataSource{
    func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
        return card(from: cardDetails[index].text ?? "", pageNumber: index+1)
    }
    
    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
        return cardDetails.count
    }
    
    
}
