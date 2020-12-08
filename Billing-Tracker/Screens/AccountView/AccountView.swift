//
//  AccountView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 07/12/2020.
//

import SwiftUI
import Firebase
struct AccountView: View {
    //view model will load all user data from user services
    @ObservedObject var viewModel  : AccountViewModel
    @Environment (\.presentationMode) var presentationMode
    @State var showEmailBox = true
    @State var viewState: CGSize = .zero
    var body: some View {
        ZStack {
            NavigationView {
                Form{
                    Section(header:Text("Account information")){
                        Button(action:{self.showEmailBox.toggle()}){
                            HStack {
                                Text("Email :")
                                Text("\(viewModel.email)")
                                Spacer()
                                Image(systemName: Icons.SFChevronRight)
                                    .resizable()
                                    .renderingMode(.original)
                                    .frame(width:10 , height: 15)
                            }
                        }
                        .accentColor(.primary)
                        TextField("Name" , text:$viewModel.displayName)
                        
                    }
                    Section(header:Text("Additional Information")){
                        TextField("Age" , text:$viewModel.age )
                        TextField("gender",text:$viewModel.gender  )
                        TextField("Preferred Provider" , text:$viewModel.preferredProviderName)
                    }
                }
                .navigationBarItems(leading: Button(action:{self.presentationMode.wrappedValue.dismiss()}){DismissButtonView()}
                                    , trailing: Button(action:{}){
                                        StandardButton(title: "Save")
                                    })
                .navigationTitle("Profile")
            }
            .blur(radius: showEmailBox ? 3 : 0)
            
            if showEmailBox{
                EmailBoxView(viewModel: viewModel)
                    .overlay(Text("\(viewState.height)"),alignment: .top)
                    .gesture(
                        DragGesture().onChanged({value in
                            
                        })
                        
                        .onEnded({value in
                            
                        })
                    )
                
                
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(viewModel: AccountViewModel(email: "nn@1234gmail.com", preferredProviderName: "", preferredProviderImage: "", age: "", gender: "", displayName: ""))
    }
}
