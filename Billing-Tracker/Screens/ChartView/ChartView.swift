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
                VStack(alignment: .leading, spacing: 10 ) {
                    LineView(data: viewModel.data, title: viewModel.title ,style: viewModel.myCustomStyle)
                        .padding()
                    
                    Text("This chart shows the total expenses of all your yearly, monthly, weekly subscriptions")
                        .padding(30)
                    
                    Spacer()
                        
                        .navigationTitle("Expenses Statistics 📈")
                }
                .padding()
            }
        }
    }
    struct  ChartsView_Previews:PreviewProvider{
        static var previews : some View{
            ChartView()
        }
    }
    
    
}
