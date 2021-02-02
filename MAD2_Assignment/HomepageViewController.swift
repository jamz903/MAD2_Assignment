//
//  HomepageViewController.swift
//  MAD2_Assignment
//
//  Created by Justin Ng on 31/1/21.
//

import Foundation
import UIKit
import ImageSlideshow
import SafariServices

class HomepageViewController: UIViewController, ImageSlideshowDelegate {
    

    @IBOutlet weak var Imageview: ImageSlideshow!
    @IBOutlet weak var foodCourtAPIImage: UIImageView!
    @IBOutlet weak var foodCourtContainer: UIView!
    @IBOutlet weak var busArrivalImage: UIImageView!
    @IBOutlet weak var busArrivalContainer: UIView!
    @IBOutlet weak var TOMSImage: UIImageView!
    @IBOutlet weak var TOMSContainer: UIView!
    
    // Defining the images to be used for slideshow/carousel
    let localSource = [BundleImageSource(imageString: "ngeeAnn1"), BundleImageSource(imageString: "ngeeAnn2"), BundleImageSource(imageString: "ngeeAnn3"), BundleImageSource(imageString: "ngeeAnn4")]

    var buttonContainers: [UIView] = [UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Naming the "< Back" button for view controllers that will be loaded later
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        // Desining the Food Court API, Bus Arrival API and TOMS button
        // Also adds the onClick function to these buttons
        buttonContainers = [foodCourtContainer, busArrivalContainer, TOMSContainer]
        for i in buttonContainers {
            i.layer.cornerRadius = 10
            if i == foodCourtContainer {
                // On-click, run the foodCourtOnClick function
                let gesture = UITapGestureRecognizer(target: self, action: #selector(self.foodCourtOnClick))
                i.addGestureRecognizer(gesture)
            }
            else if i == busArrivalContainer {
                // On-click, run the busArrivalOnClick function
                let gesture = UITapGestureRecognizer(target: self, action: #selector(self.busArrivalOnClick))
                i.addGestureRecognizer(gesture)
            }
            else if i == TOMSContainer {
                // On-click, run the TOMSOnClick function
                let gesture = UITapGestureRecognizer(target: self, action: #selector(self.TOMSOnClick))
                i.addGestureRecognizer(gesture)
            }
        }
        
        // Setting the images
        foodCourtAPIImage.image = UIImage(named: "food")
        busArrivalImage.image = UIImage(named: "busStop")
        TOMSImage.image = UIImage(named: "TOMS")
        
        // Designing the slideshow/carousel
        Imageview.slideshowInterval = 5.0
        Imageview.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        Imageview.contentScaleMode = UIViewContentMode.scaleAspectFill

        // Designing of the slideshow/carousel page indicator (page dots)
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        Imageview.pageIndicator = pageControl
        
        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        Imageview.activityIndicator = DefaultActivityIndicator()
        Imageview.delegate = self

        // can be used with other sample sources as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
        // Setting of the image source
        Imageview.setImageInputs(localSource)

        // Runs the didTap function when an image of the slideshow/carousel is clicked on
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        Imageview.addGestureRecognizer(recognizer)
        
    }
    
    // When image of the slideshow/carousel is tapped
    @objc func didTap() {
        let fullScreenController = Imageview.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: UIActivityIndicatorView.Style.medium, color: nil)
    }
    
    // When slideshow/carousel image changes
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        print("current page:", page)
    }
    
    // When Bus Arrival API button is selected
    @objc func busArrivalOnClick(_ sender: UITapGestureRecognizer) {
        // Launches the respective view controller
        let controller = storyboard?.instantiateViewController(withIdentifier: "BusArrival")
        self.navigationController?.pushViewController(controller!, animated: true)
    }
    
    // When Food Court API button is selected
    @objc func foodCourtOnClick(_ sender: UITapGestureRecognizer) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "FoodCourtAPI")
        self.navigationController?.pushViewController(controller!, animated: true)
    }
    
    // When TOMS button is selected
    @objc func TOMSOnClick(_ sender: UITapGestureRecognizer) {
        let vc = SFSafariViewController(url: URL(string: "https://npweb.np.edu.sg/np/TravelDeclare/Pages/StudentTOMS.aspx")!)
        present(vc, animated: true)
    }
}
