////
////  ContainerViewController.swift
////  OTMAP
////
////  Created by Abdullah Aldakhiel on 21/01/2019.
////  Copyright © 2019 Abdullah Aldakhiel. All rights reserved.
////

import UIKit

class ContainerViewController: UIViewController {
    
    var locationInfo: locationInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadStudentLocations()
    }
    
    
    @IBAction func addLocation(_ sender: Any) {
        let navController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddLocationNavigationController") as! UINavigationController
        
        present(navController, animated: true, completion: nil)
        
    }

    @IBAction func refreshLocation(_ sender: Any) {
        loadStudentLocations()

    }
    
    
    @IBAction func doLogOut(_ sender: Any) {
        Connection.statusLogIn = "loggOut"
        Connection.sessionUser = ""
        Connection.userInfo = UserInfo()
        Connection.logout_now() { error in
            guard error == "" else {
                return
            }
            DispatchQueue.main.async {
               self.performSegue(withIdentifier: "logOut", sender: "1")
            }
        }
       
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logOut" {
            
            segue.destination as? LogInController
        }
    }
    
    
    private func loadStudentLocations() {
        Connection.getUserLocations { (data) in
            guard let data = data else {
                self.showAlert(title: "Error", message: "No internet connection found")
                return
            }
            guard data.studentInfo.count > 0 else {
                self.showAlert(title: "Error", message: "No pins found")
                return
            }
            self.locationInfo = data
        }
    }
    
}
