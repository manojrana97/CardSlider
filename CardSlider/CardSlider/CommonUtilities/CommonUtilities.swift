//
//  CommonUtilities.swift
//  CardSlider
//
//  Created by manoj on 26/06/20.
//  Copyright © 2020 Manoj. All rights reserved.
//

import Foundation
import ObjectMapper

class CommonUtilities: NSObject {
    
    //MARK:- Json parsing : Local File
    class func getCardDetail() -> [CardDetail]{
        var cardDetails:[CardDetail] = []
        let path = Bundle.main.path(forResource: "CardDetails", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        
        let fileData = try? Data(contentsOf: url)
        if let data = fileData {
            var urlStr = String(data: data, encoding: String.Encoding.utf8)
            urlStr!.remove(at: urlStr!.startIndex)
            if let data = urlStr!.data(using: .utf8){
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                    cardDetails = parseJson(anyObj: json as AnyObject)
                } catch let error {
                    print(error)
                }
            }
            
        } else {
            print("data error")
        }
        
        return cardDetails
        
    }
    
    private class func parseJson(anyObj:AnyObject) -> Array<CardDetail>{
        print(anyObj["data"] as Any)
        let cards = Mapper<CardDetail>().mapArray(JSONArray: (anyObj["data"] as! [[String : Any]]))
        return cards
    }
}
