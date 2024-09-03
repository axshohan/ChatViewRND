//
//  ChatHeaderView.swift
//  ChatStoryBoard
//
//  Created by Shohan Ahmed on 3/9/24.
//

import SwiftUI

struct ChatHeaderView: View {
    var onClose: () -> Void
    
    var body: some View {
        HStack {
            Button(action: {
                // Action for the close button
                onClose()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.axBlue)
                    .padding(.leading, 8)
                    .frame(width: 40, height: 40, alignment: .center)
            }
            Spacer()
            Text("Chat")
                .font(.system(size: 18))
                .bold()
                .foregroundColor(.axBlue)
            
            Spacer()
            Button(action: {
                // Action
                
            }) {
                Image(systemName: "plus")
                    .foregroundColor(.clear) // Invisible for balance
                    .frame(width: 30, height: 30, alignment: .center)
            }
        }
        .background(Color.chatbg) // Set the background color
    }
}

struct ChatHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ChatHeaderView   {
            // Example close action for preview
            print("ChatListView dismissed")
        }
    }
}
