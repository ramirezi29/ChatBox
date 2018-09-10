//
//  ChatViewController.swift
//  ChatBoxiOS21
//
//  Created by Ivan Ramirez on 9/10/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    @IBOutlet weak var chatTextField: UITextField!
    @IBOutlet weak var chatBoxLabel: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var storyBoardImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePopUp()
        designDoneButton()
        designDoneButtonTextField()
    view.addVerticalGradientLayer(topColor: .black, bottomColor: .clear)
    }

    
    @IBAction func sendChatButtonTapped(_ sender: Any) {
        // success can be true or false
        guard let message = chatTextField.text, message != "" else {return}
        ChatController.shared.createChat(with: message) { (success) in
            print("#1 Are you on the main \(Thread.isMainThread)")
            // this code below is putting every thing on the main thread
            DispatchQueue.main.async {
                self.chatTextField.text = ""
                print("#2 Hey you are you on the main? \(Thread.isMainThread)")
            }
        }
    }
    func imagePopUp(){
        storyBoardImage.image = UIImage(named: "supermarioghost_1_copy")
    }
    func designDoneButton() {
        sendButton.layer.borderWidth = 4
        sendButton.layer.borderColor = UIColor.cyan.cgColor
        sendButton.layer.cornerRadius = sendButton.frame.height / 40
        
    }
    func designDoneButtonTextField() {
        chatTextField.layer.borderWidth = 4
        chatTextField.layer.borderColor = UIColor.cyan.cgColor
        chatTextField.layer.cornerRadius = chatTextField.frame.height / 40
        
    }
}
