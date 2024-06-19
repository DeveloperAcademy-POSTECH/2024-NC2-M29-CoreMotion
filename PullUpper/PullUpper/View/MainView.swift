//
//  MainView.swift
//  PullUpper
//
//  Created by hanseoyoung on 6/17/24.
//

import SwiftUI

struct MainView: View {
    @State private var userGoal: Int = UserDefaults.standard.integer(forKey: "userGoal")
    @State private var isPickerPresented: Bool = false
    
    @Binding var path: [String]
    
    let goalNumbers: [Int] = Array(1...20)
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center){
                Text("PullUpper")
                    .font(.system(size: 40, weight: .heavy))
                    .fontWidth(.expanded)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .padding(.top, 59)

                Spacer()
                
                NavigationLink(value: "ActivityView") {
                    Image(systemName: "line.3.horizontal.circle.fill")
                        .font(.system(size: 32))
                }
                .padding(.top, 59)

            }
            .padding()
            
            Spacer()
            
            Text("GOAL")
                .font(.system(size: 42, weight: .heavy))
                .fontWidth(.expanded)
                .foregroundColor(.subText)
            
            Button(action: {
                // TODO: 헤드폰 연결 탐지, PullUpCountView로 넘어가기
                isPickerPresented = true
            }) {
                Text("\(userGoal)")
                    .font(.system(size: 96, weight: .heavy))
                    .fontWidth(.expanded)
                    .foregroundColor(.mainText)
                    .underline()
            }
            
            Spacer()
            
            ZStack {
                Image("Start_Button")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 77)
                
                
                NavigationLink(value: "PullUpCountView"){
                    ZStack {
                        Text("START")
                            .font(.system(size: 32, weight: .heavy))
                            .fontWidth(.expanded)
                            .foregroundColor(.mainText)
                        
                        Circle()
                            .frame(width: 200, height: 200)
                            .foregroundColor(.clear)
                    }
                }
                .navigationDestination(for: String.self) { pathValue in
                    if pathValue == "PullUpCountView" {
                        PullUpCountView(path: $path)
                    } else if pathValue == "ResultView" {
                        ResultView(path: $path)
                    } else if pathValue == "ActivityView" {
                        ActivityView(path: $path)
                    }
                }
            }
            
            Spacer()
        }
        .popup(isPresented: $isPickerPresented) {
            goalPickerPopup()
        }
    }
    
    // MARK: 목표 수정 피커
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
                // 버튼 수정 진행
                ZStack {
                    Color(.accent)
                        .frame(height: 50)
                        .cornerRadius(12)
                    Text("SET GOAL")
                        .font(.system(size: 20, weight: .black))
                        .fontWidth(.expanded)
                        .padding()
                        .foregroundColor(.black)
                }
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

