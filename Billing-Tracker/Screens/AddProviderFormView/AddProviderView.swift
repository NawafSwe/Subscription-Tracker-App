//
//  AddProviderView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 03/12/2020.
//

import SwiftUI

struct AddProviderView: View {
    @State var providerName = ""
    @Binding var dismissView:Bool
    var body: some View {
        ZStack {
            VStack{
                HStack{
                    Button(action:{self.dismissView.toggle()}){
                        DismissButtonView()
                        
                    }
                    Spacer()
                    Button(action:{}){
                        saveButtonView()
                    }
                }
                .padding()
                
                Text("Add Provider ☕️")
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .padding()
                
                HStack {
                    Text("Provider Name:")
                        .font(.body)
                    TextField("Provider",text: $providerName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 200)
                }
                .padding()
                
                // custom spacer
                Spacer().frame(height: 90)
                
            }
            
            .padding()
            .frame(maxWidth:.infinity)
            .frame(height: 300, alignment: .center)
            .background(Color.backgroundCell)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 30, height: 30), style: .continuous))
            .shadow(radius: 3)            
        }
    }
}

struct AddProviderView_Previews: PreviewProvider {
    static var previews: some View {
        AddProviderView(dismissView: .constant(false))
    }
}

