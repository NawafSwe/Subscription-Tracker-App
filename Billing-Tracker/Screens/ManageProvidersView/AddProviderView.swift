//
//  AddProviderView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 03/12/2020.
//

import SwiftUI

struct AddProviderView: View {
    @ObservedObject var viewModel : ManageProvidersViewModel
    var screen = UIScreen.main.bounds
    var body: some View {
        GeometryReader { geometry in
            
            VStack{
                HStack{
                    Button(action:{self.viewModel.showAddProvider.toggle()}){
                        DismissButtonView()
                        
                    }
                    Spacer()
                    Button(action:{
                        viewModel.addProvider()
                    }){
                        saveButtonView()
                    }
                }
                
                
                Text("Add Provider ☕️")
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .padding()
                
                HStack {
                    Text("Provider Name:")
                        .font(.body)
                    TextField("Provider",text: $viewModel.providerName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 200)
                }
                Spacer()
            }
            
            .padding()
            .frame(maxWidth:.infinity)
            .frame(height:  screen.height / 2 * 1.3, alignment: .center)
            .background(Color.backgroundCell)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 30, height: 30), style: .continuous))
            .shadow(radius: 3)
        }
        
    }
}

struct AddProviderView_Previews: PreviewProvider {
    static var previews: some View {
        AddProviderView(viewModel: ManageProvidersViewModel())
    }
}
