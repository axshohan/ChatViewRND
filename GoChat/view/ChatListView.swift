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
                        ScrollViewReader { scrollViewProxy in
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
                                .buttonStyle(PlainButtonStyle()) // Ensures only the button is clickable
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                                
                                // Giving some space at bottom for better desing & for prevent accidental click on clear all
                                Spacer()
                                    .frame(height: 20)
                                    .id("bottom")
                                    .listRowBackground(Color.clear)
                                    .listRowSeparator(.hidden)
                                
                            }
                            .listStyle(PlainListStyle())
                            .padding(0)
                            .onAppear{
                                withAnimation {
                                    scrollViewProxy.scrollTo("bottom", anchor: .bottom)
                                }
                            }
                            .onChange(of: viewModel.scrollToBottomRequested) { shouldScroll in
                                if shouldScroll {
                                    withAnimation {
                                        scrollViewProxy.scrollTo("bottom", anchor: .bottom)
                                    }
                                    // Reset the request
                                    viewModel.scrollToBottomRequested = false
                                }
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

