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
    
    var body: some View {
        ZStack{
            NavigationView {
                List{
                    ForEach(viewModel.providers){ list in
                        HStack{
                            Image(list.provider.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width:26, height: 26)
                            Text(list.provider.name)
                                .font(.subheadline)
                                .foregroundColor(.standardText)
                        }
                        
                        
                    }.onDelete(perform: viewModel.deleteProvider )
                    
                }
                .environment(\.editMode, .constant(self.viewModel.isEditing ? EditMode.active : EditMode.inactive)).animation(Animation.spring())
                
                .listStyle(PlainListStyle())
                .navigationBarItems(leading: Button(action:{self.presentationMode.wrappedValue.dismiss() })
                    { BackTrackButton() } ,
                                    trailing: NavigationButtonsHolder(viewModel: viewModel) )
                .navigationTitle("Custom Providers🧾")
                
            }
            .disabled(viewModel.showAddProvider)
            .shadow(radius: viewModel.showAddProvider ? 10 : 0)
            .blur(radius: viewModel.showAddProvider ?  10 : 0)
            
            if viewModel.showAddProvider{
                AddProviderView(viewModel: viewModel )
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

struct NavigationButtonsHolder : View {
    @ObservedObject var viewModel: ManageProvidersViewModel
    var body: some View{
        HStack{
            Button(action:{viewModel.isEditing.toggle()}){
                EditButton()
                
            }
        
            Button(action:{
                viewModel.showAddProvider.toggle()
            }){
                AddProviderButton()
                
            }
            
        }
    }
}
