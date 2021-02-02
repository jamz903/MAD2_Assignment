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
//    var canteenl = Canteen.getCanteens()
    
    
    
    override func viewDidLoad() {
        //title header for design
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Seats Available";
        //fcProg.backgroundColor(patternImage: )
        var count = 0
        for i in canteenl{
            
            //changes to seats available at canteens
            i.value = 150-i.value
            
            if count == 0{//munch data slide
                CanteenCellList.append(CanteenCell(title: "munch", featuredImage: UIImage(named: "munch")!, canteen: i))
                count += 1
            }
            else if count == 1{//fc data slide
                CanteenCellList.append(CanteenCell(title: "food club", featuredImage: UIImage(named: "FC")!, canteen: i))
                count += 1
            }
            else if count == 2{//mkp data slide
                CanteenCellList.append(CanteenCell(title: "Makan place", featuredImage: UIImage(named: "mkp")!, canteen: i))
                count += 1
            }
            
        }
        print("done")
        super.viewDidLoad()
        //display collectionview datasource
        collectionView.dataSource = self
       
        
    }
    
}

//extension to display collectionview
extension CanteenViewController: UICollectionViewDataSource{
    //strut
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CanteenCellList.count
    }
    
    //connect to Canteenviewcontrollercell which has the display and layout of each cell for the data to follow
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CanteenViewControllerCell",
                                                      for: indexPath) as! CanteenViewControllerCell
        let Canteenq = CanteenCellList[indexPath.item]
        
        //enter data from the class into the sections set in the ell
        cell.cant = Canteenq
        
        return cell
        
    }
}


    




//food club amounts
struct fcA{
    public var value: String
    public var color: String
    public var label: String
}







    

