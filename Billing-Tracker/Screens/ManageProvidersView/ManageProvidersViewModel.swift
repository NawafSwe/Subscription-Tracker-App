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
    @Published var alertItem:AlertItem? = nil
    
    // fetching providers from firebase
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
    
    // adding provider
    func addProvider(){
        if providerName.isEmpty{
            DispatchQueue.main.async {
                self.alertItem = ProviderFormAlert.emptyName
            }
            return 
        }
        // provider by user
        let helperProvider = Provider(name: self.providerName, image: Images.CustomProvider , original : false , deleted: false )
        
        providersRepository.addProvider(provider: helperProvider){result in
            switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.alertItem = AlertItem(title: Text("Error"), message: Text(error.localizedDescription), dismissButton: .default(Text("OK")))
                    }
                case .success(_):
                    return
                    
            }
        }
        
    }
    
    // function to delete provider
    func deleteProvider(at offsets : IndexSet){
        var capturedId :String?
        for offset in offsets{
            capturedId = self.providers[offset].provider.id
        }
        guard let safeId  = capturedId else {return }
        providersRepository.deleteProvider(docId: safeId){result in
            switch result{
                case .failure(let error):
                    self.alertItem = AlertItem(title: Text("Error"), message: Text(error.localizedDescription), dismissButton: .default(Text("OK")))
                case .success(_):
                    return
            }
        }
    }
    func calculateProgress(string:String){
        if String.limitProgress(string: string, limit: 10){
            self.providerName = String(providerName.prefix(10))
            DispatchQueue.main.async {
                self.alertItem  = ProviderFormAlert.exceedLimit
            }
        
        }
    }
    
    
}
