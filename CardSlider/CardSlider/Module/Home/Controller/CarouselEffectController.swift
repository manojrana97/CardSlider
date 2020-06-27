import UIKit
import iCarousel
/**
This Class shows the card details in a card slider using Carousel Animation.

- Author:
Manoj Kumar Rana

- Date:
26/06/20

- Version:
1.0
*/
class CarouselEffectController: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak private var carouselView: iCarousel!
    
    //MARK:- Properties
    private var cardDetails:[CardDetail] = []
    let cardView = Bundle.main.loadNibNamed("CardView", owner: nil, options: nil)?[0] as? CardView

    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initilizeSlider()
    }
    
    //MARK:- Private Function
    private func initilizeSlider(){
        cardDetails = CommonUtilities.getCardDetail()
        carouselView.delegate = self
        carouselView.dataSource = self
        carouselView.type = .wheel
        carouselView.isPagingEnabled = true
        carouselView.reloadData()
    }
    
    //MARK:- Swipeable Card creation
    private func card(from text: String, pageNumber: Int) -> UIView {
        let cardView = Bundle.main.loadNibNamed("CardView", owner: nil, options: nil)?[0] as? CardView
        cardView?.setCardDetails(text: text, pageNumber: "\(pageNumber)/\(self.cardDetails.count)")
        return cardView!
    }
    

}

//MARK:- Koloda View Delegates
extension CarouselEffectController: iCarouselDelegate, iCarouselDataSource{
    func numberOfItems(in carousel: iCarousel) -> Int {
        return cardDetails.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        return card(from: cardDetails[index].text ?? "", pageNumber: index+1)
    }
    
}
