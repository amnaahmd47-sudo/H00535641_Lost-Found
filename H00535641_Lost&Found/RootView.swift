//
//  RootView.swift
//  H00535641_Lost&Found
//
//

import SwiftUI

struct RootView: View {
    @State private var showLaunchScreen: Bool = true

  
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @AppStorage("rememberMe") private var rememberMe: Bool = true

    var body: some View {
        ZStack {
            if showLaunchScreen {
                LaunchScreenView()
            } else if isLoggedIn {
                ContentView()
            } else {
                LoginView()
            }
        }
        .task {
        
            if !rememberMe {
                isLoggedIn = false
            }

            try? await Task.sleep(for: .seconds(2.5))
            withAnimation {
                showLaunchScreen = false
            }
        }
    }
}

#Preview {
    RootView()
}
