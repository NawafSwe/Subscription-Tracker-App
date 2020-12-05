//
//  saveButtonView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 02/12/2020.
//

import SwiftUI
struct saveButtonView:View{
    let title:String
    var body: some View{
        Text(title)
            .foregroundColor(.buttonColor)
            .frame(width: 80, height: 30)
            .font(.subheadline)
            .background(Color.buttonSnow)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 15), style: .continuous))
        
        
        
        
    }
}

struct saveButtonView_Previews: PreviewProvider {
    static var previews: some View {
        saveButtonView(title:"Update")
            .colorScheme(.dark)
    }
}
