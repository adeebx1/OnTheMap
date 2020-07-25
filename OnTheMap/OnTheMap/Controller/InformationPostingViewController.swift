//
//  InformationPostingViewController.swift
//  OnTheMap
//
//  Created by Adeeb alsuhaibani on 01/12/1441 AH.
//  Copyright © 1441 Adeebx1. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class InformationPostingViewController: UIViewController {
    
    
    @IBOutlet weak var addLocationTF: UITextField!
    
    @IBOutlet weak var AddMediaURLTF: UITextField!
    
    var location:StudentLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    func passStudentInfo(location:StudentLocation){
        getLocationInfo(address: location.mapString){
            (locationCoordination, error) in
            
            self.location?.longitude = locationCoordination.longitude
            self.location?.latitude = locationCoordination.latitude
            self.performSegue(withIdentifier: "submitLocation", sender: self.location)
        }
        
    }
    
    func getLocationInfo(address: String, completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
        DispatchQueue.main.async {
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(address) { (placemarks, error) in
                if error == nil {
                    if let thePlacemark = placemarks?[0] {
                        let location = thePlacemark.location!
                        
                        completionHandler(location.coordinate, nil)
                        return
                    }
                }else {
                    self.showAlert(message: "Please enter a valid address!", title: "Not valid address")
                }
                completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "submitLocation", let vc = segue.destination as? PostLocationViewController {
            vc.location = (sender as! StudentLocation)
        }
    }
    
    @IBAction func findLocationTapped(_ sender: Any) {
        
        guard let locationTextField = self.addLocationTF.text, locationTextField != "" else {
            self.showAlert(message: "Please enter a valid location! ", title: "Not valid location")
            return
        }
        guard let mediaURLTextField = self.AddMediaURLTF.text, mediaURLTextField != "" else {
            self.showAlert(message: "Please enter a valid URL! ", title: "Not valid URL")
            return
        }
        self.location = StudentLocation(firstName: "Jaz", lastName: "Rose", latitude: 0, longitude: 0, mapString: locationTextField , mediaURL: mediaURLTextField, uniqueKey: "65596693", objectId:"bsbea4cloqigfo8fq1pg", createdAt: "2020-07-23T18:03:55.002Z", updatedAt: "2020-06-23T00:47:25.440Z")
        
        passStudentInfo(location: location!)
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
