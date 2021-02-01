//
//  Canteen.swift
//  MAD2_Assignment
//
//  Created by Shane-Rhys Chua on 24/1/21.
//

import Foundation
import UIKit

class Canteen {
    
    //set up variables
    var value:Int
    var color:String
    var label:String
    
    //set up init to make new varaibles
    init(Value:Int, Color:String, Label:String){
        value = Value
        color = Color
        label = Label
    }
    
    //dummy data for test/ presentationation
    static func fetchDummy() -> [Canteen]{
        var CanteenList: [Canteen] = [Canteen]()
        //CanteenList.append(getCanteens(Canteen))
        return[
            Canteen(Value: 41, Color: "#00ff00", Label: "Packed"),
            Canteen(Value: 20, Color: "#9100ff", Label: "Comfy"),
            Canteen(Value: 80, Color: "#ff9100", Label: "Crowded")
        ]
    }
    
    //get Canteens from School Canteen API
    static func getCanteens() -> [Canteen]{
        
        //Munch/MKP/FC Canteen API
        let urls = ["https://www1.np.edu.sg/npnet/wifiatcanteen/CMXService.asmx/getChartData?Location=System%20Campus%3EBlk%2073%3ELevel%201%3EMunch",

            "https://www1.np.edu.sg/npnet/wifiatcanteen/CMXService.asmx/getChartData?Location=System%20Campus%3EBlk%2051%3ELevel%202%20-%20Canteen%3ECoverageArea-B51L02",

        "https://www1.np.edu.sg/npnet/wifiatcanteen/CMXService.asmx/getChartData?Location=System%20Campus%3EBlk%2022%3ELevel%201%3ECoverageArea-B22L01" ]
        
        //create canteen list to hold canteen data
        var CanteenList: [Canteen] = [Canteen]()


        
        
        //get canteen data for each api
        for i in urls{
            CanteenList.append(loadDataXML(from: i))

        }




        return CanteenList
    }

    
    //get data from API which is in XML
    static func loadDataXML(from url: String) -> Canteen{
        let url = url
        //create dummy variable
        var newcanteens = MAD2_Assignment.Canteen(Value: 0, Color: "", Label: "")
        //request URL from school api
        let request = URLRequest(url: URL(string: url)!)
        //create session for api data
        let session = URLSession.shared.dataTask(with: request){
            (data, _, error) in

            if error != nil{
                //incase of error
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
            
            //cut out sides of XML data
            if let edit = s.range(of: "]") {
              s.removeSubrange(edit.lowerBound..<s.endIndex)
            }

            print("CanteenAPI working")
            if let edit2 = s.range(of: "{") {
                s.removeSubrange(s.startIndex..<edit2.lowerBound)
            }
            print(s)
            
            
            //convert XML/JSON to dictionary
            let dict = self.convertToDictionary(text: s)

            //add values from newly made dictionary to new Canteen Item
            newcanteens = MAD2_Assignment.Canteen.init(Value: (dict!["value"] as! Int),
                                                           Color: dict!["color"] as! String,
                                                           Label: dict!["label"] as! String)

            print("testing data start")
            print(newcanteens.color)
            print(newcanteens.label)
            print("testing data end")


        }

        session.resume()
        print("no more api")
        return newcanteens

    }


    //convert data to dictionary
    static func convertToDictionary(text: String) -> [String: Any]? {
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


}



