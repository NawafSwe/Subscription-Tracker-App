//
//  ProviderCellView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 03/12/2020.
//

import SwiftUI

struct ProviderCellView: View {
    let name:String
    let image:String
    var body: some View {
        HStack{
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width:26, height: 26)
            Text(name)
                .font(.subheadline)
                .foregroundColor(.standardText)
            
        }
    }
}

struct ProviderCellView_Previews: PreviewProvider {
    static var previews: some View {
        ProviderCellView(name: Images.Netflix , image: Images.Netflix)
    }
}
