//
//  PullupCountView.swift
//  PullUpper
//
//  Created by 김병훈 on 6/17/24.
//

import SwiftUI
import AudioToolbox

struct PullUpCountView: View {
    @StateObject private var pullUpCounter = PullUpCounter()

    @State private var progressTime = 0
    @State private var timer: Timer?
    @State private var hasAppeared = false
    @State private var showAlert = false

    @Binding var path: [String]

    @Environment(\.modelContext) private var modelContext

    var userGoal = UserDefaults.standard.integer(forKey: "userGoal")

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
                .padding(.top, 185)

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
                    do {
                        modelContext.insert(PullUpRecord(pullUpCount: pullUpCounter.pullUpCountInt, pullUpGoalCount: userGoal, pullUpMinute: minutes, pullUpSecond: seconds))
                        try modelContext.save()
                    } catch {
                        print("save error")
                    }

                    timer?.invalidate()
                    pullUpCounter.stopUpdates()
                })
            }
            .padding()
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Headphone Connection Needed"),
                message: Text("To count the pull-up, you need headphones with built-in acceleration sensors (AirPods Pro, AirPods Max)."),
                primaryButton: .default(
                    Text("Try Again"),
                    action: {
                        pullUpCounter.stopUpdates()
                        path.removeAll()
                    }
                ),
                secondaryButton: .destructive(
                    Text("Settings")
                        .foregroundStyle(.red),
                    action: {
                        pullUpCounter.stopUpdates()
                        path.removeAll()
                        if let url = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(url)
                        }
                    }
                )
            )
        }
        .onChange(of: hasAppeared) { _, appeared in
            pullUpCounter.startUpdates()
            if appeared && !showAlert {
                timerStart()
            }
        }
        .onChange(of: pullUpCounter.pullUpCountInt) { _, newValue in
            if newValue == userGoal {
                playSystemSound()
            }
        }
        .onAppear {
            hasAppeared = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                showAlert = !pullUpCounter.isHeadPhoneDetected
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    func timerStart() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            progressTime += 1
        })
    }

    // 목표 달성 확인용 원
    func goalCircles() -> some View {
        VStack {
                    HStack(spacing: 17) {
                        ForEach(1...10, id: \.self) { num in
                            if num <= userGoal {
                                Circle()
                                    .foregroundColor(.mainBG)
                                    .frame(width: num <= pullUpCounter.pullUpCountInt ? 15 : 5, height: num <= pullUpCounter.pullUpCountInt ? 15 : 5)
                                    .padding(num <= pullUpCounter.pullUpCountInt ? 0 : 5)
                                    .animation(.easeInOut(duration: 0.3), value: num <= pullUpCounter.pullUpCountInt)
                            }
                        }
                    }
                    .padding(.vertical, 20)

                    HStack(spacing: 17) {
                        ForEach(11...20, id: \.self) { num in
                            if num <= userGoal {
                                Circle()
                                    .foregroundColor(.mainBG)
                                    .frame(width: num <= pullUpCounter.pullUpCountInt ? 15 : 5, height: num <= pullUpCounter.pullUpCountInt ? 15 : 5)
                                    .padding(num <= pullUpCounter.pullUpCountInt ? 0 : 5)
                                    .animation(.easeInOut(duration: 0.3), value: num <= pullUpCounter.pullUpCountInt)
                            }
                        }
                    }
                }

    }

    func playSystemSound() {
        AudioServicesPlaySystemSound(SystemSoundID(1109))
    }
}
