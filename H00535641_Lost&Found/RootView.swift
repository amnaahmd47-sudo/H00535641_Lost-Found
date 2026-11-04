//
//  RootView.swift
//  H00535641_Lost&Found
//
//

import SwiftUI

struct RootView: View {
    // show launch screen first
    @State private var showLaunchScreen: Bool = true

    // saved login info
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @AppStorage("rememberMe") private var rememberMe: Bool = true

    var body: some View {
        ZStack {
            // pick which screen to show
            if showLaunchScreen {
                LaunchScreenView()
            } else if isLoggedIn {
                ContentView()
            } else {
                LoginView()
            }
        }
        .task {
            // log out if remember me is off
            if !rememberMe {
                isLoggedIn = false
            }

            // wait 2.5 seconds then hide launch screen
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
