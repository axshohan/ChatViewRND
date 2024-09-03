//
//  ChatDateView.swift
//  GoChat
//
//  Created by Shohan Ahmed on 22/8/24.
//

import SwiftUI

struct ChatDateView: View {
    let chatDate: Date
    
    var body: some View {
        // Added modifiers here to keep it same to all view
        VStack{
            Text(formatDate(chatDate))
                .foregroundColor(.chatDate)
                .font(.system(size: 12))
        }
    }
    
    func formatDate(_ date: Date) -> String {
        let calendar = Calendar.current
        
        // Check if the date is today
        if calendar.isDateInToday(date) {
            // Format for today
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "h:mm a"
            return "Today, \(timeFormatter.string(from: date))"
        } else {
            // Format for other days
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "M/d/yy, h:mm a"
            return dateFormatter.string(from: date)
        }
    }
}

#Preview {
    ChatDateView(chatDate: Date())
}
