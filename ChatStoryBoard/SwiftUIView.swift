//
//  SwiftUIView.swift
//  ChatStoryBoard
//
//  Created by Shohan Ahmed on 31/8/24.
//

import SwiftUI

struct ViewItem: Identifiable {
    let id = UUID()
    let message: String
}

struct SwiftUIView: View {
    @State private var items: [ViewItem] = [
        ViewItem(message: "Hello, this is a message."),
        ViewItem(message: "Another message."),
        ViewItem(message: "A third message.")
    ]
    
    var body: some View {
        List(items) { item in
            HStack {
                  Text("Non-clickable text")
                  Spacer()
                  Button(action: {
                      print("Button clicked")
                  }) {
                      Text("Clickable Button")
                          .padding(.horizontal)
                          .contentShape(Rectangle())
                  }
                  .buttonStyle(PlainButtonStyle()) // Ensures only the button is clickable
              }
              .padding()
            .background(Color.chatbg) // Set the background color
        }
    }
}

#Preview {
    SwiftUIView()
}
