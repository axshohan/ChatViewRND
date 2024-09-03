//
//  ChatInputView.swift
//  GoChat
//
//  Created by Shohan Ahmed on 22/8/24.
//

import SwiftUI
import Combine

struct ChatInputView: View {
    
    @ObservedObject var viewModel: ChatListViewModel
    
    var body: some View {
        VStack {
            if viewModel.isChatViewExpanded {
                // Expanded chat view
                ChatViewExpanded(viewModel: viewModel)
            } else {
                // Initial compact view with TextField and microphone icon
                InputViewSmall(isDictationOn: $viewModel.isDictationOn, isChatViewExpanded: $viewModel.isChatViewExpanded)
                    .onTapGesture {
                        viewModel.isChatViewExpanded = true
                    }
            }
        }.background(Color.chatbg)
    }
    
    struct ChatViewExpanded: View {
        @ObservedObject var viewModel: ChatListViewModel
        
        let characterLimit = 180
        @FocusState private var isFocused: Bool
        
        var body: some View {
            VStack{
                VStack {
                    TextEditor(text: $viewModel.newMessage.limit(characterLimit))
                        .font(.system(size: 15))
                        .frame(minHeight: 40, maxHeight: 58) // Adjust the height to show approximately 3 lines
                        .textFieldStyle(PlainTextFieldStyle())
                        .focused($isFocused)
                        .onAppear {
                            isFocused = true // Automatically focus the TextField when the view appears
                        }
                        .toolbar{
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                if viewModel.isDictationOn {
                                    Button(action: {
                                        // TODO turn on Dictation recording
                                        viewModel.isDictationOn.toggle()
                                    }) {
                                        Image(systemName: "mic")
                                            .frame(width: 163, height: 40, alignment: .center)
                                            .background(Color.midNightBlue)
                                            .cornerRadius(13)
                                    }
                                } else {
                                    Button(action: {
                                        // TODO turn on Dictation recording
                                        viewModel.isDictationOn.toggle()
                                    }) {
                                        Image(systemName: "mic")
                                            .frame(width: 163, height: 40, alignment: .center)
                                    }
                                }
                                Spacer()
                                Button(action: {
                                    // Keyboard dismiss action
                                    
                                    isFocused = false
                                    if(viewModel.isDictationOn){
                                        viewModel.isDictationOn.toggle()
                                    }
                                    if viewModel.newMessage.trimmingCharacters( in:.whitespaces).isEmpty {
                                        if(viewModel.isChatViewExpanded){
                                            viewModel.isChatViewExpanded.toggle()
                                        }
                                    }
                                }) {
                                    
                                    // TODO Have to change the image icon
                                    Image(systemName: "keyboard.chevron.compact.down")
                                }
                            }
                        }
                    
                    // HStack for character count and send button
                    HStack(alignment: .bottom) {
                        Text("\(viewModel.newMessage.count)/\(characterLimit)")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        Button(action:{
                            //Action
                            isFocused = false
                            viewModel.onSentButtonPress(message: viewModel.newMessage)
                        }) {
                            Image(systemName: "paperplane")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: 24, height: 24)
                                .padding(10)
                                .background(Color.axBlue)
                                .opacity(viewModel.newMessage.isEmpty ? 0.6: 1.0)// Change color based on state
                                .cornerRadius(30)
                        }.disabled(viewModel.newMessage.isEmpty)
                    }
                }
                .padding(10)
                .background(Color.white)
                .cornerRadius(6)
                .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 0)
                .transition(.move(edge: .bottom)) // Animation for expanding
            }
            .padding(.leading, 8)
            .padding(.trailing, 5)
            .padding(.top, 5)
            .padding(.bottom, 8)
        }
    }
    struct InputViewSmall: View {
        @Binding var isDictationOn: Bool
        @Binding var isChatViewExpanded: Bool
        
        var body: some View {
            VStack{
                HStack {
                    Text("Reply here...")
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .opacity(0.4)
                        .padding(.top, 12)
                        .padding(.leading, 6)
                        .padding(.trailing, 20)
                        .padding(.bottom, 12)
                    Spacer()
                    Button(action: {
                        // Handle microphone action
                        isDictationOn = true
                        isChatViewExpanded = true
                    }) {
                        Image(systemName: "mic")
                            .foregroundColor(.axBlue)
                            .frame(width: 35,height: 35)
                            .padding(.trailing, 10)
                    }
                }
                .background(Color.white)
                .cornerRadius(6)
                .padding(.top, 13)
                .padding(.horizontal)
                .padding(.bottom, 24)
                .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 3)
                
                
            }.background(Color.chatbg)
                .padding(.top, 10)
                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: -6)
        }
    }
    
}

struct ChatInputViewPreview: View {
    @StateObject var viewModel: ChatListViewModel = ChatListViewModel()
    
    var body: some View {
        ChatInputView(viewModel: viewModel)
    }
}

struct ChatInputView_Previews: PreviewProvider {
    
    static var previews: some View {
        ChatInputViewPreview()
    }
}



