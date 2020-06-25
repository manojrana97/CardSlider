//
//  CardDetail.swift
//  CardSlider
//
//  Created by manoj on 25/06/20.
//  Copyright © 2020 Manoj. All rights reserved.
//

import Foundation
import ObjectMapper

class CardDetail: NSObject, Mappable {
    
    var id : Int!
    var text : String?
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        text <- map["text"]
    }
    
}
