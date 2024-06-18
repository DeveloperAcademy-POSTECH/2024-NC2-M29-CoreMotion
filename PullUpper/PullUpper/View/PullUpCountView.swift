//
//  PullupCountView.swift
//  PullUpper
//
//  Created by 김병훈 on 6/17/24.
//

import SwiftUI

struct PullUpCountView: View {
    
    
    
    var body: some View {
        ZStack{
            ZStack(alignment: Alignment(horizontal: .center, vertical: .top)){
                Color.accentColor
                    .ignoresSafeArea()
                
                Image("whiteHalfTone")
                    .resizable()
                    .opacity(0.2)
                    .scaledToFit()
                    .ignoresSafeArea()
    
            }
            VStack{
                Spacer()
                VStack(spacing: 0){
                    Text("COUNT")
                        .font(.system(size: 40, weight: .heavy))
                        .fontWidth(.expanded)
                        .foregroundStyle(.white)
                        .opacity(0.5)
                    //숫자는 pullUpCount
                    Text("11")
                        .font(.system(size: 128, weight: .heavy))
                        .fontWidth(.expanded)
                        .foregroundStyle(.white)
                        .frame(height: 128)
                }
                Spacer()
                HStack{
                    VStack(alignment: .leading, spacing: 4){
                        Text("GOAL")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(.subText)
                        
                        Divider()
                        HStack{
                            Text("20")
                                .font(.system(size: 48, weight: .black))
                                .fontWidth(.expanded)
                            Text("PULL\nUPs")
                                .font(.system(size: 16, weight: .bold))
                                .fontWidth(.expanded)
                        }
                        
                    }
                    VStack(alignment: .leading, spacing: 4){
                        Text("TIME")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(.subText)
                        Divider()
                        Text("00:00")
                            .font(.system(size: 48, weight: .black))
                    }
                }
                .padding()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    ZStack{
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
    }
}

#Preview {
    PullUpCountView()
}
