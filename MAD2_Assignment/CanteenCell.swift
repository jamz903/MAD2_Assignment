//
//  CanteenCell.swift
//  MAD2_Assignment
//
//  Created by Shane-Rhys Chua on 31/1/21.
//

import Foundation
import UIKit

class CanteenCell {
    
    var Canteen:Canteen
    var title = ""
    var featuredImage: UIImage
    
    init(title:String, featuredImage:UIImage, canteen:Canteen){
        self.title = title
        self.featuredImage = featuredImage
        self.Canteen = canteen
        
    }
    
    
    
}
