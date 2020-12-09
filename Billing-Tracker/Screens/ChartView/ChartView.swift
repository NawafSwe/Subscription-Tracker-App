//
//  ChartView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 10/12/2020.
//

import SwiftUI

struct ChartView: View {
    @State var title:String = "Weekly"
    @State var data : [Double] = [8,23,54,32,12,37,7,23,43]
    let myCustomStyle = ChartStyle(backgroundColor: .chartBackground , accentColor: .mainColor, secondGradientColor: .charsLimitColor1, textColor: .standardText, legendTextColor: .buttonSnow, dropShadowColor: .white)
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 10 ) {
                HStack(spacing:20){
                    Button(action:{
                        self.title = "Weekly"
                        self.data = [8,23,54,32,12,37,7,23,43]
                    }){
                        Text( "Weekly")
                            .foregroundColor(.ChartButtons)
                    }
                    Button(action:{
                        self.data = [69,250,10,340,62,40,30,-40,20]
                        self.title = "Monthly"
                    }){
                        Text("Monthly")
                            .foregroundColor(.ChartButtons)
                    }
                    
                    Button(action:{
                        self.title = "Yearly"
                        self.data = [100,20,120,40,12,50,7,-10,30]
                    }){
                        Text("Yearly")
                            .foregroundColor(.ChartButtons)
                    }
                    
                    
                }
                .frame(width: 300,height: 35 ,alignment: .center)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                .shadow(radius: 3)
                .padding()
                LineView(data: data, title: title ,style: myCustomStyle)
                    .padding()
                
            }
        }
    }
}



