//
//  MapViewController.swift
//  MAD2_Assignment
//
//  Created by Justin Ng on 27/1/21.
//

import Foundation
import UIKit
import CoreLocation
import MapKit
import SafariServices
import QRCodeReader
import AVFoundation

class MapViewController: UIViewController, MKMapViewDelegate, QRCodeReaderViewControllerDelegate {
    
    // Setting up of the location delegate and location manager
    let locationDelegate = LocationDelegate()
    var latestLocation: CLLocation? = nil
    
    let regionRadius: CLLocationDistance = 350
    
    let locationManager: CLLocationManager = {
        $0.requestWhenInUseAuthorization()
        $0.desiredAccuracy = kCLLocationAccuracyBest
        $0.startUpdatingLocation()
        $0.startUpdatingHeading()
        return $0
    }(CLLocationManager())
    
    @IBOutlet weak var QRBtn: UIBarButtonItem!
    

    @IBOutlet weak var map: MKMapView!
    
    // Defining the location for geocode to decode
    let npGeoCode: String = "535 Clementi Road Singapore 599489"
    let geoCoder = CLGeocoder()
    var myCoordinates: [Double] = [0, 0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adding the "scan" button with the QR logo at the top right hand of the navigation bar
        let view = UIView()
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "qrcode.viewfinder"), for: .normal)
        button.setTitle(" Scan", for: .normal)
        // Adding an onClick gesture
        // Runs the QRBtnClicked function on-click
        button.addTarget(self, action: #selector(QRBtnClicked), for: .touchUpInside)
        button.sizeToFit()
        view.addSubview(button)
        view.frame = button.bounds
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: view)
        
        // Setting the delegates for map, location manager and QR reader
        readerVC.delegate = self
        map.delegate = self
        map.showsUserLocation = true
        locationManager.delegate = locationDelegate
        
        // Adding all the SafeEntry annotations on the map view
        AddAnnotationsOnMap()
        
        // Decoding NP location
        geoCoder.geocodeAddressString(npGeoCode, completionHandler: {p,e in
            
            let lat = p![0].location!.coordinate.latitude
            let long = p![0].location!.coordinate.longitude

            let npLocation = CLLocation(latitude: lat, longitude: long)
            
            // Zooms in on NP location on the map view
            self.centerMapOnLocation(location: npLocation, regionRadius: self.regionRadius)
        })
    }
    
    // Centers the map on a specified location
    func centerMapOnLocation(location: CLLocation, regionRadius: CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        map.setRegion(coordinateRegion, animated: true)
    }
        
    // Adding all the SafeEntry locations as annotation on the map view
    func AddAnnotationsOnMap() {
        
        // Creates CustomAnnotation objects so that it can store the SafeEntry url of the respective locations
        let mkpAnnotation = CustomAnnotation()
        mkpAnnotation.coordinate = CLLocationCoordinate2D(latitude: 1.332251, longitude: 103.774441)
        mkpAnnotation.title = "Makan Place, Block 58"
        mkpAnnotation.subtitle = "Ngee Ann Polytechnic"
        mkpAnnotation.url = "https://www.safeentry-qr.gov.sg/tenant/PROD-T08GB0039A-NGEEANN-POLY-SE"
        self.map.addAnnotation(mkpAnnotation)
        
        let fcAnnotation = CustomAnnotation()
        fcAnnotation.coordinate = CLLocationCoordinate2D(latitude: 1.334217, longitude: 103.775498)
        fcAnnotation.title = "Food Club, Block 22"
        fcAnnotation.subtitle = "Ngee Ann Polytechnic"
        fcAnnotation.url = "https://www.safeentry-qr.gov.sg/tenant/PROD-T08GB0039A-803688-NGEEANNPOLYTECHNIC-SE"
        self.map.addAnnotation(fcAnnotation)
        
        let poolsideAnnotation = CustomAnnotation()
        poolsideAnnotation.coordinate = CLLocationCoordinate2D(latitude: 1.335179, longitude: 103.77629)
        poolsideAnnotation.title = "Poolside, Block 18"
        poolsideAnnotation.subtitle = "Ngee Ann Polytechnic"
        poolsideAnnotation.url = "https://www.safeentry-qr.gov.sg/tenant/PROD-T08GB0039A-NGEEANN-POLY-SE"
        self.map.addAnnotation(poolsideAnnotation)
        
        let munchAnnotation = CustomAnnotation()
        munchAnnotation.coordinate = CLLocationCoordinate2D(latitude: 1.331992, longitude: 103.776518)
        munchAnnotation.title = "Munch, Block 73"
        munchAnnotation.subtitle = "Ngee Ann Polytechnic"
        munchAnnotation.url = "https://www.safeentry-qr.gov.sg/tenant/PROD-T08GB0039A-890218-BLOCK73MUNCH-SE"
        self.map.addAnnotation(munchAnnotation)
        
        let studio27Annotation = CustomAnnotation()
        studio27Annotation.coordinate = CLLocationCoordinate2D(latitude: 1.3333305, longitude: 103.775412)
        studio27Annotation.title = "Studio 27, Block 27"
        studio27Annotation.subtitle = "Ngee Ann Polytechnic"
        studio27Annotation.url = "https://www.safeentry-qr.gov.sg/tenant/PROD-T08GB0039A-NGEEANN-POLY-SE"
        self.map.addAnnotation(studio27Annotation)
        
        let libraryAnnotation = CustomAnnotation()
        libraryAnnotation.coordinate = CLLocationCoordinate2D(latitude: 1.333708, longitude: 103.776727)
        libraryAnnotation.title = "Lien Ying Chow Library, Block 1"
        libraryAnnotation.subtitle = "Ngee Ann Polytechnic"
        libraryAnnotation.url = "https://www.safeentry-qr.gov.sg/tenant/PROD-T08GB0039A-NGEEANN-POLY-SE"
        self.map.addAnnotation(libraryAnnotation)
        
        let ourSpaceAnnotation = CustomAnnotation()
        ourSpaceAnnotation.coordinate = CLLocationCoordinate2D(latitude: 1.3313097, longitude: 103.7759623)
        ourSpaceAnnotation.title = "OurSpace@72, Block 72"
        ourSpaceAnnotation.subtitle = "Ngee Ann Polytechnic"
        ourSpaceAnnotation.url = "https://www.safeentry-qr.gov.sg/tenant/PROD-T08GB0039A-NGEEANN-POLY-SE"
        self.map.addAnnotation(ourSpaceAnnotation)
        
        let blk22Annotation = CustomAnnotation()
        blk22Annotation.coordinate = CLLocationCoordinate2D(latitude: 1.3343122, longitude: 103.7752522)
        blk22Annotation.title = "Block 22"
        blk22Annotation.subtitle = "Ngee Ann Polytechnic"
        blk22Annotation.url = "https://www.safeentry-qr.gov.sg/tenant/PROD-T08GB0039A-NGEEANN-POLY-SE"
        self.map.addAnnotation(blk22Annotation)
    }
    
    // Get the icons given the annotation title
    func GetAnnotationIconName(title: String) -> String {
        
        // List of annotation titles and their respective icon groups
        let foodIcons: [String] = ["Makan Place, Block 58", "Food Club, Block 22", "Poolside, Block 18", "Munch, Block 73"]
        let gameIcons: [String] = ["Studio 27, Block 27"]
        let bookIcons: [String] = ["Lien Ying Chow Library, Block 1", "OurSpace@72, Block 72", "Block 22"]
        
        var iconName: String = ""
        
        // If annotation belongs in foodIcons, they will have a bowl icon
        if foodIcons.contains(title) {
            iconName = "bowl"
        }
        // else if annotation belongs in gameIcons, they will have a game controller icon
        else if gameIcons.contains(title) {
            iconName = "gameController"
        }
        else if bookIcons.contains(title) {
            iconName = "book"
        }
        return iconName
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "AnnotationView"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(
          withIdentifier: identifier) as? MKMarkerAnnotationView {
          dequeuedView.annotation = annotation
          view = dequeuedView
        }
        else {
            // Allow the annotations to show callout (pop up, more details about the annotation)
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            
            // Adding the disclosure indicator to the annotation callout (">" icon)
            let smallSquare = CGSize(width: 30, height: 30)
            let button = UIButton(frame: CGRect(origin: CGPoint.zero, size: smallSquare))
            let disclosure = UITableViewCell()
            disclosure.frame = button.bounds
            disclosure.accessoryType = .disclosureIndicator
            disclosure.isUserInteractionEnabled = false
            button.addSubview(disclosure)
            
            // Setting the callout's right accessory as the disclosure indicator (">" icon)
            view.rightCalloutAccessoryView = button
            
            // Setting the icon for the respective annotations
            var leftImage: UIImage? = nil
            
            // Retrieves the annotation's icon using the GetAnnotationIconName function
            // Sets the icon colour to iOS default blue
            leftImage = UIImage(named: GetAnnotationIconName(title: annotation.title!!))?.withTintColor(UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1))
            let leftBtn = UIButton(frame: CGRect(origin: CGPoint.zero, size: smallSquare))
            leftBtn.setImage(leftImage, for: .normal)
            view.leftCalloutAccessoryView = leftBtn
        }
        return view
    }
    
    // Runs when an annotation is selected
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let lat: Double = (view.annotation?.coordinate.latitude)!
        let long: Double = (view.annotation?.coordinate.longitude)!
        
        // Centers the annotation on the user's map view
        self.centerMapOnLocation(location: CLLocation(latitude: lat, longitude: long), regionRadius: map.currentRadius())
    }
    
    // Runs when the callout of an annotation is selected
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        // Checks if annotation callout selected is the user's location
        if (view.annotation?.title == "My Location") {
            
        }
        else {
            // If callout selected is not user's location (means is SafeEntry annotation callout)
            // Cast annotation as CustomAnnotation object
            let annotation: CustomAnnotation = view.annotation as! CustomAnnotation
            let annotationURL = annotation.url
            
            // Opens SafeEntry URL in web view
            let vc = SFSafariViewController(url: URL(string: annotationURL)!)
            present(vc, animated: true, completion: nil)
        }
    }
    
    // function to resize image to a specified dimension (width x height)
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
    
    // Runs when the QR scanner has successfully scanned a QR code
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        print(result.value)
        dismiss(animated: true, completion: nil)
        
        // Opens the SafeEntry URL in a web view
        guard let url = URL(string: result.value) else { return }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
    }
    
    // When user rotates QR scanner camera
    func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput){
        print("Switching capture to: \(newCaptureDevice.device.localizedName)")
    }
    
    // When user clicks on cancel button
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()

        dismiss(animated: true, completion: nil)
    }
    
    // Configuring of the QR scanner
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            
            // Configure the view controller (optional)
            $0.showTorchButton        = true
            $0.showSwitchCameraButton = true
            $0.showCancelButton       = true
            $0.showOverlayView        = true
            // adjusts the height, width and position of the scanner outline
            $0.rectOfInterest         = CGRect(x: 0.2, y: 0.3, width: 0.6, height: 0.35)
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    
    // Runs when the "Scan" button at the right side of the navigation bar is clicked on
    @objc func QRBtnClicked() {
        print("Works")
        readerVC.completionBlock = { (result: QRCodeReaderResult?) in
        }

        // Presents the readerVC as modal form sheet
        readerVC.modalPresentationStyle = .formSheet
       
        present(readerVC, animated: true, completion: nil)
    }
}

extension MKMapView {
    
    // Retrieves the current radius of the map
    func topCenterCoordinate() -> CLLocationCoordinate2D {
            return self.convert(CGPoint(x: self.frame.size.width / 2.0, y: 0), toCoordinateFrom: self)
        }

        func currentRadius() -> Double {
            let centerLocation = CLLocation(latitude: self.centerCoordinate.latitude, longitude: self.centerCoordinate.longitude)
            let topCenterCoordinate = self.topCenterCoordinate()
            let topCenterLocation = CLLocation(latitude: topCenterCoordinate.latitude, longitude: topCenterCoordinate.longitude)
            return centerLocation.distance(from: topCenterLocation)
        }
    
    
}
