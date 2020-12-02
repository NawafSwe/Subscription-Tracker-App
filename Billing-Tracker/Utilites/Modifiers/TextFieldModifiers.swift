//
//  TextFieldModifiers.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 02/12/2020.
//

import Foundation
import SwiftUI


struct TextFieldModifiers:ViewModifier{
    func body(content: Content) -> some View {
        content
            .autocapitalization(.none)
            .disableAutocorrection(true)
    }
}
