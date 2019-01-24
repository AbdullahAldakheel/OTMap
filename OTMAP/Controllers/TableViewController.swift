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
            tableView.reloadData()
        }
    }
    
}


extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
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
    
}
