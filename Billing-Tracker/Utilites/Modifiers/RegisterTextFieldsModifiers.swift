//
//  RegisterTextFieldsModifiers.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 07/01/2021.
//

import Foundation
import SwiftUI
//MARK:- RegisterTextFieldsModifiers
// to custom a placeHolder
struct RegisterTextFieldsModifiers : ViewModifier {
    var showPlaceHolder:Bool
    var placeHolder:String
    func body(content:Content) ->  some View{
        ZStack(alignment:.leading){
            if showPlaceHolder{
                Text(placeHolder)
                    .padding(.horizontal)
            }
            content
                .foregroundColor(Color.white)
                .padding(.horizontal)
        }
    }
}
