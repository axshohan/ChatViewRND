//
//  ViewController.swift
//  ChatStoryBoard
//
//  Created by Shohan Ahmed on 31/8/24.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    
    @IBOutlet var chatButton: UIButton!
    var chatListView: UIHostingController<ChatListView>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Attach the click listener
        chatButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
    }
    
    
    @objc func buttonClicked() {
    
      /*  self.chatListView = UIHostingController(rootView: ChatListView {
            [weak self] in
            self?.chatListView?.dismiss(animated: true, completion: nil)
        })
        
        guard let chatList = self.chatListView else { return }
        
        let navigationController = UINavigationController(rootViewController: chatList)
        navigationController.navigationBar.isHidden = true
        navigationController.isModalInPresentation = true // Disables swipe-to-dismiss
        self.present(navigationController, animated: true, completion: nil)*/
        
        
        self.chatListView = UIHostingController(rootView: ChatListView {
            [weak self] in
            self?.chatListView?.dismiss(animated: true, completion: nil)
        })

        guard let chatList = self.chatListView else { return }

        // Set the preferred content size to adjust the height
      //  chatList.preferredContentSize = CGSize(width: self.view.frame.width, height:  self.view.frame.height - 500) // Adjust the height here

        let navigationController = UINavigationController(rootViewController: chatList)
        navigationController.navigationBar.isHidden = true
        navigationController.isModalInPresentation = true // Disables swipe-to-dismiss
        navigationController.modalPresentationStyle = .formSheet // or .pageSheet

        self.present(navigationController, animated: true, completion: nil)

    }


}

