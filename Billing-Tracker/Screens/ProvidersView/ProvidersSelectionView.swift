//
//  ProvidersSelectionView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 03/12/2020.
//

import SwiftUI

//MARK:- ProvidersSelectionView
struct ProvidersSelectionView:View{
    @ObservedObject var viewModel: SubscriptionFormViewModel
    
    var body: some View{
        NavigationView {
            List(viewModel.providersList){ list in
                Button(action:{
                    self.viewModel.selectedProvider = list.provider
                    self.viewModel.showProvidersList = false
                }){
                    HStack{
                        ProviderCellView(provider: list.provider)
                        
                        if viewModel.selectedProvider?.id == list.provider.id {
                            Spacer()
                            Image(systemName: Icons.SFSelected)
                                .resizable()
                                .frame(width:20 , height: 20)
                                .imageScale(.medium)
                            
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationBarItems(leading: Button(action:{ self.viewModel.showProvidersList = false }
            ){ BackTrackButton() })
            .navigationTitle("Providers 🧾")
        }
    }
}


struct ProvidersSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ProvidersSelectionView(viewModel: SubscriptionFormViewModel())
    }
}
