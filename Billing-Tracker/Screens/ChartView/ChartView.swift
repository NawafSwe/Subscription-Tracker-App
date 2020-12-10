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
    let myCustomStyle = ChartStyle(backgroundColor: .chartBackground , accentColor: .mainColor, secondGradientColor: .charsLimitColor1, textColor: .standardText, legendTextColor: .buttonSnow, dropShadowColor: .black)
    @State var showMonthly = true
    @State var showWeekly = false
    @State var showYearly = false
    @StateObject var viewModel = ChartViewModel()
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            NavigationView {
                VStack(alignment: .center, spacing: 10 ) {
                    
                    HStack(spacing:20){
                        Button(action:{
                            self.title = "Weekly"
                            self.data = [8,23,54,32,12,37,7,23,43]
                            self.showWeekly = true
                            self.showMonthly = false
                            self.showYearly = false
                            
                            viewModel.fetchData(period: self.title)
                        }){
                            Text( "Weekly")
                                .foregroundColor(.ChartButtons)
                        }
                        Button(action:{
                            self.data = [69,250,10,340,62,40,30,-40,20]
                            self.title = "Monthly"
                            self.showWeekly = false
                            self.showMonthly = true
                            self.showYearly = false
                        }){
                            Text("Monthly")
                                .foregroundColor(.ChartButtons)
                        }
                        
                        Button(action:{
                            self.title = "Yearly"
                            self.data = [100,20,120,40,12,50,7,-10,30]
                            self.showWeekly = false
                            self.showMonthly = false
                            self.showYearly = true
                        }){
                            Text("Yearly")
                                .foregroundColor(.ChartButtons)
                        }
                        
                        
                    }
                    .padding()
                    .frame(width: 300,height: 35 ,alignment: .center)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                    .shadow(radius: 3)
                    
                    
                    
                    if self.showWeekly{
                        LineView(data: viewModel.data, title: title ,style: myCustomStyle)
                            .padding()
                    }
                    
                    if self.showMonthly{
                        LineView(data: viewModel.data, title: title ,style: myCustomStyle)
                            .padding()
                    }
                    
                    if self.showYearly{
                        LineView(data: viewModel.data, title: title ,style: myCustomStyle)
                            .padding()
                    }
                    
                }
                .padding()
                
                
                .navigationTitle("Expenses Statistics")
            }
        }
        .onAppear{  viewModel.fetchData(period: self.title)
            
        }
        
        
    }
}

struct  ChartsView_Previews:PreviewProvider{
    static var previews : some View{
        ChartView()
    }
}



