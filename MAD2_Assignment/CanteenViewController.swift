//
//  CanteenViewController.swift
//  MAD2_Assignment
//
//  Created by Shane-Rhys Chua on 24/1/21.
//

import Foundation
import UIKit

class CanteenViewController:UIViewController{
    
    var CanteenList: [Canteen] = [Canteen]()
    
    var newCanteen = [String: Any]()
    
    var value = ""
    
    let urls = ["https://www1.np.edu.sg/npnet/wifiatcanteen/CMXService.asmx/getChartData?Location=System%20Campus%3EBlk%2073%3ELevel%201%3EMunch",
        
        "https://www1.np.edu.sg/npnet/wifiatcanteen/CMXService.asmx/getChartData?Location=System%20Campus%3EBlk%2051%3ELevel%202%20-%20Canteen%3ECoverageArea-B51L02",
    
    "https://www1.np.edu.sg/npnet/wifiatcanteen/CMXService.asmx/getChartData?Location=System%20Campus%3EBlk%2022%3ELevel%201%3ECoverageArea-B22L01" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        //getData(from: url)
        
        for i in urls{
            loadDataXML(from: i)
            
            //newCanteen = convertToDictionary(text: value) ?? ["value": 2, "color": "wrong","label":"wrong"]
            
            
        }
     
        print("done")
        
        
    }
    
    @IBAction func button(_ sender: Any) {
        
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
            
            let canteen = Canteen(Value: self.newCanteen["value"] as! Int, Color: self.newCanteen["color"] as! String, Label: self.newCanteen["label"] as! String)
            
            self.CanteenList.append(canteen)
            
            print(self.CanteenList.count)
            
            print(self.CanteenList[(self.CanteenList.count) - 1].color)
        }
        
        session.resume()
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


    

