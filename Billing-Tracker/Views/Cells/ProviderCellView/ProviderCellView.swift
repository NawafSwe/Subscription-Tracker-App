//
//  ProviderCellView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 03/12/2020.
//

import SwiftUI

struct ProviderCellView: View {
    let provider:Provider
    var body: some View {
        HStack{
        Image(provider.image)
            .resizable()
            .scaledToFit()
            .frame(width:26, height: 26)
        Text(provider.name)
            .font(.subheadline)
            .foregroundColor(.standardText)
            
        }
    }
}

struct ProviderCellView_Previews: PreviewProvider {
    static var previews: some View {
        ProviderCellView(provider: Provider(name: Images.Netflix , image: Images.Netflix ))
    }
}
