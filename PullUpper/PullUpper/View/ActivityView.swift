//
//  ActivityView.swift
//  PullUpper
//
//  Created by hanseoyoung on 6/17/24.
//

import SwiftUI

struct ActivityView: View {
    @State private var mockRecords = generateMockPullUpRecords(count: 10)
    @State private var isShowDeleteAlert = false
    @State private var recordToDelete: PullUpRecord?
    @State private var dragOffsets: [UUID: CGFloat] = [:]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Activity")
                .font(Font.custom("StretchProRegular", size: 48))
                .foregroundColor(.black)
                .padding(.top, 87)
                .padding(.bottom, 57)
                .padding(.horizontal, 16)

            HStack(alignment: .center, spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Total")
                        .font(.system(size: 15))
                        .fontWeight(.bold)
                        .foregroundColor(.subText)

                    Text(1000.formatterStyle(.decimal)!)
                        .font(.system(size: 40, weight: .heavy))
                        .fontWidth(.expanded)
                        .foregroundColor(.mainText)

                    Divider()
                        .frame(height: 6)
                        .background(.accent)
                }
                .padding(.horizontal, 6)
                .padding(.vertical, 16)

                VStack(alignment: .leading, spacing: 0) {
                    Text("Monthly")
                        .font(.system(size: 15))
                        .fontWeight(.bold)
                        .foregroundColor(.subText)

                    Text(100.formatterStyle(.decimal)!)
                        .font(.system(size: 40, weight: .heavy))
                        .fontWidth(.expanded)
                        .foregroundColor(.mainText)

                    Divider()
                        .frame(height: 6)
                        .background(.accent)
                }
                .padding(.horizontal, 6)
                .padding(.vertical, 16)
            }
            .padding(.horizontal, 16)

            ScrollView {
                VStack(spacing: 0) {
                    ForEach(mockRecords, id: \.pullUpID) { record in
                        ZStack {
                            HStack {
                                Spacer()
                                GeometryReader { geometry in
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            recordToDelete = record
                                            isShowDeleteAlert.toggle()
                                        }) {
                                            Image(systemName: "trash.fill")
                                                .foregroundColor(.white)
                                                .frame(width: 100, height: geometry.size.height)
                                                .background(Color.red)
                                        }
                                    }
                                }
                            }

                            ActivityCell(record)
                                .offset(x: dragOffsets[record.pullUpID] ?? 0)
                                .gesture(
                                    DragGesture()
                                        .onChanged { value in
                                            if value.translation.width < 0 {
                                                dragOffsets[record.pullUpID] = value.translation.width
                                            }
                                        }
                                        .onEnded { value in
                                            if value.translation.width < -100 {
                                                dragOffsets[record.pullUpID] = -100
                                            } else {
                                                dragOffsets[record.pullUpID] = 0
                                            }
                                        }
                                )
                        }
                        .animation(.spring(), value: dragOffsets[record.pullUpID])
                        .alert(isPresented: $isShowDeleteAlert) {
                            Alert(
                                title: Text("Delete Record"),
                                message: Text("Are you sure you want to delete this record?"),
                                primaryButton: .destructive(Text("Delete")) {
                                    if let record = recordToDelete {
                                        delete(record: record)
                                    }
                                },
                                secondaryButton: .cancel()
                            )
                        }

                        Divider()
                            .padding(0)
                            .frame(height: 1)
                            .background(Color.mainText)
                    }
                }
            }
        }
        .ignoresSafeArea()
    }

    private func ActivityCell(_ record: PullUpRecord) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("GOAL")
                        .font(.system(size: 15))
                        .fontWeight(.bold)
                        .foregroundColor(.accent)
                        .padding(.bottom, 8)

                    Text("\(record.pullUpGoalCount)")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(.mainText.opacity(0.7))
                        .padding(.bottom, 16)
                }
                Spacer()

                VStack(alignment: .leading, spacing: 0) {
                    Text("TIME")
                        .font(.system(size: 15))
                        .fontWeight(.bold)
                        .foregroundColor(.accent)
                        .padding(.bottom, 8)

                    Text((String(format: "%02d", record.pullUpMinute))
                         + ":"
                         + (String(format: "%02d", record.pullUpSecond)))
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(.mainText.opacity(0.7))
                }
                Spacer()

                VStack(alignment: .leading, spacing: 0) {
                    Text("COUNT")
                        .font(.system(size: 15))
                        .fontWeight(.bold)
                        .foregroundColor(.accent)
                        .padding(.bottom, 8)

                    Text("\(record.pullUpCount)")
                        .font(.system(size: 36, weight: .heavy))
                        .fontWidth(.expanded)
                        .foregroundColor(.mainText)
                }
            }
            Text("\(record.pullUpDate.formattedString())")
                .font(.system(size: 15))
                .fontWeight(.bold)
                .foregroundColor(.subText)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 22)
        .background(Color.white)
    }

    private func delete(record: PullUpRecord) {
        if let index = mockRecords.firstIndex(where: { $0.pullUpID == record.pullUpID }) {
            mockRecords.remove(at: index)
            dragOffsets[record.pullUpID] = nil
        }
    }
}

// MARK: 데이트 포맷 변경
extension Date {
    func formattedString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.string(from: self)
    }
}

// MARK: 숫자에 콤마 찍기
extension Int {
    func formatterStyle(_ numberStyle: NumberFormatter.Style) -> String? {
        let numberFommater: NumberFormatter = NumberFormatter()
        numberFommater.numberStyle = numberStyle
        return numberFommater.string(for: self)
    }
}

#Preview {
    ActivityView()
}
