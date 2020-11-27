//
//  SubscriptionDetailView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 27/11/2020.
//

import SwiftUI

struct SubscriptionDetailView: View {
    let subscription:Subscription
    @Binding var dismissView:Bool
    @State var viewState : CGSize = .zero
    var body: some View {
        
        ZStack {
            VStack{
                BrandView(image:subscription.image ,name: subscription.name, price: subscription.price, dueDate: subscription.dueDate)
                    .padding()
                
                Divider()
                    .frame(height: 2)
                    .background(Color("DividerColor"))
                    .shadow(radius: 30)
                
                SubscriptionRowInfoView(name:"Name" , info: subscription.name)
                SubscriptionRowInfoView(name:"Description" , info: subscription.description)
                SubscriptionRowInfoView(name: "Bill Date", info: "April 2 20202")
                SubscriptionRowInfoView(name: "Cycle", info: "Every Month")
                SubscriptionRowInfoView(name: "Reminder", info: "Never")
                
                
            }
            
            .overlay(
                Text( "\(self.viewState.height)")
                
                , alignment: .top)
            .frame(width: 340,height: 400)
            .background(Color.backgroundCell)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(radius: 10)
            .padding()
            .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
            .gesture(
                DragGesture().onChanged{ value in
                    //saving the value of the drag
                    self.viewState = value.translation
                    
                    /// if the user dragged it till 260 or more dismiss it
                    if(self.viewState.height >= 266){
                        self.dismissView.toggle()
                    }
                    
                }
                //to reset the position after releasing the gesture
                .onEnded({ value in
                    self.viewState = .zero
                    
                })
            )
            /// by dragging moving card
            .offset(y:self.viewState.height >= 20 ? self.viewState.height : 0)
            // prevent animation from propagation
            .animation(nil)
        }
    }
}

struct SubscriptionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionDetailView(subscription: MockData.subscriptionSample , dismissView: .constant(false))
    }
}

struct SubscriptionRowInfoView:View{
    let name: String
    let info :String
    var body: some View{
        VStack(alignment: .center){
            HStack{
                Text(name)
                    .font(.body)
                Spacer()
                Text(info)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
    }
}

struct DismissButtonView:View{
    var body: some View{
        Image(systemName: Icons.SFXmark)
            .resizable()
            .frame(width:20 , height: 20)
            .accentColor(.black)
    }
}
