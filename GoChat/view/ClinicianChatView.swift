//
//  ClinicianChatView.swift
//  GoChat
//
//  Created by Shohan Ahmed on 22/8/24.
//

import SwiftUI

struct ClinicianChatView: View {
    
    let item: ChatItem
    
    var body: some View {
        
        VStack{
            // Chat card
            VStack{
                
                Text(item.message)
                    .foregroundColor(.black)
                    .font(.system(size: 16))
                    .padding(.top)
                    .padding(.leading)
                    .padding(.bottom)
                    .padding(.trailing)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .background(Color.softBlue)
            .cornerRadius(6)
            .padding(.leading, 35)
            .padding(.trailing, 8)
        }
        .background(Color.chatbg)
    }
}

#Preview {
    ClinicianChatView(item: .init(
        id: "2323",
        message: "Yes, referral specialist from HCA - Jacob Malone MD. Please add their name on the order.",
        patientName: "Mr Patient",
        visitDate: Date().timeIntervalSince1970,
        chatDate: Date().timeIntervalSince1970,
        isSentbyMDS: true,
        isRead: false
    ))
}
