//
//  MainView.swift
//  PullUpper
//
//  Created by hanseoyoung on 6/17/24.
//

import SwiftUI

struct MainView: View {
    @State private var userGoal: Int = UserDefaults.standard.integer(forKey: "userGoal")

    let goalNumbers: [Int] = Array(1...20)

    var body: some View {
        VStack(spacing: 0) {
            Text("PullUpper")
                .font(Font.custom("StretchProRegular", size: 36))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .padding(.top, 80)

            Text("GOAL")
                .font(.system(size: 42, weight: .heavy))
                .fontWidth(.expanded)
                .foregroundColor(.subText)
                .padding(.top, 81)

            Menu {
                Picker(selection: $userGoal) {
                    ForEach(goalNumbers, id: \.self) { goalNumber in
                        Text("\(goalNumber)")
                    }
                } label: { }
            } label: {
                Text("\(userGoal)")
                    .font(.system(size: 96, weight: .heavy))
                    .fontWidth(.expanded)
                    .foregroundColor(.mainText)
                    .underline()
            }

            Button(action: {
                UserDefaults.standard.set(self.userGoal, forKey: "userGoal")
            }, label: {
                ZStack {
                    Image("Start_Button")
                        .resizable()
                        .aspectRatio(contentMode: .fit)

                    Text("START")
                        .font(.system(size: 32, weight: .heavy))
                        .fontWidth(.expanded)
                        .foregroundColor(.mainText)
                }
            })
            .padding(.top, 89)
            .padding(.horizontal, 77)

            Spacer()
        }
    }
}

#Preview {
    MainView()
}
