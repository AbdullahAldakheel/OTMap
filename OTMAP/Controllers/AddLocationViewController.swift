//
//  AddLocationViewController.swift
//  OTMAP
//
//  Created by Abdullah Aldakhiel on 21/01/2019.
//  Copyright © 2019 Abdullah Aldakhiel. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation


class AddLocationViewController: UIViewController {
    
    
    @IBOutlet weak var enterLoacation: UITextField!
    @IBOutlet weak var enterWebSite: UITextField!
    @IBOutlet weak var errorLocation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    @IBAction func findLocationTapped(_ sender: UIButton) {
        guard let location = enterLoacation.text,
            let mediaLink = enterWebSite.text,
            location != "", mediaLink != "" else {
                errorLocation.text = "Missing information"
                return
        }
        
        let studentLocation1 = StudentInfo(mapString: location, mediaURL: mediaLink)
        geocodeCoordinates(studentLocation1)
    }
    
    private func geocodeCoordinates(_ studentLocation: StudentInfo) {
        
        let ai = self.startAnActivityIndicator()
        CLGeocoder().geocodeAddressString(studentLocation.mapString!) { (placeMarks, err) in
            ai.stopAnimating()
            guard let firstLocation = placeMarks?.first?.location else { return }
            var location = studentLocation
            location.latitude = firstLocation.coordinate.latitude
            location.longitude = firstLocation.coordinate.longitude
            self.performSegue(withIdentifier: "goMap", sender: location)
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goMap", let vc = segue.destination as? ConfirmLocationViewController {
            vc.location = (sender as! StudentInfo)
        }
    }
    
    @IBAction func cancelAdd(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
