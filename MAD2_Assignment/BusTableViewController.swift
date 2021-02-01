//
//  BusTableViewController.swift
//  Assignment_Draft
//
//  Created by Tristan Cheah on 14/1/21.
//

import Foundation
import UIKit
import CoreLocation

struct cellData {
    var opened = Bool()
    var title = String()
    var subtitle = String()
    var sectionData = [Service]()
}

var aView: UIView?

class BusTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var nextBus3ArrLabel: UILabel!
    @IBOutlet weak var nextBus3DeckLabel: UILabel!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var busServices = [Service]()
    var tableViewData: [cellData] = [cellData]()
    
    let skipNumbers: [String] = ["0", "500", "1000", "1500", "2000", "2500", "3000", "3500", "4000", "4500", "5000"]
    var allBusStops: [BusStop] = [BusStop]()
    
    let locationDelegate = LocationDelegate()
    var latestLocation: CLLocation? = nil
    
    let locationManager: CLLocationManager = {
        $0.requestWhenInUseAuthorization()
        $0.desiredAccuracy = kCLLocationAccuracyBest
        $0.startUpdatingLocation()
        $0.startUpdatingHeading()
        return $0
    }(CLLocationManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = locationDelegate
        searchBar.delegate = self
//        self.latestLocation = GetCurrentLocation()
        locationDelegate.locationCallback = { location in
            self.latestLocation = location
        }
        
        allBusStops = GetAllBusStops()
        let ngeeAnnBusStopCodes: [BusStop] = GetBusStopsByBusStopNameOrCode(allBusStops: allBusStops, busStopNameOrCode: "Ngee Ann Poly")
//        print("NP HAS \(ngeeAnnBusStopCodes.count) STOPS")
        
        
        
        for j in ngeeAnnBusStopCodes {
            print("=====\(j.Description)=====")
            let busServices: [Service] = GetBusServicesByBusStopCode(busStopCode: j.BusStopCode)
            
        
            
            // Sort based on bus service number (e.g. 52, 151, 154 etc.)
            let sortedArray = busServices.sorted(by: {x, y in return x.ServiceNo.compare(y.ServiceNo, options: .numeric, range: nil, locale: nil) == .orderedAscending})
            tableViewData.append(cellData(opened: false, title: j.Description, subtitle: j.RoadName, sectionData: sortedArray))
        }
        
        
        
    
    }
    
    
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let latestLocation:CLLocation = locations.last!
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened {
            return tableViewData[section].sectionData.count + 1
        }
        else {
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataIndex = indexPath.row - 1
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].title
            cell.detailTextLabel?.text = tableViewData[indexPath.section].subtitle
            
            return cell
        }
        else {
            // Use different cell identifier if needed
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as? BusCustomTableViewCell else {return UITableViewCell()}
            if tableViewData[indexPath.section].sectionData[dataIndex].ServiceNo == "nil" {
                cell.serviceNoLabel.text = "No more services at this bus stop"
                cell.nextBusArrLabel.text = ""
                cell.nextBusDeckLabel.text = ""
                cell.nextBusWheelchairImage.image = UIImage(named: "")
                cell.nextBus2ArrLabel.text = ""
                cell.nextBus2DeckLabel.text = ""
                cell.nextBus2WheelchairImage.image = UIImage(named: "")
                cell.nextBus3ArrLabel.text = ""
                cell.nextBus3DeckLabel.text = ""
                cell.nextBus3WheelchairImage.image = UIImage(named: "")
            }
            else {
                let service: Service = tableViewData[indexPath.section].sectionData[dataIndex]
                cell.serviceNoLabel.text = service.ServiceNo
                
                if service.NextBus.EstimatedArrival != "" {
                    cell.nextBusArrLabel.text = GetEstimatedTime(estimatedTimeOfArrival: service.NextBus.EstimatedArrival)
                    cell.nextBusArrLabel.textColor = GetColourFromBusVacancy(vacancy: service.NextBus.Load)
                    cell.nextBusDeckLabel.text = GetDeckType(deckTypeCode: service.NextBus.Type)
                    cell.nextBusDeckLabel.textColor = GetColourFromBusVacancy(vacancy: service.NextBus.Load)
                    if service.NextBus.Feature == "WAB" {
                        cell.nextBusWheelchairImage.image = UIImage(named: GetImageNameFromBusVacancy(serviceVacancy: service.NextBus.Load))
                    }
                }
                else {
                    cell.nextBusArrLabel.text = "-"
                    cell.nextBusDeckLabel.text = ""
                    cell.nextBusArrLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                    cell.nextBusWheelchairImage.image = nil
                }
                
                if service.NextBus2.EstimatedArrival != "" {
                    cell.nextBus2ArrLabel.text = GetEstimatedTime(estimatedTimeOfArrival: service.NextBus2.EstimatedArrival)
                    cell.nextBus2ArrLabel.textColor = GetColourFromBusVacancy(vacancy: service.NextBus2.Load)
                    cell.nextBus2DeckLabel.text = GetDeckType(deckTypeCode: service.NextBus2.Type)
                    cell.nextBus2DeckLabel.textColor = GetColourFromBusVacancy(vacancy: service.NextBus2.Load)
                    if service.NextBus2.Feature == "WAB" {
                        cell.nextBus2WheelchairImage.image = UIImage(named: GetImageNameFromBusVacancy(serviceVacancy: service.NextBus2.Load))
                    }
                }
                else {
                    cell.nextBus2ArrLabel.text = "-"
                    cell.nextBus2DeckLabel.text = ""
                    cell.nextBus2ArrLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                    cell.nextBus2WheelchairImage.image = nil
                }
                
                if service.NextBus3.EstimatedArrival != "" {
                    cell.nextBus3ArrLabel.text = GetEstimatedTime(estimatedTimeOfArrival: service.NextBus3.EstimatedArrival)
                    cell.nextBus3ArrLabel.textColor = GetColourFromBusVacancy(vacancy: service.NextBus3.Load)
                    cell.nextBus3DeckLabel.text = GetDeckType(deckTypeCode: service.NextBus3.Type)
                    cell.nextBus3DeckLabel.textColor = GetColourFromBusVacancy(vacancy: service.NextBus3.Load)
                    if service.NextBus3.Feature == "WAB" {
                        cell.nextBus3WheelchairImage.image = UIImage(named: GetImageNameFromBusVacancy(serviceVacancy: service.NextBus3.Load))
                    }
                }
                else {
                    cell.nextBus3ArrLabel.text = "-"
                    cell.nextBus3DeckLabel.text = ""
                    cell.nextBus3ArrLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                    cell.nextBus3WheelchairImage.image = nil
                }
            }
            
//            cell.textLabel?.text = tableViewData[indexPath.section].sectionData[dataIndex].NextBus.EstimatedArrival
            
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            if tableViewData[indexPath.section].opened {
                tableViewData[indexPath.section].opened = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none) // play around with this
            }
            else {
                tableViewData[indexPath.section].opened = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none) // play around with this
            }
        }
        
    }
    
    func GetBusStopsByBusStopNameOrCode(allBusStops: [BusStop], busStopNameOrCode: String) -> [BusStop] {
        var busStops: [BusStop] = [BusStop]()
        
        for i in allBusStops {
            if i.Description.lowercased().contains(busStopNameOrCode.lowercased().replacingOccurrences(of: "’", with: "'")) || i.BusStopCode == busStopNameOrCode {
                busStops.append(i)
                
            }
        }
        
        return busStops
    }
    
    func GetBusServicesByBusStopCode(busStopCode: String) -> [Service] {
        var busServices: [Service] = [Service]()
        let sem = DispatchSemaphore.init(value: 0)
        
        let uri = "http://datamall2.mytransport.sg/"
        let path = "ltaodataservice/BusArrivalv2?BusStopCode=" + busStopCode
        
        let target = URL(string: uri + path)
//        print(target)
        
        var request = URLRequest(url: target!)
        request.httpMethod = "GET"
        request.setValue("ocwKEJicQm+H7P7vospXiQ==", forHTTPHeaderField: "AccountKey")

        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
            defer { sem.signal() }
            guard let data = data else { return }
//            print(String(data: data, encoding: .utf8) ?? "Invalid JSON")

            if error == nil {
                let decoder = JSONDecoder()

                do {
                    let busService: BusService = try decoder.decode(BusService.self, from: data)
                    busServices = busService.Services
                }
                catch  {
                    print(error)
                }

            }
        })

        task.resume()
        sem.wait()
        return busServices
    }
    
    func GetEstimatedTime(estimatedTimeOfArrival: String) -> String {
        var status: String = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateTimeList = estimatedTimeOfArrival.split(separator: "T")
        let time = dateTimeList[1].split(separator: "+")
        print("Date: \(dateTimeList[0])\tTime: \(time[0])")
        let arrivalDateTimeString: String = String(dateTimeList[0] + " " + time[0])
        let date: Date = dateFormatter.date(from: arrivalDateTimeString)!
        let timeLeft = ((date.timeIntervalSince(Date()))/60).rounded(.down)
        
        if timeLeft == 0 {
            status = "Arr"
        }
        else if timeLeft < 0 {
            status = "Left"
        }
        else {
            status = String(Int(timeLeft))
        }
        return status
    }
    
    func GetDeckType(deckTypeCode: String) -> String {
        var deckType: String
        if deckTypeCode == "SD" {
            deckType = "Single"
        }
        else if deckTypeCode == "DD" {
            deckType = "Double"
        }
        else {
            deckType = "Bendy"
        }
        return deckType
    }
    
    func GetColourFromBusVacancy(vacancy: String) -> UIColor {
        var colour: UIColor = UIColor()
        if vacancy == "SEA" { // Seats available (green)
            colour = UIColor(red: 0/255, green: 153/255, blue: 51/255, alpha: 1)
        }
        else if vacancy == "SDA" { // Standing available (yellow)
            colour = UIColor(red: 224/255, green: 202/255, blue: 60/255, alpha: 1)
        }
        else { // Limited standing (red)
            colour = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)
        }
        return colour
    }
    
    func GetImageNameFromBusVacancy(serviceVacancy: String) -> String {
        var imageName: String = ""
        if serviceVacancy == "SEA" { // Seats available (green wheelchair icon)
            imageName = "wheelchair-green"
        }
        else if serviceVacancy == "SDA" { // Standing available (yellow wheelchair icon)
            imageName = "wheelchair-yellow"
        }
        else { // Limited standing (red wheelchair icon)
            imageName = "wheelchair-red"
        }
        return imageName
    }
    
    // Search bar, runs code whenever search button is clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Searched")
        
