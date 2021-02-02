//
//  BusTableViewController.swift
//  Assignment_Draft
//
//  Created by Justin Ng on 14/1/21.
//

import Foundation
import UIKit
import CoreLocation


// Structure for the cell data
struct cellData {
    var opened = Bool()
    // title refers to the main header (bus stop name)
    var title = String()
    var subtitle = String()
    // sectionData refers to the subheaders (sub-rows) [which will be the different bus services at the bus stop]
    var sectionData = [Service]()
    
    // e.g.
    // Ngee Ann Poly (title)
    // 74 (sectionData element)
    // 151 (sectionData element)
    // etc.
}

var aView: UIView?

class BusTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var nextBus3ArrLabel: UILabel!
    @IBOutlet weak var nextBus3DeckLabel: UILabel!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var busServices = [Service]()
    var tableViewData: [cellData] = [cellData]()
    
    // Skip numbers as Bus Stop details can only retrieve a max of 500 records each time
    let skipNumbers: [String] = ["0", "500", "1000", "1500", "2000", "2500", "3000", "3500", "4000", "4500", "5000"]
    
    // List to store all bus stops
    var allBusStops: [BusStop] = [BusStop]()
    
    // Defining the location delegate and location manager
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
        
        // Setting the delegates of location delegate and search bar
        locationManager.delegate = locationDelegate
        searchBar.delegate = self
        locationDelegate.locationCallback = { location in
            self.latestLocation = location
        }
        
        // Retrieves all bus stops
        allBusStops = GetAllBusStops()
        
        // Retrieves the 2 bus stops at Ngee Ann Poly
        let ngeeAnnBusStopCodes: [BusStop] = GetBusStopsByBusStopNameOrCode(allBusStops: allBusStops, busStopNameOrCode: "Ngee Ann Poly")
        for j in ngeeAnnBusStopCodes {
            // Retrieves the bus services at the different bus stops, by their bus stop code
            let busServices: [Service] = GetBusServicesByBusStopCode(busStopCode: j.BusStopCode)

            // Sort based on bus service number (e.g. 52, 151, 154 etc.)
            let sortedArray = busServices.sorted(by: {x, y in return x.ServiceNo.compare(y.ServiceNo, options: .numeric, range: nil, locale: nil) == .orderedAscending})
            tableViewData.append(cellData(opened: false, title: j.Description, subtitle: j.RoadName, sectionData: sortedArray))
        }
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let latestLocation:CLLocation = locations.last!
    }
    
    // Retrieves the number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    // Retrieves the number of rows in section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // If the sub-section is opened, retrieves the number of rows in section data and +1 (including header)
        if tableViewData[section].opened {
            return tableViewData[section].sectionData.count + 1
        }
        // If the sub-section is closed, returns 1 as only the title is shown
        else {
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // -1 due to the header being index 0
        // first item in section data is 0 but will be indexPath 1 as header will be 0
        let dataIndex = indexPath.row - 1
        
        // If the row is the title, use the cell with Identifier "cell"
        // Normal cell with just title and subtitle
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].title
            cell.detailTextLabel?.text = tableViewData[indexPath.section].subtitle
            
            return cell
        }
        
        // If the row is the different bus services, use the cell with Identifier "cell2"
        // Custom cell with the different bus arrival timings
        else {
            // Use different cell identifier if needed
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as? BusCustomTableViewCell else {return UITableViewCell()}
            
            // Checks if there are any bus services at the bus stop
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
                // There are bus services at this bus stop
                // Retrieves the bus service object
                let service: Service = tableViewData[indexPath.section].sectionData[dataIndex]
                
                // Displays the bus service number
                cell.serviceNoLabel.text = service.ServiceNo
                
                // Checks if the first bus for the bus service has an estimated arrival
                if service.NextBus.EstimatedArrival != "" {
                    // Bus service has an estimated arrival
                    // Configuring the bus service estimated time, colour of displayed text by vacancy in bus, type of bus (e.g. double, single, bendy),
                    // and if the bus is wheel-chair accessible
                    cell.nextBusArrLabel.text = GetEstimatedTime(estimatedTimeOfArrival: service.NextBus.EstimatedArrival)
                    cell.nextBusArrLabel.textColor = GetColourFromBusVacancy(vacancy: service.NextBus.Load)
                    cell.nextBusDeckLabel.text = GetDeckType(deckTypeCode: service.NextBus.Type)
                    cell.nextBusDeckLabel.textColor = GetColourFromBusVacancy(vacancy: service.NextBus.Load)
                    if service.NextBus.Feature == "WAB" {
                        cell.nextBusWheelchairImage.image = UIImage(named: GetImageNameFromBusVacancy(serviceVacancy: service.NextBus.Load))
                    }
                }
                else {
                    // There is no estimated arrival for this bus service
                    cell.nextBusArrLabel.text = "-"
                    cell.nextBusDeckLabel.text = ""
                    cell.nextBusArrLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                    cell.nextBusWheelchairImage.image = nil
                }
                
                // Checks if the second bus for the bus service has an estimated arrival
                if service.NextBus2.EstimatedArrival != "" {
                    // Bus service has an estimated arrival
                    // Configuring the bus service estimated time, colour of displayed text by vacancy in bus, type of bus (e.g. double, single, bendy),
                    // and if the bus is wheel-chair accessible
                    cell.nextBus2ArrLabel.text = GetEstimatedTime(estimatedTimeOfArrival: service.NextBus2.EstimatedArrival)
                    cell.nextBus2ArrLabel.textColor = GetColourFromBusVacancy(vacancy: service.NextBus2.Load)
                    cell.nextBus2DeckLabel.text = GetDeckType(deckTypeCode: service.NextBus2.Type)
                    cell.nextBus2DeckLabel.textColor = GetColourFromBusVacancy(vacancy: service.NextBus2.Load)
                    if service.NextBus2.Feature == "WAB" {
                        cell.nextBus2WheelchairImage.image = UIImage(named: GetImageNameFromBusVacancy(serviceVacancy: service.NextBus2.Load))
                    }
                }
                else {
                    // There is no estimated arrival for this bus service
                    cell.nextBus2ArrLabel.text = "-"
                    cell.nextBus2DeckLabel.text = ""
                    cell.nextBus2ArrLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                    cell.nextBus2WheelchairImage.image = nil
                }
                
                // Checks if the second bus for the bus service has an estimated arrival
                if service.NextBus3.EstimatedArrival != "" {
                    // Bus service has an estimated arrival
                    // Configuring the bus service estimated time, colour of displayed text by vacancy in bus, type of bus (e.g. double, single, bendy),
                    // and if the bus is wheel-chair accessible
                    cell.nextBus3ArrLabel.text = GetEstimatedTime(estimatedTimeOfArrival: service.NextBus3.EstimatedArrival)
                    cell.nextBus3ArrLabel.textColor = GetColourFromBusVacancy(vacancy: service.NextBus3.Load)
                    cell.nextBus3DeckLabel.text = GetDeckType(deckTypeCode: service.NextBus3.Type)
                    cell.nextBus3DeckLabel.textColor = GetColourFromBusVacancy(vacancy: service.NextBus3.Load)
                    if service.NextBus3.Feature == "WAB" {
                        cell.nextBus3WheelchairImage.image = UIImage(named: GetImageNameFromBusVacancy(serviceVacancy: service.NextBus3.Load))
                    }
                }
                else {
                    // There is no estimated arrival for this bus service
                    cell.nextBus3ArrLabel.text = "-"
                    cell.nextBus3DeckLabel.text = ""
                    cell.nextBus3ArrLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                    cell.nextBus3WheelchairImage.image = nil
                }
            }
            return cell
        }
        
    }
    
    // Runs when a row is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Checks if the row selected is the title (bus stop name)
        // If is not the title (bus stop name) [means a bus service row was selected], do nothing
        if indexPath.row == 0 {
            // Checks if the section currently has the section data open
            if tableViewData[indexPath.section].opened {
                // Section data was previously open
                tableViewData[indexPath.section].opened = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
            else {
                // Section data was previously closed
                tableViewData[indexPath.section].opened = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
        }
        
    }
    
    // Retrieves the Bus Stops by bus stop name or their bus stop code
    func GetBusStopsByBusStopNameOrCode(allBusStops: [BusStop], busStopNameOrCode: String) -> [BusStop] {
        var busStops: [BusStop] = [BusStop]()
        
        for i in allBusStops {
            if i.Description.lowercased().contains(busStopNameOrCode.lowercased().replacingOccurrences(of: "’", with: "'")) || i.BusStopCode == busStopNameOrCode {
                busStops.append(i)
            }
        }
        
        return busStops
    }
    
    // Retrieves bus services by their bus stop code
    func GetBusServicesByBusStopCode(busStopCode: String) -> [Service] {
        var busServices: [Service] = [Service]()
        let sem = DispatchSemaphore.init(value: 0)
        
        // URL of bus arrival API
        let uri = "http://datamall2.mytransport.sg/"
        let path = "ltaodataservice/BusArrivalv2?BusStopCode=" + busStopCode
        
        let target = URL(string: uri + path)
        
        // Configuring the HttpMethod and the AccountKey
        var request = URLRequest(url: target!)
        request.httpMethod = "GET"
        request.setValue("ocwKEJicQm+H7P7vospXiQ==", forHTTPHeaderField: "AccountKey")

        // Retrieving the data from the API
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
            defer { sem.signal() }
            guard let data = data else { return }

            if error == nil {
                let decoder = JSONDecoder()

                do {
                    // Decoding the JSON data
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
    
    // Get the estimated time of arrival from the date (string data type)
    func GetEstimatedTime(estimatedTimeOfArrival: String) -> String {
        var status: String = ""
        
        // Defining the date format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        // Example value retrieved from the API
        //"EstimatedArrival": "2021-02-02T11:03:27+08:00"
        
        // Split by "T" to get the date and time component
        let dateTimeList = estimatedTimeOfArrival.split(separator: "T")
        
        // Retrieves the time compoenent and split again by the "+" to remove the time zone
        let time = dateTimeList[1].split(separator: "+")

        // Defines the arrival datetime object
        let arrivalDateTimeString: String = String(dateTimeList[0] + " " + time[0])
        let date: Date = dateFormatter.date(from: arrivalDateTimeString)!
        
        // Finds the time interval between current datetime and the arrival datetime
        // Divides by 60 and rounds down to find the number of minutes
        // Rounds down as LTA specifies to round it down in documentation
        let timeLeft = ((date.timeIntervalSince(Date()))/60).rounded(.down)
        
        // Specifies the status of the bus (Arriving, Left, ETA etc.)
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
    
    // Retrieves the deck type of the bus by the deck type code
    // SD - single deck, DD - double deck, BD - bendy
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
    
    // Retrieves colour object based on vacancy of bus
    // SEA (seats available) - green, SDA (standing available) - yellow, LSD (limited standing) - red
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
    
    // Retrieves image name based on vacancy of bus
    // SEA (seats available) - green wheelchair icon, SDA (standing available) - yellow wheelchair icon, LSD (limited standing) - red wheelchair icon
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

        // Dismisses keyboard
        searchBar.resignFirstResponder()
        
        // Checks that there is text input in the search bar
        if searchBar.text != "" {
            // As users can only search bus stop name or bus stop code,
            // Retrieves the different bus stops by busstop name or bus stop code
            let busStopCodes: [BusStop] = self.GetBusStopsByBusStopNameOrCode(allBusStops: self.allBusStops, busStopNameOrCode: searchBar.text!)

            // Definies new table view data
            var newTableViewData: [cellData] = [cellData]()
            
            // Loops through the different bus stops
            for j in busStopCodes {
                
                // Retrieves bus services available by bus stop code
                let busServices: [Service] = self.GetBusServicesByBusStopCode(busStopCode: j.BusStopCode)
                
                // Sort based on bus service number (e.g. 52, 151, 154 etc.)
                var sortedArray = busServices.sorted(by: {x, y in return x.ServiceNo.compare(y.ServiceNo, options: .numeric, range: nil, locale: nil) == .orderedAscending})
                
                // Checks if there are any bus services available
                if sortedArray.count == 0 {
                    // There are no bus services available
                    let nextBus = NextBus(OriginCode: "", DestinationCode: "", EstimatedArrival: "", Latitude: "", Longitude: "", VisitNumber: "", Load: "", Feature: "", Type: "")
                    
                    let nextBus2 = NextBus2(OriginCode: "", DestinationCode: "", EstimatedArrival: "", Latitude: "", Longitude: "", VisitNumber: "", Load: "", Feature: "", Type: "")
                    
                    let nextBus3 = NextBus3(OriginCode: "", DestinationCode: "", EstimatedArrival: "", Latitude: "", Longitude: "", VisitNumber: "", Load: "", Feature: "", Type: "")
                    
                    sortedArray.append(Service(ServiceNo: "nil", Operator: "", NextBus: nextBus, NextBus2: nextBus2, NextBus3: nextBus3))
                }
                
                // Append data into the table view data list
                newTableViewData.append(cellData(opened: false, title: j.Description, subtitle: j.RoadName, sectionData: sortedArray))
            }
            
            // Defines the table view data and reloads table
            self.tableViewData = newTableViewData
            self.tableView.reloadData()
        }
    }
    
    // Retrieves bus stop details by the bus stop name
    func GetBusStopByBusStopName(allBusStops: [BusStop], busStopName: String) -> BusStop? {
        var busStop: BusStop? = nil
        
        for i in allBusStops {
            if i.Description == busStopName {
                busStop = i
                break
            }
        }
        
        return busStop
    }
    
    // Retrieves all bus stop details from API
    func GetAllBusStops() -> [BusStop] {
        var busStops: [BusStop] = [BusStop]()
        let sem = DispatchSemaphore.init(value: 0)
        
        // URL of Bus Stop API
        let uri = "http://datamall2.mytransport.sg/"
        let path = "ltaodataservice/BusStops?$skip="
        
        // As the API only retrieves a maximum of 500 records at a time, needs to loop through the skip numbers
        // to retrieve all records
        // e.g. to retrieve the next 500 records (501st to 1000th), API URL is
        // http://datamall2.mytransport.sg/ltaodataservice/BusRoutes?$skip=500
        // next set of 500 records is
        // http://datamall2.mytransport.sg/ltaodataservice/BusRoutes?$skip=1000 and so on
        for i in skipNumbers {
            let target = URL(string: uri + path + i)
            
            var request = URLRequest(url: target!)
            request.httpMethod = "GET"
            request.setValue("ocwKEJicQm+H7P7vospXiQ==", forHTTPHeaderField: "AccountKey")
            
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            // Retrieves data from API
            let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
                defer { sem.signal() }
                guard let data = data else { return }
                
                if error == nil && data != nil {
                    let decoder = JSONDecoder()
                    
                    do {
                        // Decodes JSON data
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
        return busStops
    }
    
    // Retrieves bus stop near the user's current location
    func GetBusStopNearby() -> [BusStop] {
        var currentLocLat: Double = 0
        var currentLocLong: Double = 0
        var nearbyBusStops: [BusStop] = [BusStop]()
        
        // Checks that the latest location is not nil
        if latestLocation?.coordinate.latitude != nil && latestLocation?.coordinate.longitude != nil {
            currentLocLat = latestLocation!.coordinate.latitude
            currentLocLong = latestLocation!.coordinate.longitude
            let currentLocationCoordinate: CLLocation = CLLocation(latitude: currentLocLat, longitude: currentLocLong)
            
            // Loops through all the different bus stops
            for i in allBusStops {
                let busStopLocationCoordinate: CLLocation = CLLocation(latitude: i.Latitude, longitude: i.Longitude)
                let distanceInMeters = currentLocationCoordinate.distance(from: busStopLocationCoordinate)
                
                // Checks if the distance between user's location and the bus stop location is within 1km radius
                if distanceInMeters <= 1000 {
                    // Distance between user's location and the bus stop location is within 1km radius
                    // Adds bus stop to list
                    nearbyBusStops.append(i)
                }
            }
        }

        // Returns list of nearby bus stops
        return nearbyBusStops
    }
    
    // Runs when the refresh button is clicked
    // Refreshes the arrival timing of the buses
    @IBAction func refreshButton(_ sender: Any) {

        // Displays alert to user to notify them to wait
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        self.present(alert, animated: true, completion: nil)
        
        // Background thread
        DispatchQueue.global(qos: .userInteractive).async {
            // Retrieves the updated bus arrival timings from API
            var newTableViewData: [cellData] = [cellData]()
            
            // Loops through the current bus stops in the user's table view
            for i in self.tableViewData {
                var sortedArray: [Service] = [Service]()
                
                // Using the bus stops in the user's table view, retrieves the bus stop details
                let busStop: BusStop = self.GetBusStopByBusStopName(allBusStops: self.allBusStops, busStopName: i.title)!
                // Retrieves the updated bus service arrival times from the API
                let busServices: [Service] = self.GetBusServicesByBusStopCode(busStopCode: busStop.BusStopCode)
                
                // Sort based on bus service number (e.g. 52, 151, 154 etc.)
                sortedArray = busServices.sorted(by: {x, y in return x.ServiceNo.compare(y.ServiceNo, options: .numeric, range: nil, locale: nil) == .orderedAscending})
                
                // Checks if the bus stop has any bus services operating
                if sortedArray.count == 0 {
                    // Bus stop currently has no bus services operating
                    let nextBus = NextBus(OriginCode: "", DestinationCode: "", EstimatedArrival: "", Latitude: "", Longitude: "", VisitNumber: "", Load: "", Feature: "", Type: "")
                    
                    let nextBus2 = NextBus2(OriginCode: "", DestinationCode: "", EstimatedArrival: "", Latitude: "", Longitude: "", VisitNumber: "", Load: "", Feature: "", Type: "")
                    
                    let nextBus3 = NextBus3(OriginCode: "", DestinationCode: "", EstimatedArrival: "", Latitude: "", Longitude: "", VisitNumber: "", Load: "", Feature: "", Type: "")
                    
                    sortedArray.append(Service(ServiceNo: "nil", Operator: "", NextBus: nextBus, NextBus2: nextBus2, NextBus3: nextBus3))
                }
                newTableViewData.append(cellData(opened: i.opened, title: i.title, subtitle: i.subtitle, sectionData: sortedArray))
            }
            self.tableViewData = newTableViewData
        }
        
        // Main thread
        DispatchQueue.main.async {
            // Reload the table data and dismisses the alert
            self.tableView.reloadData()
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    // Nearby button is pressed
    @IBAction func nearbyBtn(_ sender: Any) {
        
        // Displays alert to users to notify them to wait
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        self.present(alert, animated: true, completion: nil)
        
        // Background thread
        DispatchQueue.global(qos: .userInteractive).async {
            // This is run on the background queue
            var newTableViewData: [cellData] = [cellData]()
            
            // Retrieves the bus stop nearby first
            let nearbyBusStop: [BusStop] = self.GetBusStopNearby()
            
            // Loops through each nearby bus stops and retrieves the arrival timings for each bus service
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
            
            // Main thread
            DispatchQueue.main.async {
                // This is run on the main queue, after the previous code in outer block
                // Reloads table and dismisses alert
                self.tableView.reloadData()
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
}
