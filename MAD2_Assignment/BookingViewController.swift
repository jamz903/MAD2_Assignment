//
//  HomeViewController.swift
//  MAD2_Assignment
//
//  Created by MAD2_P01 on 24/1/21.
//

import Foundation
import UIKit
import SwiftUI

class BookingViewController: UIHostingController<BookingView> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: BookingView())
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //Do any additional setup after loading the view
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//    }
}
