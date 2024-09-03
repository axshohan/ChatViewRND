//
//  MDSChatView.swift
//
//  Created by Shohan Ahmed on 19/8/24.
//

import SwiftUI

struct MDSChatView: View {
    
    let item: ChatItem
    
    var body: some View {
        
        VStack{
            // Chat card
            VStack{
                HStack{
                    ChatVisitTimeView(time: Date(timeIntervalSince1970: item.visitDate))
                        .foregroundColor(.black)
                        .font(.system(size: 14))
                    
                    Text(item.patientName)
                        .foregroundColor(.black)
                        .font(.system(size: 14))
                    
                    Spacer()
                    
                    if (!item.isRead){
                        Circle()
                            .fill(Color.green)
                            .frame(width: 8, height: 8)
                    }
                }
                .padding(.leading)
                .padding(.top)
                .padding(.trailing)
                
                Text(item.message)
                    .foregroundColor(.black)
                    .font(.system(size: 16))
                    .padding(.top, 2)
                    .padding(.leading, 14)
                    .padding(.bottom, 20)
                    .padding(.trailing)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .background(Color.white)
            .cornerRadius(6)
            .padding(.leading, 8)
            .padding(.trailing, 35)
            
        }
        .background(Color.chatbg)
    }
}

#Preview {
    MDSChatView(item: .init(
        id: "2323",
        message: "Test message for Preview",
        patientName: "Mr Patient",
        visitDate: Date().timeIntervalSince1970,
        chatDate: Date().timeIntervalSince1970,
        isSentbyMDS: true,
        isRead: false
    ))
}
