//
//  Onboarding.swift
//  MusicApp(final_project)
//
//  Created by yunus on 29.04.2025.
//
import SwiftUI

struct WelcomeScreen: View {
    var body: some View {
        ZStack {
            // Background color
            Color(red: 0.4, green: 0.8, blue: 0.9)
                .ignoresSafeArea()
            

            
            VStack(spacing: 0) {
                // Main image - in real app would use an actual image asset
                Image("OnboardingGirl") // Replace with your image asset
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 300)
                
                Spacer()
                
                // Bottom card with "Get Started" button
                VStack {
                    Spacer()
                    
                    // Progress indicator
                    HStack {
                        RoundedRectangle(cornerRadius: 2)
                            .frame(width: 80, height: 4)
                            .foregroundColor(.teal)
                        RoundedRectangle(cornerRadius: 2)
                            .frame(width: 80, height: 4)
                            .foregroundColor(.white.opacity(0.5))
                    }
                    .padding(.bottom, 30)
                    
                    // Button
                    Button(action: {
                        // Action for button tap
                        print("Get Started tapped")
                    }) {
                        Text("Get Started")
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color.white)
                            )
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 30)
                }
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.black)
                        .opacity(0.8)
                )
                .frame(height: 200)
            }
        }
    }
}

// Preview provider
struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
    }
}
