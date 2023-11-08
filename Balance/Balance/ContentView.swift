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
    @Query private var notes: [Notes]
    @Query private var cart: [Cart]

    var body: some View {
        TabView {
            Text("home")
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
            Text("Settings")
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
        .tabViewStyle(
            .automatic
        )
        .environment(\.colorScheme, .light)

    }//body
}

struct Colors {
    static let PURPLE  = Color(red: 0.82, green: 0.84, blue: 0.97)
    static let PURPLE2 = Color(red: 0.7, green: 0.66, blue: 0.87)
    static let PURPLE3 = Color(red: 0.21, green: 0.17, blue: 0.45)
    static let BLACK = Color(red: 0.19, green: 0.19, blue: 0.19)
    static let GRAY = Color(red: 0.38, green: 0.38, blue: 0.38)
}

#Preview {
    ContentView()
        .modelContainer(for: Notes.self, inMemory: true)
        .modelContainer(for: Cart.self, inMemory: true)
}
