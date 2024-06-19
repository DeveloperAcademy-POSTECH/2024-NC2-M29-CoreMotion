//
//  ContentView.swift
//  PullUpper
//
//  Created by hanseoyoung on 6/19/24.
//

import SwiftUI

struct ContentView: View {
    @State private var navPath: [String] = []

    var body: some View {
        NavigationStack(path: $navPath) {
            MainView(path: $navPath)
                .ignoresSafeArea()
        }
    }
}
