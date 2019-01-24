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
            let  a = StudentInfo(mapString: "de", mediaURL: "de")
            locations.append(a)
            tableView.reloadData()
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
        cell.name.text = l.mapString
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
