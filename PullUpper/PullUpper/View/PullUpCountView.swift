//
//  PullupCountView.swift
//  PullUpper
//
//  Created by 김병훈 on 6/17/24.
//

import SwiftUI

struct PullUpCountView: View {
    @StateObject private var pullUpCounter = PullUpCounter()
    
    @State private var progressTime = 0
    @State private var timer: Timer?
    @State private var hasAppeared = false
    
    @Binding var path: [String]
    
    let userGoal = UserDefaults.standard.integer(forKey: "userGoal")
    
    var minutes: Int {
        (progressTime % 3600) / 60
    }
    
    var seconds: Int {
        progressTime % 60
    }
    
    var body: some View {
        ZStack {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                Color.accentColor
                
                Image("whiteHalfTone")
                    .resizable()
                    .opacity(0.2)
                    .scaledToFit()
            }
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                VStack(spacing: 0) {
                    Text("COUNT")
                        .font(.system(size: 40, weight: .heavy))
                        .fontWidth(.expanded)
                        .foregroundStyle(.white)
                        .opacity(0.5)
                    
                    Text("\(pullUpCounter.pullUpCountInt)")
                        .font(.system(size: 128, weight: .heavy))
                        .fontWidth(.expanded)
                        .foregroundStyle(.white)
                        .frame(height: 128)
                }
                
                goalCircles()
                
                Spacer()
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("GOAL")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(.subText)
                        
                        Divider()
                        
                        HStack {
                            Text("\(userGoal)")
                                .font(.system(size: 48, weight: .black))
                                .fontWidth(.expanded)
                            
                            Text("PULL\nUPs")
                                .font(.system(size: 16, weight: .bold))
                                .fontWidth(.expanded)
                        }
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text("TIME")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(.subText)
                        
                        Divider()
                        
                        Text(String(format: "%02d", minutes)
                             + ":"
                             + String(format: "%02d", seconds))
                        .font(.system(size: 48, weight: .black))
                    }
                }
                .padding()
                
                NavigationLink(value: "ResultView") {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.black)
                            .frame(height: 66)
                        
                        Text("STOP")
                            .font(.system(size: 36, weight: .black))
                            .fontWidth(.expanded)
                    }
                }
                .simultaneousGesture(TapGesture().onEnded {
                    timer?.invalidate()
                    pullUpCounter.stopUpdates()
                })
            }
            .padding()
        }
        .onChange(of: hasAppeared) { _, appeared in
            if appeared {
                timerStart()
                pullUpCounter.startUpdates()
            }
        }
        .onAppear {
            hasAppeared = true
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func timerStart() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            progressTime += 1
        })
    }
    
    func goalCircles() -> some View {
        VStack {
            HStack {
                ForEach(1...10, id: \.self) { num in
                    if num <= userGoal {
                        if num <= pullUpCounter.pullUpCountInt {
                            Circle()
                                .foregroundColor(.mainBG)
                                .frame(width: 15, height: 15)
                        } else {
                            Circle()
                                .foregroundColor(.mainBG)
                                .frame(width: 5, height: 5)
                                .padding(5)
                        }
                    }
                }
            }
            .padding(.vertical, 20)
            
            HStack {
                ForEach(11...20, id: \.self) { num in
                    if num <= userGoal {
                        if num <= pullUpCounter.pullUpCountInt {
                            Circle()
                                .foregroundColor(.mainBG)
                                .frame(width: 15, height: 15)
                        } else {
                            Circle()
                                .foregroundColor(.mainBG)
                                .frame(width: 5, height: 5)
                                .padding(5)
                        }
                    }
                }
            }
        }
    }
}
