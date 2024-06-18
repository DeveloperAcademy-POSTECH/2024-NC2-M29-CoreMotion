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

    var minutes: Int {
        (progressTime % 3600) / 60
    }

    var seconds: Int {
        progressTime % 60
    }

    var body: some View {
        NavigationStack {
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

                        // TODO: 풀업 갯수로 변경
                        Text("\(String(format: "%0.f", pullUpCounter.pullUpCount))")
                            .font(.system(size: 128, weight: .heavy))
                            .fontWidth(.expanded)
                            .foregroundStyle(.white)
                            .frame(height: 128)
                    }

                    Spacer()

                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("GOAL")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundStyle(.subText)

                            Divider()

                            HStack {
                                Text("20")
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
                            // TODO: 스탑워치
                            Text(String(format: "%02d", minutes)
                                 + ":"
                                 + String(format: "%02d", seconds))
                            .font(.system(size: 48, weight: .black))
                        }
                    }
                    .padding()

                    // TODO: ResultView 연결
                    Button(action: {
                        timer?.invalidate()
                        pullUpCounter.stopUpdates()
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.black)
                                .frame(height: 66)

                            Text("STOP")
                                .font(.system(size: 36, weight: .black))
                                .fontWidth(.expanded)
                        }
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
        }
        .navigationBarHidden(true)
    }

    func timerStart() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            progressTime += 1
        })
    }
}

#Preview {
    PullUpCountView()
}
