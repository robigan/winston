//
//  EditCredentialProfile.swift
//  winston
//
//  Created by Igor Marcossi on 03/01/24.
//

import SwiftUI

struct EditCredentialProfile: View {
  let pictureURL: String?
  let username: String
  let statusInfo: StatusInfo
  
  struct StatusInfo: Equatable {
    let color: Color
    let lottieIcon: String
    let label: String
    let description: String
  }
  
  var body: some View {
    HStack(spacing: 12) {
      if let pictureURL, let url = URL(string: pictureURL) {
        URLImage(url: url)
          .frame(96)
          .clipShape(Circle())
      } else {
        Image(systemName: "circle.badge.questionmark.fill")
          .symbolRenderingMode(.hierarchical)
          .fontSize(80)
          .padding(.leading, -8)
          .frame(96)
          .foregroundStyle(.gray)
      }
      
      VStack(alignment: .leading, spacing: 2) {
        
        Text(username).fontSize(24, .bold)
        
        VStack(alignment: .leading, spacing: 2) {
          HStack(spacing: 3) {
            BetterLottieView(statusInfo.lottieIcon, size: 19, initialDelay: 0.315, color: statusInfo.color)
            
            Text(statusInfo.label)
              .fontSize(16, .semibold)
              .foregroundStyle(statusInfo.color)
              .transition(.scaleAndBlur)
              .id("verified-icon-\(statusInfo.label)")
          }
          
          Text(statusInfo.description.fixWidowedLines())
            .fontSize(13)
            .opacity(0.5)
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .multilineTextAlignment(.leading)
      }
    }
  }
}