//
//  ShoppingCartView.swift
//  Balance
//
//  Created by Yanika Telus on 11/8/23.
//

import SwiftUI
import SwiftData

struct ShoppingCartView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var cart: [Cart]
    
    @State var foodQuery: String = ""
    @State var selected = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Search bar here")
                    .opacity(0.4)
                Spacer()
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(Colors.PURPLE)
            }
            .padding(8)
            .frame(maxWidth: .infinity, minHeight: 20, alignment: .leading)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .overlay(
                RoundedRectangle(cornerRadius: 10) // Shape of the outline
                    .stroke(Colors.PURPLE, lineWidth: 1) // Outline color and width
            )
            .padding(.top)
            .padding(.horizontal, 12)
            
            HStack {
                Text("Shopping cart")
                    .font(.title)
                    .padding(.horizontal, 12)
                Spacer()
            }
            
            List{
                ForEach(cart, id: \.id) { ingredient in
                    HStack{
//                            Button(action: {
//                                selected.toggle()
//                            }, label: {
//                                Image(systemName: selected ? "checkmark.square": "square")
//                            })
                        
                        Image(ingredient.image)
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text(ingredient.name)
                        Spacer()
                        Text("\(ingredient.amount, specifier: "%.1f") \(ingredient.unit)")
                    }
                    .padding(4)
                } //foreach
                .onDelete(perform: deleteCartItem)
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
    }//BODY
    private func deleteCartItem(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(cart[index])
            }
        }
    }
}//STRUCT

#Preview {
    ShoppingCartView()
}
