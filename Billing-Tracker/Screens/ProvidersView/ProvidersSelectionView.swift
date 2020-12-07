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
        ZStack {
            NavigationView {
                List(viewModel.providersList){ list in
                    Button(action:{
                        self.viewModel.selectedProvider = list.provider
                        self.viewModel.showProvidersList = false
                    }){
                        HStack{
                            ProviderCellView(name: list.provider.name, image: list.provider.image)
                            
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
            
            if viewModel.providersList.isEmpty{
                EmptyProviders()
                
            }
        }
    }
}


struct ProvidersSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ProvidersSelectionView(viewModel: SubscriptionFormViewModel())
    }
}
