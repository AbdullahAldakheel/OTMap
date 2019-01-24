//
//  Map.swift
//  OTMAP
//
//  Created by Abdullah Aldakhiel on 11/01/2019.
//  Copyright © 2019 Abdullah Aldakhiel. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: ContainerViewController ,MKMapViewDelegate {
    
    @IBOutlet weak var MapView: MKMapView!
    override var locationInfo: locationInfo? {
        didSet {
            updatePins()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MapView.delegate = self
        
    }
    
    func updatePins() {
        guard let locations = locationInfo?.studentInfo else { return }

        var annotations = [MKPointAnnotation]()

        for location in locations {

            guard let latitude = location.latitude, let longitude = location.longitude else { continue }
            let lat = CLLocationDegrees(latitude)
            let long = CLLocationDegrees(longitude)

            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let first = location.firstName
            let last = location.lastName
            let mediaURL = location.mediaURL
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first ?? "") \(last ?? "")"
            annotation.subtitle = mediaURL
            
            annotations.append(annotation)
        }
        
        MapView.removeAnnotations(MapView.annotations)
        MapView.addAnnotations(annotations)
    }
    
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

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle!,
                let url = URL(string: toOpen), app.canOpenURL(url) {
                app.open(url, options: [:], completionHandler: nil)
            }
        }
    }
 
    

    @IBAction override func doLogOut(_ sender: Any) {
        Connection.statusLogIn = "loggOut"
        Connection.sessionUser = ""
        Connection.userInfo = UserInfo()
        performSegue(withIdentifier: "logOut", sender: "1")
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logOut" {
       
            segue.destination as? LogInController
        }
    }
    

}
