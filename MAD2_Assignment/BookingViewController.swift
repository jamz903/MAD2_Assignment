//
//  HomeViewController.swift
//  MAD2_Assignment
//
//  Created by Jamie on 24/1/21.
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
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Book";
    }
}
