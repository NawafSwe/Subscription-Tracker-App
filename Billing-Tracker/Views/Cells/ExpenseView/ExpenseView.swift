//
//  ExpenseView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 28/11/2020.
//

import SwiftUI

struct ExpenseView: View {
    let price : Double
    var body: some View {
        HStack{
            Text("Total Expenses")
                .font(.title2)
            Spacer()
            Text(String(format: "%.2f", price) + "SR" )
                .foregroundColor(.primary)
        }
        .padding()
        .frame(width: 350, height: 60)
        .background(Color("sub_cell_background"))
        .cornerRadius(10)
        .shadow(radius: 3)
        
    }
}

struct ExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseView(price: 32)
    }
}
