import UIKit
import Shuffle_iOS
/**
This Class shows the card details in a tinder like card slider.

- Author:
Manoj Kumar Rana

- Date:
26/06/20

- Version:
1.0
*/
class TinderShuffleViewController: UIViewController {
    //MARK:- Properties
    var cardDetails:[CardDetail] = []
    let cardStack = SwipeCardStack()
    
    //MARK:- IBOutlets
    @IBOutlet weak private var swipableView:UIView!
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //card details are coming from local json file
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
