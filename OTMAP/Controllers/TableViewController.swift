//
//  TableViewController.swift
//  OTMAP
//
//  Created by Abdullah Aldakhiel on 21/01/2019.
//  Copyright © 2019 Abdullah Aldakhiel. All rights reserved.
//


import UIKit

class TableViewController: ContainerViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override var locationInfo: locationInfo? {
        didSet {
            guard let locationInfo = locationInfo else { return }
            locations = locationInfo.studentInfo
        }
    }
    var locations: [StudentInfo] = [] {
        didSet {
            locations.sort() {$0.createdAt! > $1.createdAt!}
            tableView.reloadData()
        }
    }

    @IBAction override func doLogOut(_ sender: Any) {
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
}


extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableInfo else {
            return UITableViewCell()
        }
        let l = locations[indexPath.row]
        cell.name.text = l.firstName
        cell.web.text = l.mediaURL
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let loc = locations[indexPath.row]
        if let url = URL(string: loc.mediaURL!),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
}
