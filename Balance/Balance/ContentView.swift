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
                
            ListJournalView()
                .tabItem {

                    Label("Meals", systemImage: "carrot")
                }
            Text("Settings")
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
        .background(Colors.BLACK)
    }//body
}

struct Colors {
    static let PURPLE  = Color(red: 0.82, green: 0.84, blue: 0.97)
    static let PURPLE2 = Color(red: 0.7, green: 0.66, blue: 0.87)
    static let PURPLE3 = Color(red: 0.51, green: 0.49, blue: 1)
    static let BLACK = Color(red: 0.19, green: 0.19, blue: 0.19)
    static let GRAY = Color(red: 0.38, green: 0.38, blue: 0.38)
}

#Preview {
    ContentView()
        .modelContainer(for: Notes.self, inMemory: true)
}
