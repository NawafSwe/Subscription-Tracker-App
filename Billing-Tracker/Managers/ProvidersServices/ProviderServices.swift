//
//  ProviderServices.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 02/12/2020.
//

import Foundation
import Firebase
import Combine
final class ProviderServices : ObservableObject ,Identifiable    {
    
    @Published var provider : Provider
    @Published var providersRepository = ProviderRepository()
    var id = ""
    var userId = Auth.auth().currentUser?.uid
    private var cancellables  = Set<AnyCancellable>()
    init(provider:Provider){
        self.provider  = provider
        //getting all providers
        $provider
            .compactMap{provider in
                provider.id
            }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
    }
}
