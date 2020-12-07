//
//  ProvidedProvidersViewModel.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 07/12/2020.
//

import Foundation
import SwiftUI
import Combine

final class ProvidedProvidersViewModel : ObservableObject{
    // i should bring providedProviders instead of user providers its self
    @Published var providerServices = [ProviderServices]()
    @Published var providersRepository = ProviderRepository()
    @Published var selectedProvider: ProviderServices?
    @Published var didSelectProvider = false
    private var cancellables = Set<AnyCancellable>()
    
    //init original providers
    init(){
        self.providersRepository
            .$originalProviders
            .map{ providers in
                providers.map{provider in
                    ProviderServices(provider: provider)
                }
                
            }
            .assign(to: \.providerServices, on: self)
            .store(in: &cancellables)
    }
    
    func addProvider(provider:ProviderServices){
        guard let docId = provider.provider.id else {return }
        
        self.providersRepository.addOriginalProvider(docId: docId) { _ in }
        
    }
    
}
