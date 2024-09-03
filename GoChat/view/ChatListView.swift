//
//  ChatListView.swift
//
//  Created by Shohan Ahmed on 19/8/24.
//

import SwiftUI

public struct ChatListView: View {
    
    var onClose: () -> Void
    
    @StateObject var viewModel: ChatListViewModel = ChatListViewModel()
    
    // Public initializer
    public init(onClose: @escaping () -> Void) {
        self.onClose = onClose
    }
    
    public var body: some View {
        NavigationView{
            VStack(spacing: 0){
                //Header View
                ChatHeaderView(onClose: onClose)
                
                //Message List
                ZStack{
                    if !viewModel.items.isEmpty {
                        ScrollViewReader { proxy in
                            List{
                                ForEach(viewModel.items) { item in
                                    if(item.isSentbyMDS){
                                        MDSChatView(item: item)
                                            .listRowInsets(EdgeInsets())
                                            .listRowSeparator(.hidden)
                                            .swipeActions(edge: .trailing, allowsFullSwipe: false){
                                                Button(action: {
                                                    // Handle action
                                                    withAnimation {
                                                        viewModel.delete(id: item.id)
                                                    }
                                                }) {
                                                    Image(systemName: "xmark")
                                                        .foregroundColor(.white)
                                                        .tint(Color.red)
                                                        .cornerRadius(10)
                                                }
                                            }
                                        
                                    } else {
                                        ClinicianChatView(item: item)
                                            .listRowInsets(EdgeInsets())
                                            .listRowSeparator(.hidden)
                                            .swipeActions(edge: .trailing, allowsFullSwipe: false){
                                                Button(action: {
                                                    // Handle action
                                                    withAnimation {
                                                        viewModel.delete(id: item.id)
                                                    }
                                                }) {
                                                    Image(systemName: "xmark")
                                                        .foregroundColor(.white)
                                                        .tint(Color.red)
                                                        .cornerRadius(10)
                                                }
                                            }
                                    }
                                    // Separated the chat date and time from the item view to align with the swipeActions design
                                    ChatDateView(chatDate: Date(timeIntervalSince1970: item.visitDate))
                                        .listRowBackground(Color.clear)
                                        .listRowSeparator(.hidden)
                                        .frame(maxWidth: .infinity)
                                        .padding(.bottom, 16)
                                }
                                
                                Button(action: {
                                    // Action for clearing all messages
                                    withAnimation{
                                        viewModel.clearAll()
                                    }
                                }) {
                                    Text("Clear all")
                                        .foregroundColor(.blue)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                }
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                                
                                // Giving some space at bottom for better desing & for prevent accidental click on clear all
                                Spacer()
                                    .frame(height: 30)
                                    .id("listBottom")
                                    .listRowBackground(Color.clear)
                                    .listRowSeparator(.hidden)
                                
                            }
                            .listStyle(PlainListStyle())
                            .padding(0)
                            .onAppear{
                                // Scroll to bottom
                                proxy.scrollTo("listBottom", anchor: .bottom)
                            }
                        }
                    }
                    
                    // No message View
                    else {
                        VStack(spacing: 10) {
                            Text("No messages")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.axBlue)
                            
                            Text("As new messages are received, they will appear here for review.")
                                .font(.body)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                
                VStack(spacing: 0) {
                    ChatInputView(viewModel: viewModel)
                }
                
            }
            .background(Color.chatbg)
        }
    }
}

struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView {
            // Example close action for preview
            print("ChatListView dismissed")
        }
    }
}

