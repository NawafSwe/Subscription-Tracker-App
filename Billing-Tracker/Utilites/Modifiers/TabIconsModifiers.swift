//
//  tabIconsModifier.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 02/12/2020.
//

import Foundation
import SwiftUI


struct TabIconsModifiers:ViewModifier{
    func body(content: Content) -> some View {
        content
            .frame(width:20, height: 20)
            .scaledToFit()
    }
}
