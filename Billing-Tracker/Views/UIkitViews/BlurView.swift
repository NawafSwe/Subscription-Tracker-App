//
//  BlurView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 28/11/2020.
//

import Foundation
import SwiftUI

//MARK:- UIViewRepresentable
//UIViewRepresentable allows you to use uiKit in swiftUi
struct BlurView: UIViewRepresentable{
    @State var style: UIBlurEffect.Style = .systemMaterial
    typealias UIViewType = UIView
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = .clear
        //.system will be adaptive
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        //setting constrains
        blurView.translatesAutoresizingMaskIntoConstraints = false
        //0 is the first underneath all views
        view.insertSubview(blurView, at: 0)
        //setting constrains
        NSLayoutConstraint.activate([
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor)
            
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}
