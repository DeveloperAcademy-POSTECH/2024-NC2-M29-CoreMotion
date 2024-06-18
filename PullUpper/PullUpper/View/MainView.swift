//
//  MainView.swift
//  PullUpper
//
//  Created by hanseoyoung on 6/17/24.
//

import SwiftUI

import SwiftUI

struct MainView: View {
    @State private var userGoal: Int = UserDefaults.standard.integer(forKey: "userGoal")
    @State private var isPickerPresented: Bool = false

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

            Button(action: {
                isPickerPresented = true
            }) {
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
        .popup(isPresented: $isPickerPresented) {
            goalPickerPopup()
        }
    }

    private func goalPickerPopup() -> some View {
            VStack {
                Picker("Choose a goal count", selection: $userGoal) {
                    ForEach(goalNumbers, id: \.self) { goalNumber in
                        Text("\(goalNumber)")
                    }
                }
                .pickerStyle(.wheel)
                .labelsHidden()

                Button(action: {
                    UserDefaults.standard.set(self.userGoal, forKey: "userGoal")
                    isPickerPresented = false
                }) {
                    Text("Set Goal")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .frame(width: 300, height: 300)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 20)
        }
}

struct Popup<PopupContent: View>: ViewModifier {
    let popupContent: PopupContent
    @Binding var isPresented: Bool

    init(isPresented: Binding<Bool>, @ViewBuilder popupContent: () -> PopupContent) {
        self._isPresented = isPresented
        self.popupContent = popupContent()
    }

    func body(content: Content) -> some View {
        ZStack {
            content
                .blur(radius: isPresented ? 3 : 0)

            if isPresented {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)

                popupContent
            }
        }
    }
}

extension View {
    func popup<PopupContent: View>(isPresented: Binding<Bool>, @ViewBuilder popupContent: @escaping () -> PopupContent) -> some View {
        self.modifier(Popup(isPresented: isPresented, popupContent: popupContent))
    }
}

#Preview {
    MainView()
}
