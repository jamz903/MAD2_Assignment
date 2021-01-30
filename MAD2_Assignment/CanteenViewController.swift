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

    var CanteenList: [Canteen] = [Canteen]()
    var CanteenCellsList: [CanteenCell] = [CanteenCell]()
    
    var newCanteen = [String: Any]()
    
    var value = ""
    
    let urls = ["https://www1.np.edu.sg/npnet/wifiatcanteen/CMXService.asmx/getChartData?Location=System%20Campus%3EBlk%2073%3ELevel%201%3EMunch",
        
        "https://www1.np.edu.sg/npnet/wifiatcanteen/CMXService.asmx/getChartData?Location=System%20Campus%3EBlk%2051%3ELevel%202%20-%20Canteen%3ECoverageArea-B51L02",
    
    "https://www1.np.edu.sg/npnet/wifiatcanteen/CMXService.asmx/getChartData?Location=System%20Campus%3EBlk%2022%3ELevel%201%3ECoverageArea-B22L01" ]
    
    

    
    
    
    override func viewDidLoad() {
        
        //fcProg.backgroundColor(patternImage: )
        
        for i in urls{
            loadDataXML(from: i)
            //newCanteen = convertToDictionary(text: value) ?? ["value": 2, "color": "wrong","label":"wrong"]
        }
        print("done")
        super.viewDidLoad()
        
        collectionView.dataSource = self
       
        
    }
    
    
   
    
        
        
    
    
    
    
    
    
    
    
    private func loadDataXML(from url: String){
        let url = url
        let request = URLRequest(url: URL(string: url)!)
        let session = URLSession.shared.dataTask(with: request){
            (data, _, error) in
            
            if error != nil{
                //
                print("error")
                return
            }
            guard let data = data else{
                print("data error")
                return
            }
            //convert data to string
            var s : String = String(data:data, encoding: .ascii)!
            
            //make XML fonrm to standards
            s = s.replacingOccurrences(of: "\r", with: "\n")
            print(s)
            print("yhhh")
            //parse XML
        
            if let edit = s.range(of: "]") {
              s.removeSubrange(edit.lowerBound..<s.endIndex)
            }
            
            print("YUIEF")
            if let edit2 = s.range(of: "{") {
                s.removeSubrange(s.startIndex..<edit2.lowerBound)
            }
            print(s)
            self.value = s
            
            self.newCanteen = convertToDictionary(text: self.value)!
            
            let canteen1 = Canteen(Value: self.newCanteen["value"] as! Int, Color: self.newCanteen["color"] as! String, Label: self.newCanteen["label"] as! String)
            
            self.CanteenList.append(canteen1)
            
            print(self.CanteenList.count)
            
            print(self.CanteenList[(self.CanteenList.count) - 1].color)
            
            
            if self.CanteenList.count == 0{
                let canteenCell1 = CanteenCell(title: "Munch", featuredImage: UIImage(named: "munch")!, canteen: canteen1)
                self.CanteenCellsList.append(canteenCell1)
            }
            else if self.CanteenCellsList.count == 1{
                let canteenCell1 = CanteenCell(title: "Makan Place", featuredImage: UIImage(named: "mkp")!, canteen: canteen1)
                self.CanteenCellsList.append(canteenCell1)
            }
            else if self.CanteenCellsList.count == 2{
                let canteenCell1 = CanteenCell(title: "Food Club", featuredImage: UIImage(named: "FC")!, canteen: canteen1)
                self.CanteenCellsList.append(canteenCell1)
            }
            
        }
        
        session.resume()
        print("no more api")
    }
    
}

extension CanteenViewController: UICollectionViewDataSource{
    func numberOfSection(in collectionView: UICollectionView) ->
    Int{
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CanteenCellsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CanteenViewControllerCell", for: indexPath) as! CanteenViewControllerCell
        
        let can = CanteenCellsList[indexPath.item]
        
        cell.cant = can
        
        return cell
    }
}
    




//food club amounts
struct fcA{
    public var value: String
    public var color: String
    public var label: String
}




func convertToDictionary(text: String) -> [String: Any]? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}

struct Response: Codable{
    public var value: Int
    public var color: String
    public var label: String
}


    