//        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
//
//        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
//        loadingIndicator.hidesWhenStopped = true
//        loadingIndicator.style = UIActivityIndicatorView.Style.medium
//        loadingIndicator.startAnimating();
//
//        alert.view.addSubview(loadingIndicator)
//        self.present(alert, animated: true, completion: nil)
        
//        print(tableViewData.count)
        searchBar.resignFirstResponder()
        
        if searchBar.text != "" {
            let busStopCodes: [BusStop] = self.GetBusStopsByBusStopNameOrCode(allBusStops: self.allBusStops, busStopNameOrCode: searchBar.text!)
            print("There are \(busStopCodes.count) matching records")
//            DispatchQueue.global(qos: .userInteractive).async {
            var newTableViewData: [cellData] = [cellData]()
            for j in busStopCodes {
                print("=====\(j.Description)=====")
                let busServices: [Service] = self.GetBusServicesByBusStopCode(busStopCode: j.BusStopCode)
                
                // Sort based on bus service number (e.g. 52, 151, 154 etc.)
                var sortedArray = busServices.sorted(by: {x, y in return x.ServiceNo.compare(y.ServiceNo, options: .numeric, range: nil, locale: nil) == .orderedAscending})
//                    print("sortedArray has \(sortedArray.count) items")
                if sortedArray.count == 0 {
                    let nextBus = NextBus(OriginCode: "", DestinationCode: "", EstimatedArrival: "", Latitude: "", Longitude: "", VisitNumber: "", Load: "", Feature: "", Type: "")
                    
                    let nextBus2 = NextBus2(OriginCode: "", DestinationCode: "", EstimatedArrival: "", Latitude: "", Longitude: "", VisitNumber: "", Load: "", Feature: "", Type: "")
                    
                    let nextBus3 = NextBus3(OriginCode: "", DestinationCode: "", EstimatedArrival: "", Latitude: "", Longitude: "", VisitNumber: "", Load: "", Feature: "", Type: "")
                    
                    sortedArray.append(Service(ServiceNo: "nil", Operator: "", NextBus: nextBus, NextBus2: nextBus2, NextBus3: nextBus3))
                }
                newTableViewData.append(cellData(opened: false, title: j.Description, subtitle: j.RoadName, sectionData: sortedArray))
            }
            print("newTableViewData count is \(newTableViewData.count)")
            self.tableViewData = newTableViewData
            self.tableView.reloadData()
//            self.dismiss(animated: false, completion: nil)
//            }
            
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//                self.dismiss(animated: false, completion: nil)
//            }
        }
    }
    
    func GetBusStopByBusStopName(allBusStops: [BusStop], busStopName: String) -> BusStop? {
        var busStop: BusStop? = nil
        
        for i in allBusStops {
            if i.Description == busStopName {
//                            print("-----\(i.Description)-----")
                busStop = i
                break
            }
        }
        
        return busStop
    }
    
    func GetAllBusStops() -> [BusStop] {
        var busStops: [BusStop] = [BusStop]()
        let sem = DispatchSemaphore.init(value: 0)
        
        let uri = "http://datamall2.mytransport.sg/"
        let path = "ltaodataservice/BusStops?$skip="
        
        for i in skipNumbers {
//            print("Skip number: \(i)")
            let target = URL(string: uri + path + i)
            
            var request = URLRequest(url: target!)
            request.httpMethod = "GET"
            request.setValue("ocwKEJicQm+H7P7vospXiQ==", forHTTPHeaderField: "AccountKey")
            
            let session = URLSession(configuration: URLSessionConfiguration.default)
            let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
                defer { sem.signal() }
                guard let data = data else { return }
    //            print(String(data: data, encoding: .utf8) ?? "Invalid JSON")
                
                if error == nil && data != nil {
                    let decoder = JSONDecoder()
                    
                    do {
                        let allBusStops: BusStops = try decoder.decode(BusStops.self, from: data)
                        for i in allBusStops.value {
                            busStops.append(i)
                        }
                    }
                    catch  {
                        print(error)
                    }
                    
                }
            })
            
            task.resume()
            sem.wait()
        }
