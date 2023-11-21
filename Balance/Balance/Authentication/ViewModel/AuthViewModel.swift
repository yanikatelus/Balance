//
//  AuthModel.swift
//  Balance
//
//  Created by Yanika Telus on 11/17/23.
//
///Tutorial: https://www.youtube.com/watch?v=QJHmhLGv-_0&ab_channel=AppStuff
import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor// publish ui changes on the mai thread
class AuthViewModel: ObservableObject {
    //Optional to Checks to see wether we have a user logged in or not
    @Published var userSession: FirebaseAuth.User?//firebase user
    @Published var currentUser: User?// Balance app user
    
    init() {
        self.userSession = Auth.auth().currentUser //cache current user into local device
        
        Task{
            await fetchUser()
        }
    }
    
    
    func signIn(withEmail email: String, password: String) async throws {
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("Debug: Failed to log in user with errror \(error.localizedDescription)")
        }
        print("Signing in user")
    }//signIn
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullname: fullname, email: email)
            
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            print("Created user")
            //once user is created, we need to fetch user's data (User data model)
            await fetchUser()
        }catch{
            print("Debog Error: Failed to create user with error \(error.localizedDescription)")
        }
        
    }//createUser
    
    func signout() {
        do{
            try Auth.auth().signOut()//signs out user on the backend
            self.currentUser = nil // clears user session and returns to login screen
            self.userSession = nil //clears current user data mdoel
        } catch {
            print("Debug:Failed to sign out with error \(error.localizedDescription) ")
        }
        
        print("Sign out in user")
    }//signout
    
    func deleteAccount() {
//        do{
//            let result = try Auth.auth().currentUser?.delete()
//            self.userSession = result
            Auth.auth().currentUser?.delete()
            
//        } catch {
//            
//        }
        print("Deleted account")
    }//deleteAccount
    
    func fetchUser() async {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }//get current users id
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
        
        print("Debug: Getting Current user '\(String(describing: self.currentUser))'s' account")
    }//fetchUser
    
}
