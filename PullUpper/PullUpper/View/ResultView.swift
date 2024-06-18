//
//  ResultView.swift
//  PullUpper
//
//  Created by 김병훈 on 6/18/24.
//

import SwiftUI

struct ResultView: View {
    var body: some View {
        ZStack {
            
            //배경용 스택입니다.
            VStack {
                Spacer()
                
                Image("whiteOrangeHalfTone")
                    .resizable()
                    .scaledToFit()
            }
            //타냐가 오늘 알려준 내용을 적용해보았습니다...후후
            .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 40){
                
                    // 제목 Result입니다.
                    Text("Result")
                        .font(.system(size: 48, weight: .heavy))
                        .fontWidth(.expanded)
                        
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    VStack(alignment: .leading, spacing: 0) {
                        
                        //Count 스택입니다.
                        VStack(alignment: .leading, spacing: 0) {
                            Text("COUNT")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundStyle(.subText)
                            
                            // TODO: pullUpCount가 들어갈 자리입니다.
                            Text("10")
                                .font(.system(size: 96, weight: .bold))
                                .fontWidth(.expanded)
                            // 행간이 피그마와 달라서 높이를 지정해주었습니다
                                .frame(height: 96)
                            
                            Divider()
                                .frame(height: 2)
                                .background(.black)
                        }
                    }
                    
                    HStack (spacing: 20){
                        //GOAL 스택입니다.
                        VStack (alignment: .leading, spacing: 8) {
                            Text("GOAL")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundStyle(.subText)
                            // 행간이 피그마와 달라서 높이를 지정해주었습니다
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
                            // 행간이 피그마와 달라서 높이를 지정해주었습니다.
                                .frame(height: 48)
                            
                            
                            Divider()
                                .frame(height: 2)
                                .background(.black)
                            
                        }
                        // Time스택입니다.
                        VStack (alignment: .leading, spacing: 8) {
                            Text("TIME")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundStyle(.subText)
                            // 행간이 피그마와 달라서 높이를 지정해주었습니다
                                .frame(height: 24)
                            
                            // TODO: pullUpMinute과 pullUpSecond가 들어갈 자리입니다.
                            Text("00:00")
                                .font(.system(size: 48, weight: .bold))
                            // 행간이 피그마와 달라서 높이를 지정해주었습니다.
                                .frame(height: 48)
                            
                            Divider()
                                .frame(height: 2)
                                .background(.black)
                            
                        }
                    }
                }
                
                
                Spacer()
                
                //MainView로 돌아가는 버튼입니다.
                Button(action: {
                    print("MainView로 돌아감")
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
    }
}

#Preview {
    ResultView()
}
