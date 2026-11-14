//
//  H00535641_Lost_FoundApp.swift
//  H00535641_Lost&Found
//
//

import SwiftUI
import SwiftData

@main
struct H00535641_Lost_FoundApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        // database for posts
        .modelContainer(for: Item.self)
    }
}
