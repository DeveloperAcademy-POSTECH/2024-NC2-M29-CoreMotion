//
//  MainView.swift
//  PullUpper
//
//  Created by hanseoyoung on 6/17/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack {
            Text("PullUpper")
                .font(Font.custom("Stretch Pro", size: 36))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
        }
    }
}

#Preview {
    MainView()
}
