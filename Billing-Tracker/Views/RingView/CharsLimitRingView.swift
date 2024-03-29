//
//  CharsLimitRingView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 28/11/2020.
//

import SwiftUI
struct CharsLimitRingView: View {
    //to make them customizable
    var color1 = Color.charsLimitColor1
    var color2 = Color.charsLimitColor2
    var width : CGFloat
    var height : CGFloat
    /// for days calculation
    @Binding var remindChars : CGFloat
    var totalChars:CGFloat
    
    var body: some View {
        //MARK:- global variables
        let multiplier = width / 44
        /// calculating progress
        let progress  = 1 - (remindChars / totalChars)
        //we have to use return the Zstack if we will declare a variables inside the body
        return ZStack {
            Circle()
                .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth: 5 * multiplier))
                .frame(width : width , height: height)
            Circle()
                //to control the progress for example
                //0.2 means 80%
                .trim(from: progress , to: 1)
                .stroke(
                    LinearGradient(gradient: Gradient(colors: [color1 ,color2]),
                                   startPoint:.topLeading,endPoint: .bottomTrailing),
                    style:StrokeStyle(lineWidth: 5 * multiplier, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20,0],      dashPhase: 0))
                
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                .frame(width : width , height: height)
                .shadow(color: color1.opacity(0.1), radius: 3 * multiplier , x: 0, y: 3 * multiplier)
            
            Text("\( Int(totalChars -  remindChars) )")
                .font(.system(size: 14 * multiplier ))
                .font(.headline)
                .fontWeight(.bold)
        }
    }
    
    struct CharsLimitRingView_Previews: PreviewProvider {
        static var previews: some View {
            CharsLimitRingView(width: 33, height: 33, remindChars: .constant(26), totalChars: 26)
        }
    }
    
}
