//
//  ConfirmLocationViewController.swift
//  OTMAP
//
//  Created by Abdullah Aldakhiel on 21/01/2019.
//  Copyright © 2019 Abdullah Aldakhiel. All rights reserved.
//


import UIKit
import MapKit

class ConfirmLocationViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var errorLabel: UILabel!
    var location: StudentInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMap()
    }
    
    @IBAction func finishTapped(_ sender: UIButton) {
        
        Connection.addLocation(self.location!) { created  in
            guard created == "" else {
                self.errorLabel.text = "error"
                return
            }
            
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    private func setupMap() {
        guard let location = location else { return }
        
        let lat = CLLocationDegrees(location.latitude!)
        let long = CLLocationDegrees(location.longitude!)
        
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                let annotation = MKPointAnnotation()

        annotation.coordinate = coordinate
        annotation.title = location.mapString
        mapView.addAnnotation(annotation)
                let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
    }
    
}

extension ConfirmLocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        var view = mapView.dequeueReusableAnnotationView(withIdentifier: "pin") as? MKPinAnnotationView
        
        if view == nil {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            view!.canShowCallout = true
            view!.pinTintColor = .red
            view!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            view!.annotation = annotation
        }
        
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle!,
                let url = URL(string: toOpen), app.canOpenURL(url) {
                app.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}
