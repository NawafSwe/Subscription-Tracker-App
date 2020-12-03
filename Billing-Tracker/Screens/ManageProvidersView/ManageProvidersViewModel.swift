//
//  ManageProvidersViewModel.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 03/12/2020.
//

import Foundation
import Combine
import Firebase
import SwiftUI
final class ManageProvidersViewModel : ObservableObject{
    @Published var providers = [ProviderServices]()
    @Published var providersRepository = ProviderRepository()
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        // getting the providers list
        self.providersRepository.$providers
            .map{ providers in
                providers.map{ provider in
                    ProviderServices(provider: provider)
                    
                }
                
            }
            .assign(to: \.providers, on: self)
            .store(in: &cancellables)
        
        
        
        
    }
    
    
    
    func addProvider(provider:Provider){
        
    }
    
}
