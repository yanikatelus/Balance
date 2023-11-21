//
//  BalanceApp.swift
//  Balance
//
//  Created by Yanika Telus on 10/21/23.
//

import SwiftUI
import SwiftData
import Firebase

@main
struct BalanceApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Notes.self,
            Cart.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    //configure Firebase
    init(){
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
        .modelContainer(sharedModelContainer)
    }
}
