//
//  ManageProvidersView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 03/12/2020.
//

import SwiftUI

struct ManageProvidersView: View {
    @StateObject var viewModel = ManageProvidersViewModel()
    @Environment (\.presentationMode) var presentationMode
    @State var showAddProvider = false 
    var body: some View {
        ZStack{
            NavigationView {
                List(viewModel.providers){ list in
                    HStack{
                        Image(list.provider.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width:26, height: 26)
                        Text(list.provider.name)
                            .font(.subheadline)
                            .foregroundColor(.standardText)
                    }
                    
                    
                }
                
                .listStyle(PlainListStyle())
                .navigationBarItems(leading: Button(action:{self.presentationMode.wrappedValue.dismiss() })
                    { BackTrackButton() } ,
                                    trailing:Button(action:{self.showAddProvider.toggle()}){
                                        AddProviderButton()
                                    }  )
                .navigationTitle("Custom Providers🧾")
                
            }
            .disabled(showAddProvider)
            .shadow(radius: showAddProvider ? 10 : 0)
            .blur(radius: showAddProvider ?  10 : 0)
            
            if showAddProvider{
                AddProviderView(dismissView: $showAddProvider )
                    .transition(.move(edge: .bottom))
                    .animation(.easeIn)
                    .animation(nil)
                    .offset(y: 300)
            }
        }
    }
}

struct ManageProvidersView_Previews: PreviewProvider {
    static var previews: some View {
        ManageProvidersView()
    }
}
