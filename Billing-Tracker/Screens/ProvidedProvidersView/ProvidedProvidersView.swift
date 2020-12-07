//
//  ProvidedProvidersView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 05/12/2020.
//

import SwiftUI

struct ProvidedProvidersView: View {
    @StateObject var viewModel = ProvidedProvidersViewModel()
    var body: some View {
        NavigationView {
            List(viewModel.providerServices){provider in
                HStack{
                    ProviderCellView(name: provider.provider.name , image: provider.provider.image)
                    Spacer()
                    Button(action:{
                        self.viewModel.addProvider(provider: provider)
                    }){
                        Image(systemName: Icons.SFAddProvider)
                            .renderingMode(.original)
                            .resizable()
                            .frame(width:32 , height: 32)
                        
                    }
                }
            }
            .navigationTitle("Providers With Icons 💳")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ProvidedProvidersView_Previews: PreviewProvider {
    static var previews: some View {
        ProvidedProvidersView()
    }
}
