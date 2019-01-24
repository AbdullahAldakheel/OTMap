//
//  ViewController.swift
//  OTMAP
//
//  Created by Abdullah Aldakhiel on 04/01/2019.
//  Copyright © 2019 Abdullah Aldakhiel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
  

    
    @IBOutlet weak var getEmail: UITextField!
    @IBOutlet weak var getPass: UITextField!
    @IBOutlet weak var errorEmail: UILabel!
    @IBOutlet weak var errorPass: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func screenUp(_ sender: Any) {
        subscribeToKeyboardNotifications()

    }
    
    @IBAction func screenDown(_ sender: Any) {
        unsubscribeFromKeyboardNotifications()
    }
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardwillshow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
       
            NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardwillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
  
    }

    @objc func keyboardwillshow (_ notification:Notification){
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= getKeyboardHeight(notification)
            }
    }
    @objc func keyboardwillHide(_ notification:Notification){
        
        self.view.frame.origin.y = 0
        
    }
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        
        super.touchesBegan(touches, with: event)
    }
    
    @IBAction func logIn(_ sender: Any) {
        
    
        if getEmail.text == "" {
            errorEmail.text = "Email incorrect"
            return
        }else if  !isValidEmail(testStr: getEmail.text!){
            errorPass.text = "Email incorrect"
            return
        }
       
        if authenticateEmail(email: getEmail.text!, pass: errorPass.text!){
            performSegue(withIdentifier: "Checked", sender: "1")
        }else{
            errorEmail.text = "Email Or Password incorrect"
            return
        }

        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Checked" {
            
            segue.destination as? Map
        }
    }
    
    func authenticateEmail(email:String, pass:String) -> Bool {
        
        
        return true
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
}


