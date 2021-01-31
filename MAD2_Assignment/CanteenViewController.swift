//
//  CanteenViewController.swift
//  MAD2_Assignment
//
//  Created by Shane-Rhys Chua on 24/1/21.
//

import Foundation
import UIKit

class CanteenViewController:UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!

   
    var CanteenCellList: [CanteenCell] = [CanteenCell]()
    //
    
    
    
    

    var canteenl = Canteen.fetchDummy()
    
    
    
    override func viewDidLoad() {
        
        //fcProg.backgroundColor(patternImage: )
    
        for i in canteenl{
            CanteenCellList.append(CanteenCell(title: "foodclb", featuredImage: UIImage(named: "munch")!, canteen: i))
        }
        print("done")
        super.viewDidLoad()
        collectionView.dataSource = self
       
        
    }
    
}

extension CanteenViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CanteenCellList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CanteenViewControllerCell",
                                                      for: indexPath) as! CanteenViewControllerCell
        let Canteenq = CanteenCellList[indexPath.item]
        
        cell.cant = Canteenq
        
        return cell
        
    }
}

//extension CanteenViewController: UICollectionViewDataSource{
//    func numberOfSection(in collectionView: UICollectionView) ->
//    Int{
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return //CanteenCellsList.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CanteenViewControllerCell", for: indexPath) as! CanteenViewControllerCell
//
//        //let can = CanteenCellsList[indexPath.item]
//
//        cell.cant = can
//
//        return cell
//    }
//}
    




//food club amounts
struct fcA{
    public var value: String
    public var color: String
    public var label: String
}







    

