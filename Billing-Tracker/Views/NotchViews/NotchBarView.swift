//
//  NotchBarView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 08/12/2020.
//

import SwiftUI

struct NotchBarView: View {
    let width : CGFloat
    let height:CGFloat
    let cornerRadius:CGFloat
    var body: some View {
        Rectangle()
            .frame(width: width, height: height)
            .cornerRadius(cornerRadius)
            .opacity(0.1)
    }
}

struct NotchBarView_Previews: PreviewProvider {
    static var previews: some View {
        NotchBarView(width: 30, height: 30, cornerRadius: 3)
    }
}
