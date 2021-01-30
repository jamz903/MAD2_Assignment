//
//  LocationDetailViewController.swift
//  MAD2_Assignment
//
//  Created by MAD2_P01 on 30/1/21.
//

import Foundation
import UIKit
import SwiftUI

class LocationDetailViewController: UIHostingController<LocationDetail> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: LocationDetail(aDecoder))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Do any additional setup after loading the view
    }
}
