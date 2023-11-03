//
//  ListJournalView.swift
//  Balance
//
//  Created by Yanika Telus on 10/22/23.
//

import SwiftUI
import SwiftData

struct ListJournalView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var notes: [Notes]
    
    var body: some View {
        NavigationView{
            VStack {
                List{
                    ForEach(notes.reversed(), id: \.id){ notes in
                        NavigationLink{
                            //The link will be to a view that takes notes of type [Notes]
                            Text("\(notes.title)")
                        } label: {
                            HStack{
                                VStack(alignment: .leading){
                                    if notes.emoticon != "" {
                                        Image("\(notes.emoticon)")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                    }
                                    ForEach(notes.activities, id: \.self) { act in
                                        Text(act)
                                            .padding(5)
                                            .background(.purple.opacity(0.5))
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                            .font(.caption)
                                    }
                                    Text("\(notes.emoticon)")
                                    Text("\(notes.timestamp)")
                                }
                                .padding()
                                
                                VStack(alignment: .leading){
                                    Text("\(notes.title)")
                                    Text("\(notes.content)")
                                }
                            } //Hstack
                        }
                    } //foreach
                    .onDelete(perform: deleteNotes)
                }//list
            }
        }//NavigationView
    }//BODY

    private func deleteNotes(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(notes[index])
            }
        }
    }
}

#Preview {
    ListJournalView()
        .modelContainer(for: Notes.self, inMemory: true)
}
