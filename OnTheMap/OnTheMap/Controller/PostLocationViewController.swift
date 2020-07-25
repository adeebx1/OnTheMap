//
//  PostLocationViewController.swift
//  OnTheMap
//
//  Created by Adeeb alsuhaibani on 03/12/1441 AH.
//  Copyright © 1441 Adeebx1. All rights reserved.
//


import UIKit
import MapKit

class PostLocationViewController: UIViewController, MKMapViewDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    var location: StudentLocation!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMapInfo()
    }
    
    
    func setMapInfo(){
        
        
        let lat = CLLocationDegrees(self.location.latitude)
        let long = CLLocationDegrees(self.location.longitude)
        
        // The lat and long are used to create a CLLocationCoordinates2D instance.
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        let first = location.firstName
        let last = location.lastName
        let mediaURL = location.mediaURL
        
        // Here we create the annotation and set its coordiate, title, and subtitle properties
        let annotations = MKPointAnnotation()
        annotations.coordinate = coordinate
        annotations.title = "\(first) \(last)"
        annotations.subtitle = mediaURL
        
        self.mapView.addAnnotation(annotations)
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
    }
    
    
    // MARK: - MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    @IBAction func finishPostLocation(_ sender: Any) {
        OnTheMapClient.postStudentLocation(studentLocation: location, completion: handlePostLocation(success:error:))
    }
    
    func handlePostLocation(success:Bool,error:Error?){
        if success{
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
        else{
            DispatchQueue.main.async {
                self.showAlert(message: error!.localizedDescription , title: "Post location failed")
            }
        }
        
        
    }
    
}
