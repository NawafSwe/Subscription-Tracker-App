//
//  UserAuthentication.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 29/11/2020.
//

import Foundation
import Firebase
enum AuthenticationState { case signIn , signOut , null }
//MARK:- UserAuthenticationManager class for using firebase authentication services
final class UserAuthenticationManager : ObservableObject{
    @Published var session: User?
    var handle: AuthStateDidChangeListenerHandle?
    @Published var user = User(uid: "", displayName: "nwawaf", email: "")
    @Published var authState:AuthenticationState = .null

    static let shared = UserAuthenticationManager()
    private init () {}
    
    /// start listing 
    func listen () {
        // monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                // if we have a user, create a new user model
                print("oh there is a user")
                self.session = User(uid: user.uid, displayName: user.displayName, email: user.email)
                self.user = User(uid: user.uid, displayName: user.displayName, email: user.email)
                DispatchQueue.main.async {
                    self.authState = .signIn
                }
                
            } else {
                // if we don't have a user, set our session to nil
                print("oh there are no user")
                self.session = nil
                DispatchQueue.main.async {
                    self.authState = .signOut
                }
            }
        }
    }
    
    // additional methods (sign up, sign in) will go here
    
    func register(email:String , password:String , completion: @escaping (Result<Void,Error>)-> () ){
        
        Auth.auth().createUser(withEmail: email, password: password){  (authResult, error ) in
            if let err = error {
                completion(.failure(err))
                return
            }
            guard let _ = authResult?.user , let result = authResult  else{
                completion(.failure(error!))
                return
            }
            /// initing new user object from the authentication response if there is no error
            let user = User(uid: result.user.uid, displayName: result.user.displayName, email: result.user.email)
            DispatchQueue.main.async { self.user = user }
            FireStoreService.shared.saveDocument(collection: FireStoreKeys.collections.users, docId: user.uid, model: user,completion: {$0})
            
            /// initing providers data
            let providers:[Provider] = [
                .init(userId: user.uid, name: "Spotify", image: Images.Spotify),
                .init(userId: user.uid, name: "Netflix", image: Images.Netflix),
                .init(userId: user.uid, name: "Youtube", image: Images.Youtube),
                .init(userId: user.uid, name: "iCloud", image: Images.iCloud)
            ]
            /// initing provider
            for provider in providers{
                let uiImage = UIImage(named: provider.image)
                ProvidersService.shared.saveProvider(provider: provider) {_ in }
                ProvidersService.shared.uploadImage(image: uiImage!){_ in}
            }
            
            //            /// initing user with empty subscriptions
            //            let subscriptions : [Subscription] = []
            //
            //            FireStoreService.shared.updateData(collection: FireStoreKeys.collections.users, docId: user.uid , filed: FireStoreKeys.userFileds.subscriptions.rawValue, newData: subscriptions){$0}
            
            
        }
    }
    
    
    func login(email:String , password:String , completion: @escaping AuthDataResultCallback){
        Auth.auth().signIn(withEmail: email, password: password,completion: completion)
    }
    
    func logout()->Bool{
        do {
            try Auth.auth().signOut()
            self.session = nil
            return true
        } catch {
            return false
        }
    }
    
    
    
    /// stop listing
    func unbind () {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    /// retrieving user info
    func retriveUser(uid:String , completion: @escaping (Result<User,Error>)->() ){ }
}

