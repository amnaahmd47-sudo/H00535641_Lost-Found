//
//  RootView.swift
//  H00535641_Lost&Found
//
//

import SwiftUI

struct RootView: View {
    @State private var showLaunchScreen = true

    var body: some View {
        ZStack {
            if showLaunchScreen {
                LaunchScreenView()
            } else {
                ContentView()
            }
        }
        .task {
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
