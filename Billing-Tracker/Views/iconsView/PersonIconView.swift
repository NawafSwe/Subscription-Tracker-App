//
//  PersonIconView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 02/12/2020.
//

import SwiftUI

struct PersonIconView: View {
    let width : CGFloat
    let height : CGFloat
    var body: some View {
        Image(systemName: "person.crop.circle.fill")
            .foregroundColor(.lunchViewIconsColor)
            .frame(width: width , height : height)
            .background(Color.lunchViewIconsBackground)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.15), radius: 20, x: 0, y: 10)
        
    }
}

struct PersonIconView_Previews: PreviewProvider {
    static var previews: some View {
        PersonIconView(width: 44, height: 44)
    }
}
