//
//  SafariView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 28/11/2020.
//

import Foundation
import SwiftUI
import SafariServices
struct SafariView: UIViewControllerRepresentable{
    //url to visit
    let url:URL
    //wants to return SFSafariViewController from safari services
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) ->  SFSafariViewController {
        SFSafariViewController(url: self.url)
    }
    
    //no need to implement updateUIViewController
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {}
}
