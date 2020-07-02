//
//  ChatViewController.swift
//  Flashiest App
//
//  Created by Kavisha on 07/08/19.
//  Copyright © 2019 SoKa. All rights reserved.
//

import UIKit
import  Firebase

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var messagesTableView: UITableView!
    
    @IBOutlet weak var messageTextField: UITextField!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    var messages : [Message] = [Message]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messagesTableView.delegate = self
        messagesTableView.dataSource = self
        
        messagesTableView.register(UINib(nibName: "CustomizedMessageCell", bundle: nil), forCellReuseIdentifier: "customizedMessageCell");
        
        messageTextField.delegate = self
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped));
        messagesTableView.addGestureRecognizer(gesture);
        
        self.tableViewRepaint();
        
        self.getMessages();
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Tableview methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customizedMessageCell", for: indexPath) as! CustomizedMessageCell;
//        cell.messageLabel.text = "What if a very huge message is entered here and then do the lines get cut or do they remain as is"
//        cell.avatarImage.image = UIImage(named: "egg");
//        cell.senderEmailLabel.text = "a@b.com"
        
        cell.messageLabel.text = messages[indexPath.row].senderMessage;
        cell.avatarImage.image = UIImage(named: "egg");
        cell.senderEmailLabel.text = messages[indexPath.row].sender;
        return cell;
    }

    @IBAction func sendButtonPressed(_ sender: Any) {
        
        //close the keyboard
        self.tableViewTapped();
        
        //create a msg dictionary
        let msgDictionary = ["sender" : Auth.auth().currentUser?.email, "messageBody" : messageTextField.text];
        
        self.messageTextField.isEnabled = false;
        
        //Set on the db
        let db = Database.database().reference().child("Messages");
        db.childByAutoId().setValue(msgDictionary) {
            (error, reference) in
            
            if error != nil {
                print("Error ocurred while saving messages.")
            } else {
                print("Msg saved succesfully.")
            }
            self.messageTextField.isEnabled = true;
            self.messageTextField.text = "";
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 325;
            self.view.layoutIfNeeded();
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 67;
            self.view.layoutIfNeeded();
        }
    }
    
    //MARK: - Logout button implementation
    @IBAction func logoutButtonPressed(_ sender: UIBarButtonItem) {
        
        do {
            try Auth.auth().signOut();
            print("Logged out successfully");
            
            navigationController?.popViewController(animated: true);
            
        } catch {
            print("Error logging out user");
        }
    }
    
    @objc func tableViewTapped() {
        messageTextField.endEditing(true);
    }
    
    func tableViewRepaint() {
        messagesTableView.rowHeight = UITableView.automaticDimension;
        messagesTableView.rowHeight = 120.0;
    }
    
    func getMessages() {
        
        let db = Database.database().reference().child("Messages");
        
        db.observe(.childAdded) {
            (snapshot) in
            
            let msg = snapshot.value as! Dictionary<String, String>;
            let email = msg["sender"];
            let messageBody = msg["messageBody"];
            
            self.messages.append(Message(email: email!, message: messageBody!));
            
            self.tableViewRepaint();
            self.messagesTableView.reloadData();
        }
        
       // let messageDB = Database.database().reference()
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
