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
        GeometryReader { geometry in
            ZStack{
                NavigationView {
                    List{
                        ForEach(viewModel.providers){ list in
                            ProviderCellView(name: list.provider.name, image: list.provider.image)
                            
                        }
                        
                        .onDelete(perform: viewModel.deleteProvider )
                        .alert(item: $viewModel.alertItem){alert in
                            Alert(title: alert.title, message: alert.message, dismissButton: alert.dismissButton)
                        }
                        
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
                if viewModel.providers.isEmpty{
                    EmptyProviders()
                    
                }
                
                if viewModel.showAddProvider{
                    AddProviderView(viewModel: viewModel )
                        .transition(.move(edge: .bottom))
                        .animation(.easeIn)
                        .animation(nil)
                        .offset(y: geometry.size.height / 3)
                }
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
                StandardButton(title: "Edit", width: 60 , height: 25)
                
            }
            
            Button(action:{
                viewModel.showAddProvider.toggle()
            }){
               StandardButton(title: "Add" , width: 60 , height: 25)
                
            }
            
        }
    }
}