//        print("TOTAL NUMBER OF BUS STOP: \(busStops.count)")
        
        return busStops
    }
    
//    func GetCurrentLocation() -> CLLocation {
//        var currentLocLat: Double = 0
//        var currentLocLong: Double = 0
////        let sem = DispatchSemaphore.init(value: 0)
//
//        locationDelegate.locationCallback = { location in
//            self.latestLocation = location
//        }
//
//        print("LOCATION IS \(self.latestLocation?.coordinate)")
////        sem.wait()
//        return self.latestLocation!
//    }
    
    func GetBusStopNearby() -> [BusStop] {
        var currentLocLat: Double = 0
        var currentLocLong: Double = 0
        var nearbyBusStops: [BusStop] = [BusStop]()
        
        currentLocLat = latestLocation!.coordinate.latitude
        currentLocLong = latestLocation!.coordinate.longitude
        let currentLocationCoordinate: CLLocation = CLLocation(latitude: currentLocLat, longitude: currentLocLong)
        
        for i in allBusStops {
            let busStopLocationCoordinate: CLLocation = CLLocation(latitude: i.Latitude, longitude: i.Longitude)
            let distanceInMeters = currentLocationCoordinate.distance(from: busStopLocationCoordinate)
            if distanceInMeters <= 1000 {
                nearbyBusStops.append(i)
            }
        }
        
        return nearbyBusStops
    }
    
    @IBAction func refreshButton(_ sender: Any) {
        print("refresh")
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        self.present(alert, animated: true, completion: nil)
        
        DispatchQueue.global(qos: .userInteractive).async {
            var newTableViewData: [cellData] = [cellData]()
    //        let ngeeAnnBusStopCodes: [BusStop] = GetBusStopsByBusStopNameOrCode(busStopNameOrCode: "Ngee Ann Poly")
            for i in self.tableViewData {
                var sortedArray: [Service] = [Service]()
    //            print(i.title)
                let busStop: BusStop = self.GetBusStopByBusStopName(allBusStops: self.allBusStops, busStopName: i.title)!
                let busServices: [Service] = self.GetBusServicesByBusStopCode(busStopCode: busStop.BusStopCode)
                
                // Sort based on bus service number (e.g. 52, 151, 154 etc.)
                sortedArray = busServices.sorted(by: {x, y in return x.ServiceNo.compare(y.ServiceNo, options: .numeric, range: nil, locale: nil) == .orderedAscending})
                if sortedArray.count == 0 {
                    let nextBus = NextBus(OriginCode: "", DestinationCode: "", EstimatedArrival: "", Latitude: "", Longitude: "", VisitNumber: "", Load: "", Feature: "", Type: "")
                    
                    let nextBus2 = NextBus2(OriginCode: "", DestinationCode: "", EstimatedArrival: "", Latitude: "", Longitude: "", VisitNumber: "", Load: "", Feature: "", Type: "")
                    
                    let nextBus3 = NextBus3(OriginCode: "", DestinationCode: "", EstimatedArrival: "", Latitude: "", Longitude: "", VisitNumber: "", Load: "", Feature: "", Type: "")
                    
                    sortedArray.append(Service(ServiceNo: "nil", Operator: "", NextBus: nextBus, NextBus2: nextBus2, NextBus3: nextBus3))
                }
                newTableViewData.append(cellData(opened: i.opened, title: i.title, subtitle: i.subtitle, sectionData: sortedArray))
            }
            self.tableViewData = newTableViewData
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    
    @IBAction func nearbyBtn(_ sender: Any) {
        print("Nearby btn pressed")
        
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        self.present(alert, animated: true, completion: nil)
        
        DispatchQueue.global(qos: .userInteractive).async {
            // This is run on the background queue
            var newTableViewData: [cellData] = [cellData]()
            
            let nearbyBusStop: [BusStop] = self.GetBusStopNearby()
            for i in nearbyBusStop {
                var sortedArray: [Service] = [Service]()
                let busServices: [Service] = self.GetBusServicesByBusStopCode(busStopCode: i.BusStopCode)
                
                // Sort based on bus service number (e.g. 52, 151, 154 etc.)
                sortedArray = busServices.sorted(by: {x, y in return x.ServiceNo.compare(y.ServiceNo, options: .numeric, range: nil, locale: nil) == .orderedAscending})
                if sortedArray.count == 0 {
                    let nextBus = NextBus(OriginCode: "", DestinationCode: "", EstimatedArrival: "", Latitude: "", Longitude: "", VisitNumber: "", Load: "", Feature: "", Type: "")
                    
                    let nextBus2 = NextBus2(OriginCode: "", DestinationCode: "", EstimatedArrival: "", Latitude: "", Longitude: "", VisitNumber: "", Load: "", Feature: "", Type: "")
                    
                    let nextBus3 = NextBus3(OriginCode: "", DestinationCode: "", EstimatedArrival: "", Latitude: "", Longitude: "", VisitNumber: "", Load: "", Feature: "", Type: "")
                    
                    sortedArray.append(Service(ServiceNo: "nil", Operator: "", NextBus: nextBus, NextBus2: nextBus2, NextBus3: nextBus3))
                }
                newTableViewData.append(cellData(opened: false, title: i.Description, subtitle: i.RoadName, sectionData: sortedArray))
            }
            self.tableViewData = newTableViewData
            
            
            DispatchQueue.main.async {
                // This is run on the main queue, after the previous code in outer block
                
                self.tableView.reloadData()
                self.dismiss(animated: false, completion: nil)
            }
        }
        
    }
    

}
