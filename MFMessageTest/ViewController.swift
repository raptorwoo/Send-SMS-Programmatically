//
//  ViewController.swift
//  MFMessageTest
//
//  Created by Jihwan Kim on 2020/03/10.
//  Copyright © 2020 LogicLead. All rights reserved.
//

import UIKit
import MessageUI


class ViewController: UIViewController {

    
    private let sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("SMS로 전송하기", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        
        button.addTarget(self, action: #selector(didTapSendButton(_:)), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpConstraints()
        
    }
    

    private func setUpView(){
        
        view.backgroundColor = UIColor.white
        view.addSubview(sendButton)
        
    }
    
    private func setUpConstraints() {
        
        setUpSendButtonConstraints()
        
    }
    
    private func setUpSendButtonConstraints(){
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    @objc func didTapSendButton(_ sender: UIButton) {
        //check whether this device can send sms
        guard MFMessageComposeViewController.canSendText() else {
            print("SMS services are not available")
            return
        }
        
        let composeViewController = MFMessageComposeViewController()
        composeViewController.recipients = ["01093829308"]
        composeViewController.body = """
        QuickScout Test Message
        """
        
        composeViewController.messageComposeDelegate = self
        present(composeViewController, animated: true, completion: nil)
    }
}

extension ViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        switch result {
        case .cancelled:
            print("message canceled")
            dismiss(animated: true, completion: nil)
            
        case .sent:
            print("sent message:", controller.body ?? "")
            dismiss(animated: true, completion: nil)
            
        case .failed:
            print("failed to send message")
            dismiss(animated: true, completion: nil)

        @unknown default:
            print("unknown Error")
            dismiss(animated: true, completion: nil)
        }
        
    }

}
