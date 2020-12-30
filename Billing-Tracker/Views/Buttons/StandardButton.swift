//
//  saveButtonView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 02/12/2020.
//

import SwiftUI
struct StandardButton:View{
    let title:String
    let width:CGFloat
    let height:CGFloat
    var body: some View{
        Text(title)
            .foregroundColor(.buttonColor)
            //.frame(width: 80, height: 30)
            .frame(width: width, height: height)
            .font(.subheadline)
            .background(Color.buttonSnow)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 15), style: .continuous))
        
        
        
        
    }
}

struct saveButtonView_Previews: PreviewProvider {
    static var previews: some View {
        StandardButton(title:"Update",width: 80 , height: 30)
            .colorScheme(.dark)
    }
}
