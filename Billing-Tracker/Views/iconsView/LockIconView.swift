//
//  LockIconView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 08/12/2020.
//

import SwiftUI

struct LockIconView: View {
    var body: some View {
        Image(systemName: "lock.fill")
            .foregroundColor(.lunchViewIconsColor)
            .frame(width: 44 , height : 44)
            .background(Color.lunchViewIconsBackground)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.15), radius: 20, x: 0, y: 10)
            .padding(.horizontal)
    }
}

struct LockIconView_Previews: PreviewProvider {
    static var previews: some View {
        LockIconView()
    }
}
