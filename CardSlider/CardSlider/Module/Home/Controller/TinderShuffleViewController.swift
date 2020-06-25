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
        getCardDetail()
        swipableView.addSubview(cardStack)
        cardStack.frame = view.frame
        cardStack.dataSource = self
    }
    
    //MARK:- IBActions
    @IBAction func dislikeButtonTapped(_ sender: UIButton) {
        cardStack.swipe(.left, animated: true)
    }
    
    @IBAction func showPreviousCardTapped(_ sender: UIButton) {
        cardStack.undoLastSwipe(animated: true)
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        cardStack.swipe(.right, animated: true)
    }
    
    
    
    //MARK:- Json parsing
    private func getCardDetail(){
        let path = Bundle.main.path(forResource: "CardDetails", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        
        let fileData = try? Data(contentsOf: url)
        if let data = fileData {
            var urlStr = String(data: data, encoding: String.Encoding.utf8)
            urlStr!.remove(at: urlStr!.startIndex)
            guard let data = urlStr!.data(using: .utf8) else {return}
            print(data)
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                self.cardDetails = parseJson(anyObj: json as AnyObject)
            } catch let error {
                print(error)
            }
        } else {
            print("data error")
        }
        
        
    }
    
    func parseJson(anyObj:AnyObject) -> Array<CardDetail>{
        print(anyObj["data"] as Any)
        let cards = Mapper<CardDetail>().mapArray(JSONArray: (anyObj["data"] as! [[String : Any]]))
        return cards
    }
    
    //MARK:- Swipeable Card creation
    func card(from text: String, pageNumber: Int) -> SwipeCard {
        let card = SwipeCard()
        card.swipeDirections = [.left, .right]
        let cardView = Bundle.main.loadNibNamed("CardView", owner: nil, options: nil)?[0] as? CardView
        cardView?.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: swipableView.frame.width, height: swipableView.frame.height))
        cardView?.setCardDetails(text: text, pageNumber: "\(pageNumber)/\(self.cardDetails.count)")
        card.content = cardView!
        return card
    }
    
}

//MARK:- ShuffleCard DataSource
extension TinderShuffleViewController:SwipeCardStackDataSource{
    func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
        return card(from: cardDetails[index].text ?? "", pageNumber: index)
    }
    
    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
        return cardDetails.count
    }
    
    
}
