//
//  TodoListViewViewModel.swift
//  ToDO List SwiftUI
//
//  Created by Shohan Ahmed on 19/8/24.
//

import Foundation
import Combine
import SwiftUI

/// ViewModel for list of items view
///  First Tab
class ChatListViewModel: ObservableObject{
    
    
    @Published var items: [ChatItem] = []
    @Published var newMessage: String = ""
    @Published var isDictationOn: Bool = false
    @Published var isChatViewExpanded: Bool = false
    @Published var scrollToBottomRequested: Bool = false
    
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        print("ChatListViewModel init -> \(UUID())")
        self.items.append( contentsOf: dummyChat())
        
        self.$isDictationOn
            .sink { isOn in
                // Handle the change
                print("Dictation is now \(isOn ? "ON" : "OFF")")
            }
            .store(in: &cancellables)
    }
    
    deinit {
        // Clean up any resources if needed
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
    
    func onSentButtonPress(message: String){
        sendMessage(message: message)
        newMessage.removeAll()
        if(isChatViewExpanded){
            isChatViewExpanded.toggle()
        }
        scrollToBottomRequested = true
    }
    
    /// Delete a chat
    /// - Parameter id: item id
    func delete(id: String){
        if let index = items.firstIndex(where: { $0.id == id }) {
            items.remove(at: index)
        }
    }
    
    func clearAll(){
        items.removeAll()
        // TODO close chat view
    }
    
    func sendMessage(message: String){
        if(!message.isEmpty){
            let newItem = ChatItem(id: UUID().uuidString,
                                   message: message,
                                   patientName: "New Patient",
                                   visitDate: Date().timeIntervalSince1970,
                                   chatDate: Date().timeIntervalSince1970,
                                   isSentbyMDS: false,
                                   isRead: true
            )
            withAnimation {
                items.append(newItem)
            }
        }
    }
    
    func dummyChat() -> [ChatItem] {
        return [
            ChatItem(id: UUID().uuidString, message: "Can you restate the name of the referral specialist?", patientName: "John Doe", visitDate: Date().timeIntervalSince1970, chatDate: Date().timeIntervalSince1970 - (86400*2), isSentbyMDS: true, isRead: false),
            ChatItem(id: UUID().uuidString, message: "How are you?", patientName: "Jane Smith", visitDate: Date().timeIntervalSince1970, chatDate: Date().timeIntervalSince1970, isSentbyMDS: false, isRead: true),
            ChatItem(id: UUID().uuidString, message: "Can you restate the name of the referral specialist?", patientName: "Alice Brown", visitDate: Date().timeIntervalSince1970, chatDate: Date().timeIntervalSince1970 - (86400/2), isSentbyMDS: true, isRead: true),
            ChatItem(id: UUID().uuidString, message: "Yes, referral specialist from HCA - Jacob Malone  MD. Please add their name on the order.", patientName: "Robert Johnson", visitDate: Date().timeIntervalSince1970, chatDate: Date().timeIntervalSince1970, isSentbyMDS: false, isRead: false),
            ChatItem(id: UUID().uuidString, message: "See you soon", patientName: "Michael Davis", visitDate: Date().timeIntervalSince1970, chatDate: Date().timeIntervalSince1970, isSentbyMDS: true, isRead: true),
            ChatItem(id: UUID().uuidString, message: "Hello again", patientName: "Laura Wilson", visitDate: Date().timeIntervalSince1970, chatDate: Date().timeIntervalSince1970, isSentbyMDS: true, isRead: false),
            ChatItem(id: UUID().uuidString, message: "Check-up required", patientName: "Peter Parker", visitDate: Date().timeIntervalSince1970, chatDate: Date().timeIntervalSince1970, isSentbyMDS: false, isRead: true),
            ChatItem(id: UUID().uuidString, message: "Your report is ready", patientName: "Clark Kent", visitDate: Date().timeIntervalSince1970, chatDate: Date().timeIntervalSince1970, isSentbyMDS: true, isRead: true),
            ChatItem(id: UUID().uuidString, message: "Follow up", patientName: "Bruce Wayne", visitDate: Date().timeIntervalSince1970, chatDate: Date().timeIntervalSince1970, isSentbyMDS: false, isRead: false),
            ChatItem(id: UUID().uuidString, message: "Appointment confirmed", patientName: "Diana Prince", visitDate: Date().timeIntervalSince1970, chatDate: Date().timeIntervalSince1970, isSentbyMDS: true, isRead: true)
        ]
    }
}
