//
//  RingView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 27/11/2020.
//

import SwiftUI

struct RingView: View {
    //to make them customizable
    var color1 = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
    var color2 = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
    var width : CGFloat  = 100
    var height : CGFloat = 100
    var percent : CGFloat = 82
    //MARK:- States
    
    
    //MARK:- Bindings
    //to make other views using it and can bind the value by this depending on the other view
    @Binding var show : Bool
    
    
    var body: some View {
        //MARK:- global variables
        let multiplier = width / 44
        let progress  = 1 - (percent / 100.0)
        
        //we have to use return the Zstack if we will declare a variables inside the body
        return ZStack {
            Circle()
                .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth: 5 * multiplier))
                .frame(width : width , height: height)
            Circle()
                //to control the progress for example
                //0.2 means 80%
                .trim(from:  show ? progress : 1, to: 1)
                .stroke(
                    LinearGradient(gradient: Gradient(colors: [Color(color1) ,Color(color2)]),
                                   startPoint:.topLeading,endPoint: .bottomTrailing),
                    style:StrokeStyle(lineWidth: 5 * multiplier, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20,0],      dashPhase: 0))
                
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                .frame(width : width , height: height)
                .shadow(color: Color(color1).opacity(0.1), radius: 3 * multiplier , x: 0, y: 3 * multiplier)
            
            
            
            
            Text("\( Int(percent) )% ")
                .font(.system(size: 14 * multiplier ))
                .font(.headline)
                .fontWeight(.bold)
                .onTapGesture {
                    self.show.toggle()
                }
            
            
            
        }
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView(show: .constant(true))
    }
}
