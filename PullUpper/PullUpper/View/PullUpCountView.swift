//
//  PullupCountView.swift
//  PullUpper
//
//  Created by 김병훈 on 6/17/24.
//

import SwiftUI


struct PullUpCountView: View {
    var body: some View {
        VStack{
            Spacer()
            VStack{
                Text("COUNT")
                //숫자는 pullUpCount
                //            Text("\(pullUpCount)")
                Text("11")
            }
            Spacer()
            HStack{
                VStack{
                    Text("GOAL")
                    Divider()
                    HStack{
                        Text("20")
                        Text("PULL UPs")
                    }
                    
                }
                VStack{
                    Text("GOAL")
                    Divider()
                    Text("00:00")
                }
            }
        }
    }
}

#Preview {
    PullUpCountView()
}
