//
//  ChatTextEditor.swift
//  GoCore
//
//  Created by Shohan Ahmed on 5/9/24.
//


import SwiftUI
import UIKit

struct ChatTextEditor: UIViewRepresentable {

    @ObservedObject var viewModel: ChatListViewModel
    @Binding var isFocused: Bool
    let characterLimit: Int
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: ChatTextEditor
        
        init(parent: ChatTextEditor) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            // Limit the character count to 180
            if textView.text.count > parent.characterLimit {
                textView.text = String(textView.text.prefix(parent.characterLimit))
            }
           
            // Use DispatchQueue to safely update the Binding
            DispatchQueue.main.async {
                self.parent.viewModel.newMessage = textView.text // Update the binding in the next run loop
            }
            textView.isScrollEnabled = true
            let cursorPosition = textView.selectedRange
            textView.scrollRangeToVisible(cursorPosition) // Ensure the cursor stays visible
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            parent.isFocused = true
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            parent.isFocused = false
        }
        
        @objc func toggleDictation() {
            parent.viewModel.isDictationOn.toggle()
            NotificationCenter.default.post(name: .updateToolbar, object: nil)
        }
        
        @objc func dismissKeyboard() {
            parent.isFocused = false
            if(parent.viewModel.newMessage.isEmpty){
                parent.viewModel.isChatViewExpanded = false
            }
        }
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.delegate = context.coordinator
        textView.backgroundColor = UIColor.clear
        
        // Create toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // Create microphone button
        let microphoneButton = UIButton(type: .custom)
        microphoneButton.setImage(UIImage(named: "microphoneIcon"), for: .normal)
        microphoneButton.frame = CGRect(x: 0, y: 0, width: 163, height: 40)
        microphoneButton.layer.cornerRadius = 10
        microphoneButton.addTarget(context.coordinator, action: #selector(Coordinator.toggleDictation), for: .touchUpInside)
        
        // Create keyboard dismiss button
        let keyboardButton = UIButton(type: .custom)
        keyboardButton.setImage(UIImage(named: "keyboardDown"), for: .normal)
        keyboardButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        keyboardButton.addTarget(context.coordinator, action: #selector(Coordinator.dismissKeyboard), for: .touchUpInside)
        
        // Add buttons to toolbar
        let microphoneBarButton = UIBarButtonItem(customView: microphoneButton)
        let keyboardBarButton = UIBarButtonItem(customView: keyboardButton)
        toolbar.items = [
            UIBarButtonItem.flexibleSpace(),
            microphoneBarButton,
            UIBarButtonItem.flexibleSpace(),
            keyboardBarButton
        ]
        
        // Update microphone background color based on isDictationOn state
        NotificationCenter.default.addObserver(forName: .updateToolbar, object: nil, queue: .main) { _ in
            if self.viewModel.isDictationOn {
                microphoneButton.backgroundColor = UIColor.axMidNightBlue // Background when dictation is ON
            } else {
                microphoneButton.backgroundColor = UIColor.clear // No background when dictation is OFF
            }
        }
        
        // Set toolbar as input accessory view
        textView.inputAccessoryView = toolbar
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = viewModel.newMessage
        if isFocused {
            uiView.becomeFirstResponder()
        } else {
            uiView.resignFirstResponder()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
}

// Extension to handle toolbar updates
extension Notification.Name {
    static let updateToolbar = Notification.Name("updateToolbar")
}
