//
//  LogInController.swift
//  OTMAP
//
//  Created by Abdullah Aldakhiel on 04/01/2019.
//  Copyright © 2019 Abdullah Aldakhiel. All rights reserved.
//

import UIKit

class LogInController: UIViewController {

    
  

    
    @IBOutlet weak var getEmail: UITextField!
    @IBOutlet weak var getPass: UITextField!
    @IBOutlet weak var errorEmail: UILabel!
    @IBOutlet weak var errorPass: UILabel!
    var logInSession:String = ""
    @IBOutlet weak var loadingImg: UIImageView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadingImg.isHidden = true
    }
    
    @IBAction func screenUp(_ sender: Any) {
        subscribeToKeyboardNotifications()

    }
    
    @IBAction func screenDown(_ sender: Any) {
        unsubscribeFromKeyboardNotifications()
    }

    
    @IBAction func logIn(_ sender: Any) {

    loadingImg.isHidden = false
        if getEmail.text == "" {
            errorEmail.text = "Email or pass incorrect"
            loadingImg.isHidden = true
            return
        }else if !isValidEmail(testStr: getEmail.text!){
            errorEmail.text = "Email or pass incorrect"
            loadingImg.isHidden = true
            return
        }
         authenticateEmail(email: getEmail.text!, pass: getPass.text!)
    }
    
    func authenticateEmail(email:String, pass:String) {
        Connection.login_now(username: email, password: pass)  { error in
            guard error == "" else {
                self.errorEmail.text = "Email or pass incorrect"
                self.loadingImg.isHidden = true

                return
            }
            DispatchQueue.main.async {
                
                self.performSegue(withIdentifier: "Checked", sender: "1")
                
            }
        }
    }

    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
}


extension UIViewController {
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(LogInController.keyboardwillshow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(LogInController.keyboardwillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
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
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        
        super.touchesBegan(touches, with: event)
    }
    
    
}
extension UIViewController {
    func startAnActivityIndicator() -> UIActivityIndicatorView {
        let ai = UIActivityIndicatorView(style: .gray)
        self.view.addSubview(ai)
        self.view.bringSubviewToFront(ai)
        ai.center = self.view.center
        ai.hidesWhenStopped = true
        ai.startAnimating()
        return ai
    }
}
extension UIViewController {
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
