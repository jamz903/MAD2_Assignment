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
    
    
    
    //for dummy values
    var canteenl = Canteen.fetchDummy()
    
    //real API - but api currently not working so using hardcoded values
    //var canteenl = Canteen.getCanteens()
    
    
    
    override func viewDidLoad() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Seats Available";
        //fcProg.backgroundColor(patternImage: )
        var count = 0
        for i in canteenl{
            if count == 0{
                CanteenCellList.append(CanteenCell(title: "munch", featuredImage: UIImage(named: "munch")!, canteen: i))
                count += 1
            }
            else if count == 1{
                CanteenCellList.append(CanteenCell(title: "food club", featuredImage: UIImage(named: "FC")!, canteen: i))
                count += 1
            }
            else if count == 2{
                CanteenCellList.append(CanteenCell(title: "Makan place", featuredImage: UIImage(named: "mkp")!, canteen: i))
                count += 1
            }
            
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







    

