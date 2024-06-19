//
//  ResultView.swift
//  PullUpper
//
//  Created by 김병훈 on 6/18/24.
//

import SwiftUI

struct ResultView: View {
    @Binding var path: [String]

    var body: some View {
        ZStack {
            VStack {
                Spacer()

                Image("whiteOrangeHalfTone")
                    .resizable()
                    .scaledToFit()
            }
            .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 40) {
                Text("Result")
                    .font(.system(size: 48, weight: .heavy))
                    .fontWidth(.expanded)

                VStack(alignment: .leading, spacing: 12) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("COUNT")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(.subText)

                        // TODO: pullUpCount가 들어갈 자리입니다.
                        Text("10")
                            .font(.system(size: 96, weight: .bold))
                            .fontWidth(.expanded)
                            .frame(height: 96)

                        Divider()
                            .frame(height: 2)
                            .background(.black)
                    }

                    HStack(spacing: 20) {
                        VStack (alignment: .leading, spacing: 8) {
                            Text("GOAL")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundStyle(.subText)
                                .frame(height: 24)

                            HStack {
                                // TODO: pullUpGoalCount가 들어갈 자리입니다.
                                Text("20")
                                    .font(.system(size: 48, weight: .bold))
                                    .fontWidth(.expanded)

                                Text("PULL\nUPs")
                                    .font(.system(size: 16, weight: .bold))
                                    .fontWidth(.expanded)
                            }
                            .frame(height: 48)

                            Divider()
                                .frame(height: 2)
                                .background(.black)
                        }
                        VStack (alignment: .leading, spacing: 8) {
                            Text("TIME")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundStyle(.subText)
                                .frame(height: 24)

                            // TODO: pullUpMinute과 pullUpSecond가 들어갈 자리입니다.
                            Text("00:00")
                                .font(.system(size: 48, weight: .bold))
                                .frame(height: 48)

                            Divider()
                                .frame(height: 2)
                                .background(.black)
                        }
                    }
                }
                Spacer()

                Button(action: {
                    path.removeAll()
                }, label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.black)
                            .frame(height: 66)
                        Text("HOME")
                            .font(.system(size: 36, weight: .heavy))
                            .fontWidth(.expanded)
                    }
                })
            }
            .padding()
        }
        .navigationBarHidden(true)
    }
}
