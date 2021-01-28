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
    
    let npGeoCode: String = "535 Clementi Road Singapore 599489"
    let geoCoder = CLGeocoder()
    var myCoordinates: [Double] = [0, 0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Runninggg")
        
        
        let view = UIView()
        let button = UIButton(type: .system)
//        button.semanticContentAttribute = .forceRightToLeft
        button.setImage(UIImage(systemName: "qrcode.viewfinder"), for: .normal)
        button.setTitle(" Scan", for: .normal)
        button.addTarget(self, action: #selector(QRBtnClicked), for: .touchUpInside)
        button.sizeToFit()
        view.addSubview(button)
        view.frame = button.bounds
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: view)
        
        readerVC.delegate = self
        map.delegate = self
        map.showsUserLocation = true
        locationManager.delegate = locationDelegate
        
        AddAnnotationsOnMap()
        
        geoCoder.geocodeAddressString(npGeoCode, completionHandler: {p,e in
            
            let lat = p![0].location!.coordinate.latitude
            let long = p![0].location!.coordinate.longitude

            let npLocation = CLLocation(latitude: lat, longitude: long)
            self.centerMapOnLocation(location: npLocation, regionRadius: self.regionRadius)
        })
    }
        
    func centerMapOnLocation(location: CLLocation, regionRadius: CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        map.setRegion(coordinateRegion, animated: true)
    }
        
    
    func AddAnnotationsOnMap() {
        let mkpAnnotation = CustomAnnotation()
        mkpAnnotation.coordinate = CLLocationCoordinate2D(latitude: 1.332251, longitude: 103.774441)
        mkpAnnotation.title = "Makan Place, Block 58"
        mkpAnnotation.subtitle = "Ngee Ann Polytechnic"
        mkpAnnotation.url = ""
        mkpAnnotation.iconName = "bowl"
        self.map.addAnnotation(mkpAnnotation)
        
        let fcAnnotation = CustomAnnotation()
        fcAnnotation.coordinate = CLLocationCoordinate2D(latitude: 1.334217, longitude: 103.775498)
        fcAnnotation.title = "Food Club, Block 22"
        fcAnnotation.subtitle = "Ngee Ann Polytechnic"
        fcAnnotation.url = "https://www.safeentry-qr.gov.sg/tenant/PROD-T08GB0039A-803688-NGEEANNPOLYTECHNIC-SE"
        fcAnnotation.iconName = "bowl"
        self.map.addAnnotation(fcAnnotation)
        
        let poolsideAnnotation = CustomAnnotation()
        poolsideAnnotation.coordinate = CLLocationCoordinate2D(latitude: 1.335179, longitude: 103.77629)
        poolsideAnnotation.title = "Poolside, Block 18"
        poolsideAnnotation.subtitle = "Ngee Ann Polytechnic"
        poolsideAnnotation.iconName = "bowl"
        self.map.addAnnotation(poolsideAnnotation)
        
        let munchAnnotation = CustomAnnotation()
        munchAnnotation.coordinate = CLLocationCoordinate2D(latitude: 1.331992, longitude: 103.776518)
        munchAnnotation.title = "Munch, Block 73"
        munchAnnotation.subtitle = "Ngee Ann Polytechnic"
        munchAnnotation.url = "https://www.safeentry-qr.gov.sg/tenant/PROD-T08GB0039A-890218-BLOCK73MUNCH-SE"
        munchAnnotation.iconName = "bowl"
        self.map.addAnnotation(munchAnnotation)
        
        let studio27Annotation = CustomAnnotation()
        studio27Annotation.coordinate = CLLocationCoordinate2D(latitude: 1.3333305, longitude: 103.775412)
        studio27Annotation.title = "Studio 27, Block 27"
        studio27Annotation.subtitle = "Ngee Ann Polytechnic"
        studio27Annotation.iconName = "gameController"
        self.map.addAnnotation(studio27Annotation)
        
        let libraryAnnotation = CustomAnnotation()
        libraryAnnotation.coordinate = CLLocationCoordinate2D(latitude: 1.333708, longitude: 103.776727)
        libraryAnnotation.title = "Lien Ying Chow Library, Block 1"
        libraryAnnotation.subtitle = "Ngee Ann Polytechnic"
        libraryAnnotation.iconName = "book"
        self.map.addAnnotation(libraryAnnotation)
        
        let ourSpaceAnnotation = CustomAnnotation()
        ourSpaceAnnotation.coordinate = CLLocationCoordinate2D(latitude: 1.3313097, longitude: 103.7759623)
        ourSpaceAnnotation.title = "OurSpace@72, Block 72"
        ourSpaceAnnotation.subtitle = "Ngee Ann Polytechnic"
        ourSpaceAnnotation.iconName = "book"
        self.map.addAnnotation(ourSpaceAnnotation)
        
        let blk22Annotation = CustomAnnotation()
        blk22Annotation.coordinate = CLLocationCoordinate2D(latitude: 1.3343122, longitude: 103.7752522)
        blk22Annotation.title = "Block 22"
        blk22Annotation.subtitle = "Ngee Ann Polytechnic"
        blk22Annotation.iconName = "book"
        self.map.addAnnotation(blk22Annotation)

    }
    
    func GetAnnotationIconName(title: String) -> String {
        let foodIcons: [String] = ["Makan Place, Block 58", "Food Club, Block 22", "Poolside, Block 18", "Munch, Block 73"]
        let gameIcons: [String] = ["Studio 27, Block 27"]
        let bookIcons: [String] = ["Lien Ying Chow Library, Block 1", "OurSpace@72, Block 72", "Block 22"]
        
        var iconName: String = ""
        if foodIcons.contains(title) {
            iconName = "bowl"
        }
        else if gameIcons.contains(title) {
            iconName = "gameController"
        }
        else if bookIcons.contains(title) {
            iconName = "book"
        }
        return iconName
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 3
        
        let identifier = "AnnotationView"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(
          withIdentifier: identifier) as? MKMarkerAnnotationView {
          dequeuedView.annotation = annotation
          view = dequeuedView
        }
        else {
            
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            let smallSquare = CGSize(width: 30, height: 30)
//            let button = UIButton(frame: CGRect(origin: CGPoint.zero, size: smallSquare))
//            button.setBackgroundImage(UIImage(named: "disclosureIndicator"), for: .normal)
//            let btnImage = resizeImage(image: UIImage(named: "tableIndicator")!, targetSize: CGSize(width: 1, height: 1))
//            button.setImage(btnImage, for: .normal)
            let button = UIButton(frame: CGRect(origin: CGPoint.zero, size: smallSquare))
            let disclosure = UITableViewCell()
            disclosure.frame = button.bounds
            disclosure.accessoryType = .disclosureIndicator
            disclosure.isUserInteractionEnabled = false
            button.addSubview(disclosure)
            
            view.rightCalloutAccessoryView = button
            
            var leftImage: UIImage? = nil
            
            leftImage = UIImage(named: GetAnnotationIconName(title: annotation.title!!))?.withTintColor(UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1))
            
            let leftBtn = UIButton(frame: CGRect(origin: CGPoint.zero, size: smallSquare))
            leftBtn.setImage(leftImage, for: .normal)
            view.leftCalloutAccessoryView = leftBtn
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let lat: Double = (view.annotation?.coordinate.latitude)!
        let long: Double = (view.annotation?.coordinate.longitude)!
        self.centerMapOnLocation(location: CLLocation(latitude: lat, longitude: long), regionRadius: map.currentRadius())
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("The annotation was selected: \(String(describing: view.annotation?.title))")
        let annotation: CustomAnnotation = view.annotation as! CustomAnnotation
        let annotationURL = annotation.url
        let vc = SFSafariViewController(url: URL(string: annotationURL)!)

        present(vc, animated: true, completion: nil)
    }
    
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

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
    
    
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        print(result.value)
        dismiss(animated: true, completion: nil)
        
        // code to open the URL in safari upon scanning
        guard let url = URL(string: result.value) else { return }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
        
        
    }
    
    func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput){
        print("Switching capture to: \(newCaptureDevice.device.localizedName)")
        
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()

        dismiss(animated: true, completion: nil)
    }
    
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
    
    @objc func QRBtnClicked() {
        print("Works")
        readerVC.completionBlock = { (result: QRCodeReaderResult?) in
//            print(result!)
        }

        // Presents the readerVC as modal form sheet
        readerVC.modalPresentationStyle = .formSheet
       
        present(readerVC, animated: true, completion: nil)
    }
}

extension MKMapView {
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
