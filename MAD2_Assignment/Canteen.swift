//
//  Canteen.swift
//  MAD2_Assignment
//
//  Created by Shane-Rhys Chua on 24/1/21.
//

import Foundation
import UIKit

class Canteen {
    
    var value:Int
    var color:String
    var label:String
    
    init(Value:Int, Color:String, Label:String){
        value = Value
        color = Color
        label = Label
    }
    
    
    static func fetchDummy() -> [Canteen]{
        return[
            Canteen(Value: 41, Color: "#00ff00", Label: "okok"),
            Canteen(Value: 20, Color: "#9100ff", Label: "Comfy"),
            Canteen(Value: 80, Color: "#ff9100", Label: "uncofmy")
        ]
    }
    
    
//    func getCanteens() -> [Canteen]{
//        let urls = ["https://www1.np.edu.sg/npnet/wifiatcanteen/CMXService.asmx/getChartData?Location=System%20Campus%3EBlk%2073%3ELevel%201%3EMunch",
//
//            "https://www1.np.edu.sg/npnet/wifiatcanteen/CMXService.asmx/getChartData?Location=System%20Campus%3EBlk%2051%3ELevel%202%20-%20Canteen%3ECoverageArea-B51L02",
//
//        "https://www1.np.edu.sg/npnet/wifiatcanteen/CMXService.asmx/getChartData?Location=System%20Campus%3EBlk%2022%3ELevel%201%3ECoverageArea-B22L01" ]
//        var CanteenList: [Canteen] = [Canteen]
//
//
//
//        var newCanteen = Canteen
//
//        var value = ""
//
//        for i in urls{
//            CanteenList.append(loadDataXML(from: i, CanteenList: newCanteen))
//
//        }
//
//
//
//
//        return CanteenList
//    }
//
//
//    func loadDataXML(from url: String, CanteenList canteens: Canteen) -> Canteen{
//        let url = url
//        var newcanteens = MAD2_Assignment.Canteen(Value: 0, Color: "", Label: "")
//        let request = URLRequest(url: URL(string: url)!)
//        let session = URLSession.shared.dataTask(with: request){
//            (data, _, error) in
//
//            if error != nil{
//                //
//                print("error")
//                return
//            }
//            guard let data = data else{
//                print("data error")
//                return
//            }
//            //convert data to string
//            var s : String = String(data:data, encoding: .ascii)!
//
//            //make XML fonrm to standards
//            s = s.replacingOccurrences(of: "\r", with: "\n")
//            print(s)
//            print("yhhh")
//            //parse XML
//
//            if let edit = s.range(of: "]") {
//              s.removeSubrange(edit.lowerBound..<s.endIndex)
//            }
//
//            print("YUIEF")
//            if let edit2 = s.range(of: "{") {
//                s.removeSubrange(s.startIndex..<edit2.lowerBound)
//            }
//            print(s)
//
//            let dict = self.convertToDictionary(text: s)
//
//            newcanteens = MAD2_Assignment.Canteen.init(Value: dict!["value"] as! Int,
//                                                           Color: dict!["color"] as! String,
//                                                           Label: dict!["label"] as! String)
//
//            print(newcanteens.color)
//
//
//        }
//
//        session.resume()
//        print("no more api")
//        return newcanteens
//
//    }
//
//
//
//    func convertToDictionary(text: String) -> [String: Any]? {
//        if let data = text.data(using: .utf8) {
//            do {
//                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//        return nil
//    }
//
//    struct Response: Codable{
//        public var value: Int
//        public var color: String
//        public var label: String
//    }
//
//
//}
//
//
}
