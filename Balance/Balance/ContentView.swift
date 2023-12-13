//
//  ContentView.swift
//  Balance
//
//  Created by Yanika Telus on 10/21/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var manager: HealthManager
    
    @Query private var notes: [Notes]
    @Query private var cart: [Cart]

    var body: some View {
            if viewModel.userSession != nil {
                TabView {
                    HealthView()
                        .environmentObject(manager)
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                    JournalView()
                        .tabItem {
                            Label("Journal", systemImage: "book")
                        }
                        
                    UserMealView()
                        .tabItem {
                            Label("Meals", systemImage: "carrot")
                        }

                    ProfileView()
                        .tabItem {
                            Label("Settings", systemImage: "gearshape")
                        }
                }
                .tabViewStyle(.automatic)
                .environment(\.colorScheme, .light)
            } else {
                LoginView()
            }

    }//body
}

struct Colors {
    static let PURPLE  = Color(red: 0.82, green: 0.84, blue: 0.97)
    static let PURPLE2 = Color(red: 0.7, green: 0.66, blue: 0.87)
    static let PURPLE3 = Color(red: 0.21, green: 0.17, blue: 0.45)
    static let BLACK = Color(red: 0.19, green: 0.19, blue: 0.19)
    static let GRAY = Color(red: 0.38, green: 0.38, blue: 0.38)
    static let ACTIVE_PURPLE = Color(red: 0.51, green: 0.49, blue: 1)
}

struct Fonts{
    static let TITLE = Font.custom("Avenir", size: 24)
    static let TITLE2 = Font.custom("Avenir", size: 22)
    static let TITLE3 = Font.custom("Avenir", size: 20)
    static let TITLE4 = Font.custom("Avenir", size: 18)
    
    static let HEADER = Font.custom("Avenir", size: 28).weight(.heavy)
    
    static let BODY = Font.custom("Avenir", size: 16)
    static let ITALICS = Font.custom("Avenir-Italic", size: 14).italic()

}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
        .modelContainer(for: Notes.self, inMemory: true)
        .modelContainer(for: Cart.self, inMemory: true)
}
