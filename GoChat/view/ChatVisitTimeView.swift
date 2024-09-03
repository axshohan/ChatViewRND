//
//  ChatVisitTimeView.swift
//  GoChat
//
//  Created by Shohan Ahmed on 22/8/24.
//

import SwiftUI

struct ChatVisitTimeView: View {
    var time: Date
    
    var body: some View {
        Text(timeFormatted)
    }
    
    private var timeFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mma"
        formatter.amSymbol = "a"
        formatter.pmSymbol = "p"
        return formatter.string(from: time).lowercased()
    }
}

#Preview {
    ChatVisitTimeView(time:Date())
}
