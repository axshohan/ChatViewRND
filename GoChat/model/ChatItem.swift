//
//  ChatItem.swift
//
//  Created by Shohan Ahmed on 19/8/24.
//

import Foundation

struct ChatItem: Identifiable, Equatable{ //Codable,
    let id: String
    let message: String
    let patientName: String
    let visitDate: TimeInterval
    let chatDate: TimeInterval
    let isSentbyMDS: Bool
    var isRead: Bool
    
    mutating func setReadStatus(_ state: Bool){
        isRead = state
    }
    
}
