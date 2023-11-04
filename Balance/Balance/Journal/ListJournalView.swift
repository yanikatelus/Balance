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
            List{
                ///.enumerated():  transform collection  into a sequence of pairs (index, element),  index is  zero-based position of element within original collection. It's useful when you need both the index and the element itself in a loop.
                
                ForEach(Array(notes.reversed().enumerated()), id: \.element.id) { index, note in
                    HStack{
                        VStack{
                            Image(note.emoticon)
                                .resizable()
                                .frame(width: 40, height: 40)
                                .background(.white.opacity(0.8))
                                .cornerRadius(14)
                                .shadow(radius: 4)
                            
                            Text(note.emoticon)
                                .font( Font.custom("Avenir", size: 14) .weight(.medium))
                                .foregroundStyle(index % 2 == 1 ? Colors.BLACK: .white)
                            
                            ForEach(note.activities, id: \.self){ act in
                                HStack{
                                    Image(act)
                                        .frame(width: 10, height: 10)
                                        .padding(.leading, 4)
                                    Text(act)
                                        .frame(width: 50)
                                        .padding(.leading, 4)
                                }
                                .italic()
                                .font(Font.custom("Avenir", size: 13))
                                .foregroundColor(Colors.PURPLE3)
                                .padding(4)
                                .background(.white)
                                .cornerRadius(10)
                                .padding(2)
                            }//foreach act
                        }//Vstack
                        .padding(.horizontal, 2)
                        .padding(.vertical, 8)
                        .frame(width: 92, height: 200, alignment: .top)
                        .background(index % 2 == 1 ? Colors.PURPLE: Colors.PURPLE3)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.horizontal, 12)
                        .shadow(color: .black.opacity(0.08), radius: 4, x: 1, y: 2)
                        
                        VStack{
                            HStack {
                                Text(note.title)
                                    .padding(.leading, 8)
                                    .padding(.vertical, 3)
                                    .font(Font.custom("Avenir", size: 16).weight(.medium))
                                    .foregroundColor(index % 2 == 1 ? Colors.PURPLE3: .white)
                                Spacer()
                            }//hstack
                            
                            HStack {
                                Text(note.content)
                                    .lineLimit(5)
                                    .padding(.leading, 8)
                                    .padding(.bottom, 3)
                                    .font(Font.custom("Avenir", size: 15).weight(.medium))
                                    .foregroundColor(index % 2 == 1 ? Color(red: 0.38, green: 0.38, blue: 0.38) : .white)
                                Spacer()
                            }//hstack
                            
                            Spacer()
                            
                            HStack{
                                Text(note.timestamp)
                                    .font(Font.custom("Avenir", size: 14))
                                    .foregroundColor(index % 2 == 1 ? Colors.BLACK: .white)
                                    .padding(.vertical, 4)
                                    .padding(.leading, 8)
                                    .italic()
                                Spacer()
                            }//Hstack
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(index % 2 == 1 ? Colors.PURPLE: Colors.PURPLE3)
                        .cornerRadius(25, corners: [.topLeft, .bottomLeft])
                        .shadow(color: .black.opacity(0.08), radius: 4, x: 1, y: 2)
                        
                    }//Hstack
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    .padding(.bottom, 24)
                }//foreach loop
                .onDelete(perform: deleteNotes)
            }//List
            .listStyle(.plain)

        }//navigationView
        .padding(.leading, 12)
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

//cornerradious will depricated in future vesions of ios
//Tutorial for  rounded counrners:
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
