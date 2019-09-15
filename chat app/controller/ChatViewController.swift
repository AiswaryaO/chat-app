//
//  ChatViewController.swift
//  chat app
//
//  Created by Chitra Hari on 15/08/19.
//  Copyright © 2019 Chitra Hari. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD


class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var messageArray : [Message] = [Message]()
//    var msgArray = ["Message","Test", "qwerty"]
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBAction func BtnLogout(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
            
        } catch {
            print("Error : There was a problem in Loging Out")
        }
    }
    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var txtMsgText: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBAction func btnSend(_ sender: UIButton) {
        txtMsgText.endEditing(true)
        txtMsgText.isEnabled = false
        sendButton.isEnabled = false
        let messageDB = Database.database().reference().child("messages")
        let messageDictionary = ["Sender": Auth.auth().currentUser?.email, "MessageBody": txtMsgText.text!]
        messageDB.childByAutoId().setValue(messageDictionary){ (error,reference) in if error != nil {
            print(error!)
            
        }else {
            print("Message saved successfully!")
            
            self.txtMsgText.isEnabled = true
            self.sendButton.isEnabled = true
            self.txtMsgText.text = ""
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
     
         return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell",for: indexPath) as! CustomMessageCell
        
        cell.messageBody.text = messageArray[indexPath.row].messageBody
        cell.senderUserName.text = messageArray[indexPath.row].senderName
        cell.avatarImageView.image = UIImage(named: "pic")
        if cell.senderUserName.text == Auth.auth().currentUser?.email as String? {
            cell.avatarImageView.backgroundColor = UIColor.yellow
            cell.messageBackground.backgroundColor = UIColor.blue
    
        } else {
            cell.avatarImageView.backgroundColor = UIColor.red
            cell.messageBackground.backgroundColor = UIColor.brown
            
        }
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        messageTableView.delegate = self
        messageTableView.dataSource = self
        txtMsgText.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        
        messageTableView.addGestureRecognizer(tapGesture)
        
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier:"customMessageCell")
        messageTableView.separatorStyle = .none
        retriveMessages()
    }

    // MARK: - Table view data source
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 331
            self.view.layoutIfNeeded()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
        self.heightConstraint.constant = 73
        self.view.layoutIfNeeded()
    }
    
    }
    @objc func tableViewTapped() {
        txtMsgText.endEditing(true)
        
    }
    func retriveMessages() {
//    SVProgressHUD.show()
        let messageDB = Database.database().reference().child("messages")
        messageDB.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            let text = snapshotValue["MessageBody"]!
            let sender = snapshotValue["Sender"]!
            print(text,sender)
            
            let message = Message()
            message.messageBody = text
            message.senderName = sender
            self.messageArray.append(message)
            self.messageTableView.reloadData()
        }
        
    }
    
}
