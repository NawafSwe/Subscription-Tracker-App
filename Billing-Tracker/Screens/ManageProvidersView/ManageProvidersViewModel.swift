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
    @Published var providerName = ""
    @Published var showAddProvider = false
    // toggle list in edit mode 
    @Published var isEditing = false
    
    
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
    
    
    
    func addProvider(){
        let helperProvider = Provider(name: self.providerName, image: Icons.SFCustomProvider)
        //adding provider
        providersRepository.addProvider(provider: helperProvider)
        
    }
    
    func deleteProvider(at offsets : IndexSet){
        var capturedId :String?
        for offset in offsets{
            capturedId = self.providers[offset].provider.id
        }
        guard let safeId  = capturedId else {return }
        providersRepository.deleteProvider(docId: safeId)
    }
}
