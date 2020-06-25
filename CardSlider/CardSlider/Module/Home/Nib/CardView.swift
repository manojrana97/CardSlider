//
//  CardView.swift
//  CardSlider
//
//  Created by manoj on 25/06/20.
//  Copyright © 2020 Manoj. All rights reserved.
//

import UIKit

class CardView: UIView {
    @IBOutlet weak private var textLabel:UILabel!
    @IBOutlet weak private var pageNumberLabel:UILabel!
    
    func setCardDetails(text:String, pageNumber:String){
        textLabel.text = text
        pageNumberLabel.text = pageNumber
    }


}
