//
//  PullUpperApp.swift
//  PullUpper
//
//  Created by hanseoyoung on 6/16/24.
//

import SwiftUI
import SwiftData

@main
struct PullUpperApp: App {
    var pullUpModelContainer: ModelContainer = {
        let schema = Schema([PullUpRecord.self])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            do {
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("\(error)")
            }
        } ()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .ignoresSafeArea()
        }
        .modelContainer(pullUpModelContainer)
    }
}
