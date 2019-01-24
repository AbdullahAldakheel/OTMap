//
//  Map.swift
//  OTMAP
//
//  Created by Abdullah Aldakhiel on 11/01/2019.
//  Copyright © 2019 Abdullah Aldakhiel. All rights reserved.
//

import UIKit

class Map: UIViewController {
    


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func logOut(_ sender: Any) {
        performSegue(withIdentifier: "logOut", sender: "1")

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logOut" {
       
            segue.destination as? ViewController
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
