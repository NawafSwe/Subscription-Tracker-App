//
//  ExpenseView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 28/11/2020.
//

import SwiftUI

struct ExpenseView: View {
    var body: some View {
        HStack{
            Text("Total Expenses")
                .font(.title2)
            Spacer()
            Text("28SR")
                .foregroundColor(.primary)
        }
        .padding()
        .frame(height: 40)
        .background(Color.backgroundCell)
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 30, height: 10), style: .continuous))
        .shadow(radius: 2)
        
    }
}

struct ExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseView()
    }
}