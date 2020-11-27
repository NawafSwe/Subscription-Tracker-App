//
//  SubscriptionCellView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 27/11/2020.
//

import SwiftUI

struct SubscriptionCellView: View {
    let image:String
    let name:String
    let price:Double
    let dueDate:String
    
    var body: some View {
        HStack{
            BrandView(image:image, name:name, price: price, dueDate: dueDate)
                .padding()
            
            
        }
        .frame(width: 360, height: 70)
        .background(Color("sub_cell_background"))
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding()
        
        
        
    }
}

struct SubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionCellView(image:"Netflix",name:"Netflix",price: 43, dueDate: "2 weeks")
    }
}

struct BrandView:View{
    let image:String
    let name:String
    let price:Double
    let dueDate: String
    var body: some View{
        HStack{
            Image(image)
                .resizable()
                .frame(width: 32 , height: 32)
                .scaledToFit()
            
            
            VStack {
                Text(name)
                    .font(.title)
            }
            
            Spacer()
            
            VStack{
                Text("SR \(String(format: "%.2f", price) )")
                    .font(.system(size: 16, weight: .medium))
                Text(dueDate)
                    .font(.system(size: 16, weight: .thin, design: .default))
            }
            .font(.body)
            
        }
        
    }
}


