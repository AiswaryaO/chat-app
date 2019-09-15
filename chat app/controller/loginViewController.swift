//
//  loginViewController.swift
//  chat app
//
//  Created by Chitra Hari on 13/08/19.
//  Copyright © 2019 Chitra Hari. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class loginViewController: UIViewController {
    
    @IBOutlet weak var lblEmail: UITextField!
    @IBOutlet weak var lblPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: lblEmail.text!, password: lblPassword.text!) { (user, error) in
            if error != nil {
            print (error!)
            }else {
                print("login successful!")
                let loginAlert = UIAlertController(title: "login successful", message: "You have successfully logged into you account", preferredStyle: .alert)
                let goToChat = UIAlertAction(title: "Got To Chat", style: .default, handler: { ACTION in
                    self.performSegue(withIdentifier: "goToChat", sender: self)
                    
                })
                loginAlert.addAction(goToChat)
                SVProgressHUD.dismiss()
                self.present(loginAlert, animated: true, completion: nil)
            }
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
