//
//  RegViewController.swift
//  chat app
//
//  Created by Chitra Hari on 13/08/19.
//  Copyright © 2019 Chitra Hari. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegViewController: UIViewController {
    
    @IBOutlet weak var txtEtnMail: UITextField!
    @IBOutlet weak var txtEtnPAssword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnRegister(_ sender: UIButton) {
        SVProgressHUD.show()
        
        Auth.auth().createUser(withEmail: txtEtnMail.text!, password: txtEtnPAssword.text!) { (user,error) in if error != nil {
            print(error!)
            
            }
        else {
            print("Registration Successfull!")
        let regAlert = UIAlertController(title: "registration successfull!", message: "you have successfully created an account", preferredStyle: .alert)
        let goToChat = UIAlertAction (title: "Go to chat", style: .default, handler: { Action in
            self.performSegue(withIdentifier: "goToChat", sender: self)
        })
            regAlert.addAction(goToChat)
            SVProgressHUD.dismiss()
            self.present(regAlert, animated: true, completion: nil)
            
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
}
