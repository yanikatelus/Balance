//
//  SetGoalsView.swift
//  Balance
//
//  Created by Yanika Telus on 12/13/23.
//

import SwiftUI
import SwiftData

struct SetGoalsView: View {
    @Binding var isPresented: Bool
    @Binding var stepGoal: Int
    @Binding var calorieGoal: Int
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    @Query private var activity: [Activity]
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Step Goal")) {
                    Stepper(value: $stepGoal, in: 1000...20000, step: 500) {
                        Text("\(stepGoal) steps")
                    }
                }
                
                Section(header: Text("Calorie Goal")) {
                    Stepper(value: $calorieGoal, in: 100...5000, step: 100) {
                        Text("\(calorieGoal) calories")
                    }
                }
            }
            
            Button{
                setGoal()
                dismiss()
                isPresented = false
            }label: {
                Text("Save Goals")
            }
            
        }//vstack

    }//body
    private func setGoal() {

//            let newItem = Notes(timestamp: formatDateNote(Date()), title: userTitle, content: userContent, emoticon: userEmoticon, activities: selectedActivities)
        let newItem = Activity(stepGoal: stepGoal, calorieGoal: calorieGoal)
            
            modelContext.insert(newItem)

    }//addItem
}

#Preview {
    SetGoalsView(isPresented: .constant(true), stepGoal: .constant(100), calorieGoal: .constant(100))
        .modelContainer(for: Activity.self, inMemory: true)
}
