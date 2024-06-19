//
//  ResultView.swift
//  PullUpper
//
//  Created by 김병훈 on 6/18/24.
//

import SwiftUI
import SwiftData

struct ResultView: View {
    @Binding var path: [String]

    let pullUpRecord: PullUpRecord = generateMockPullUpRecords(count: 1).first!

    @Environment(\.modelContext) private var modelContext
    @Query(sort: \PullUpRecord.pullUpDate, order: .reverse) var resultRecords: [PullUpRecord]

    var body: some View {
        ZStack {
            VStack {
                Spacer()

                Image("whiteOrangeHalfTone")
                    .resizable()
                    .scaledToFit()
            }
            .ignoresSafeArea()

            if let latestRecord = resultRecords.first {
                VStack(alignment: .leading, spacing: 40) {
                    Text("Result")
                        .font(.system(size: 40, weight: .heavy))
                        .fontWidth(.expanded)

                    VStack(alignment: .leading, spacing: 12) {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("COUNT")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundStyle(.subText)

                            Text("\(latestRecord.pullUpCount)")
                                .font(.system(size: 96, weight: .bold))
                                .fontWidth(.expanded)
                                .frame(height: 96)

                            Divider()
                                .frame(height: 2)
                                .background(.black)
                        }

                        HStack(spacing: 20) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("GOAL")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundStyle(.subText)
                                    .frame(height: 24)

                                HStack {
                                    Text("\(latestRecord.pullUpGoalCount)")
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
                            VStack(alignment: .leading, spacing: 8) {
                                Text("TIME")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundStyle(.subText)
                                    .frame(height: 24)

                                Text((String(format: "%02d", latestRecord.pullUpMinute))
                                     + ":"
                                     + (String(format: "%02d", latestRecord.pullUpSecond)))
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
                        ZStack {
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
            } else {
                Text("DB ERROR")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.red)
            }
        }
        .navigationBarHidden(true)
    }
}
