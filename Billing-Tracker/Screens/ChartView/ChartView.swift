//
//  ChartView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 10/12/2020.
//

import SwiftUI

struct ChartView: View {
    @StateObject var viewModel = ChartViewModel()
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            NavigationView {
                VStack(alignment: .center, spacing: 10 ) {
                    
                    HStack(spacing:20){
                        Button(action:{
                            DispatchQueue.main.async {
                                self.viewModel.title = "Weekly"
                            }
                            viewModel.fetchData(period: viewModel.title)
                        }){
                            Text( "Weekly")
                                .foregroundColor(.ChartButtons)
                        }
                        Button(action:{
                            DispatchQueue.main.async {
                                self.viewModel.title = "Monthly"
                            }
                            
                            viewModel.fetchData(period: viewModel.title)
                        }){
                            Text("Monthly")
                                .foregroundColor(.ChartButtons)
                        }
                        
                        Button(action:{
                            DispatchQueue.main.async {
                                self.viewModel.title = "Yearly"
                            }
                            viewModel.fetchData(period: viewModel.title)
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
                    
                    
                    
                    if viewModel.showWeekly{
                        LineView(data: viewModel.data, title: viewModel.title ,style: viewModel.myCustomStyle)
                            .padding()
                    }
                    
                    if viewModel.showMonthly{
                        LineView(data: viewModel.data, title: viewModel.title ,style: viewModel.myCustomStyle)
                            .padding()
                    }
                    
                    if viewModel.showYearly{
                        LineView(data: viewModel.data, title: viewModel.title ,style: viewModel.myCustomStyle)
                            .padding()
                    }
                    
                }
                .padding()
                
                
                .navigationTitle("Expenses Statistics")
            }
        }
        .onAppear{  viewModel.fetchData(period: viewModel.title)
            
        }
        
        
    }
}

struct  ChartsView_Previews:PreviewProvider{
    static var previews : some View{
        ChartView()
    }
}



