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

import FirebaseStorage

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

/**
 Represents the authentication view model for the Balance app.
 
 This view model is responsible for managing user authentication, including sign-in, sign-up, sign-out,
 and profile image management.
 
 - Note: This view model uses Firebase for authentication and Firestore for user data storage.
 */

@MainActor// publish ui changes on the main thread
class AuthViewModel: ObservableObject {
    //Optional to Checks to see wether we have a user logged in or not
    @Published var userSession: FirebaseAuth.User?//firebase user
    @Published var currentUser: User?// Balance app user
    
    /**
     Initializes an instance of AuthViewModel.
     
     This constructor sets up the initial state by caching the current user into the local device
     and fetching user data if available.
     */
    
    init() {
        self.userSession = Auth.auth().currentUser //cache current user into local device
        
        Task{
            await fetchUser()
        }
    }
    
    /**
     Sign in a user with their email and password.
     
     - Parameters:
       - email: The user's email.
       - password: The user's password.
     
     - Throws: An error if the sign-in operation fails.
     */
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("Debug: Failed to log in user with errror \(error.localizedDescription)")
        }
        print("Signing in user")
    }//signIn
    
    /**
     Create a new user account with email, password, and full name.
     
     - Parameters:
       - email: The user's email.
       - password: The user's password.
       - fullname: The user's full name.
     
     - Throws: An error if the account creation fails.
     */
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullname: fullname, email: email)
            
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            print("Created user")
            //once user is created, we need to fetch user's data (User data model)
            await fetchUser()
        } catch {
            print("Debog Error: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    /**
     Sign out the current user.
     
     This method signs out the user on the backend and clears the user session.
     */
    func signout() {
        do{
            try Auth.auth().signOut()//signs out user on the backend
            self.currentUser = nil // clears user session and returns to login screen
            self.userSession = nil //clears current user data mdoel
        } catch {
            print("Debug: Failed to sign out with error \(error.localizedDescription) ")
        }
        print("Sign out in user")
    }//signout
    
    /**
     Delete the current user's account.
     
     This method deletes the user's account and clears the user session.
     */
    func deleteAccount() async {
        do{
            try await Auth.auth().currentUser?.delete()
            self.currentUser = nil
            self.userSession = nil
            print("Deleted account")
        } catch {
            print("DEBUG: Error deleting user account with error: '\(error.localizedDescription)")
        }
    }//deleteAccount
    /**
     Fetch user data for the current user.
     
     This method retrieves user data from Firestore based on the user's ID.
     */
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }//get current users id
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
        
        print("Debug: Getting Current user '\(String(describing: self.currentUser))'s' account")
    }//fetchUser
    
}//AuthViewModel
/**
 Uploads the user's profile image to Firebase Storage.
 
 - Parameters:
   - image: The user's profile image to be uploaded.
   - completion: A completion handler that returns the result of the upload.
 
 - Note: If the image conversion fails, an `ImageConversionError` is returned in the completion handler.
 */
extension AuthViewModel {
    func uploadProfileImage(_ image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {
            completion(.failure(NSError(domain: "ImageConversionError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unable to convert image to Data"])))
            return
        }
        let storageRef = Storage.storage().reference(withPath: "profile_images/\(userSession?.uid ?? "unknown_user").jpg")

        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            storageRef.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                } else if let url = url {
                    completion(.success(url.absoluteString))
                }
            }
        }
    }//func uploadProfileImage
}
/**
 Updates the user's profile image URL in Firestore.
 
 - Parameters:
   - url: The new profile image URL to be updated.
 
 - Note: This method also updates the `currentUser` object with the new profile image URL.
 */

extension AuthViewModel {
    func updateUserProfileImageURL(_ url: String) async {
        Task{
            await fetchUser()
        }
        guard let uid = userSession?.uid else { return }

        let userRef = Firestore.firestore().collection("users").document(uid)
        do {
            try await userRef.updateData(["profileImageUrl": url])
            // update the currentUser object
            if var currentUser = currentUser {
                currentUser.profileImageUrl = url
                self.currentUser = currentUser
            }
        } catch {
            print("Error updating user's profile image URL: \(error.localizedDescription)")
        }
    }
}
