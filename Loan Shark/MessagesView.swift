//
//  MessagesView.swift
//  Loan Shark
//
//  Created by Yuhan Du on 20/11/22.
//

import Foundation
import UIKit
import SwiftUI
import MessageUI

struct MessageView: UIViewControllerRepresentable {
    
    var message: String
    var recipient: String
    
    func makeUIViewController(context: Context) -> MFMessageComposeViewController {
        let composeVC = MFMessageComposeViewController()
        
        composeVC.messageComposeDelegate = context.coordinator
        
        composeVC.recipients = [recipient]
        composeVC.body = message
        
        return composeVC
    }
    
    func updateUIViewController(_ uiViewController: MFMessageComposeViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    static var canSendText: Bool {
        MFMessageComposeViewController.canSendText()
    }
    
    class Coordinator: NSObject, MFMessageComposeViewControllerDelegate {
        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            
        }
    }
}
