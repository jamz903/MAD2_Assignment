//
//  CanteenViewControllerCell.swift
//  MAD2_Assignment
//
//  Created by Shane-Rhys Chua on 31/1/21.
//

import Foundation
import UIKit

class CanteenViewControllerCell: UICollectionViewCell{
    
    @IBOutlet weak var BGImageView: UIImageView!
    @IBOutlet weak var backgroundColorView: UIView!
    @IBOutlet weak var canteenNumLabel: UILabel!
    @IBOutlet weak var comfyLevelLabel: UILabel!
    @IBOutlet weak var canteenNameLabel: UILabel!
    
    
    
    var cant: CanteenCell!{
        didSet{
            self.updateUI()
        }
    }
    
    func updateUI(){
        if let cell = cant{
            BGImageView.image = cant.featuredImage
            canteenNumLabel.text = String(cant.Canteen.value)
            comfyLevelLabel.text = String(cant.Canteen.label)
            canteenNameLabel.text = String(cant.title)
            
            
        }
        BGImageView.layer.cornerRadius = 10.0
        BGImageView.layer.masksToBounds = true
        
    }
}
