//
//  RecipeView.swift
//  Balance
//
//  Created by Yanika Telus on 11/4/23.
//

import SwiftUI
import SwiftData


struct RecipeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var cart: [Cart]

    @State var viewSummary: Bool = false
    var rating: Double
    var recipes: [Recipe] = mockRecipes
    
    var title: String
    var img: String
    var time: Int
    var summary: String
    
    var extendedIngredients: [Ingredient]
    
    @State private var showAlert = false
    @State private var itemToUpdate: Cart?
    @State private var currentItem: String = ""
    
    var body: some View {
        VStack {
            VStack(alignment: .leading){
                Text(title)
                    .textCase(.uppercase)
                    .padding(.horizontal, 12)
                    .font(Font.custom("Avenir", size: 22))
                    .fontWeight(.heavy)
                    .foregroundColor(Colors.PURPLE3)

                ZStack(alignment: .bottom) {
                    AsyncImage(url: URL(string: img)){ phase in
                        switch phase {
                            case .empty:
                                ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay{
                                    RoundedRectangle(cornerRadius: 10)
                                        .opacity(0.0)
                                        .background(
                                            LinearGradient(
                                                stops: [
                                                    Gradient.Stop(color: .black.opacity(0), location: 0.33),
                                                    Gradient.Stop(color: .black.opacity(0.9), location: 0.95),
                                                ],
                                                startPoint: UnitPoint(x: 0.5, y: 0),
                                                endPoint: UnitPoint(x: 0.5, y: 1)
                                            )
                                        )
                                }//overlay
                        case .failure(_):
                                Image(systemName: "photo") // Display an image indicating failure
                        @unknown default:
                            Image(systemName: "photo")
                        }
                    }
                    
                    HStack(alignment: .bottom){
                        HStack{
                            Image(systemName: "clock.fill")
                                .resizable()
                                .frame(width: 24, height: 24)
                            
                            Text("\(time)")
                                .font(Font.custom("Avenir", size: 20))
                                .bold()
                        }
                        .padding(.bottom, 12)
                        .foregroundStyle(.white)
                        
                        Spacer()
                        
                        HStack{
                            
                            Text("\(200) CAL")
                                .font(Font.custom("Avenir", size: 20))
                                .bold()
                        }
                        .padding(.bottom, 12)
                        .foregroundStyle(.white)
                        
                        Spacer()
                        
                        HStack{
                            
                            Text("\(rating, specifier: "%.1f")")
                                .font(Font.custom("Avenir", size: 20))
                            ForEach(0..<5) { index in
                                if index < Int(rating) {
                                    Image(systemName: "star.fill")
                                        .resizable()
                                        .foregroundColor(.yellow)
                                        .frame(width: 15, height: 15)
                                } else {
                                    Image(systemName: "star.fill")
                                        .resizable()
                                        .foregroundColor(.white.opacity(0.7))
                                        .frame(width: 15, height: 15)
                                }//if
                            } //foreach
                        }//Hstack
                        .padding(.bottom, 12)
                        .foregroundStyle(.white)
                        .frame(width: 148)
                        
                    }//HSTACK
                    .padding(.horizontal, 12)

                }//ZSTACK
                
                Text("Summary")
                    .onTapGesture {
                        viewSummary.self.toggle()
                    }
                    .font(Font.custom("Avenir", size: 20))
                    .fontWeight(.heavy)
                    .foregroundStyle(Colors.PURPLE3)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                if viewSummary {
                    Text(summary)
                        .padding(.horizontal, 12)
                        .font(Font.custom("Avenir", size: 18))
                        .foregroundColor(Colors.GRAY)
                }
                
                HStack{
                    Text("Ingrdients")
                        .font(Font.custom("Avenir", size: 20))
                        .fontWeight(.heavy)
                        .foregroundStyle(Colors.PURPLE3)
                        .padding(.horizontal, 12)
                    
                    Spacer()
                    Button{
                        for listItems in extendedIngredients{
                            currentItem = listItems.name
                            addItems(id: listItems.id, aisle: listItems.aisle, image: listItems.image, name: listItems.name, amount: listItems.amount, unit: listItems.unit)
                            showAlert = false // i want to reset the alert bool each time
                        }
                    }label: {
                        withAnimation {
                            HStack{
                                Text("Add All ingredients")
                                Image(systemName: "plus")
                                    .padding(6)
                                    .background(Colors.PURPLE)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                    .frame(width: 24, height: 24)
                            }
                        }//HSTACK
                    }
                    .padding(.horizontal, 20)
                }
                List{
                    ForEach(extendedIngredients, id: \.self) { items in
                        HStack{
                            HStack{
                                Image(items.image)
                                    .resizable()
                                    .frame(width: 36, height: 36)
                                Text(items.name)
                                Text("\(items.amount , specifier: "%.1f") \(items.unit)")
                            }
                            Spacer()
                            Button{
                                currentItem = items.name
                                addItems(id: items.id , aisle: items.aisle, image: items.image, name: items.name, amount: items.amount, unit: items.unit)
                            } label: {
                                withAnimation {
                                    HStack{
                                        Text("Add")
                                        Image(systemName: "plus")
                                            .padding(6)
                                            .background(Colors.PURPLE)
                                            .clipShape(RoundedRectangle(cornerRadius: 5))
                                            .frame(width: 24, height: 24)
                                    }
                                }//HSTACK
                            }//button
                        }
                    }//foreahc
                    .listRowSeparator(.hidden)
                }//list
                .listStyle(.plain)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("\(currentItem) Already in Cart"),
                message: Text("This item has already been added to your cart. Would you like to increase the amount?"),
                primaryButton: .default(Text("Increase"), action: {
                    ItemIncrease(itemToUpdate)
                }),
                secondaryButton: .cancel()
            )
        }
    }//BODY
    
//    func addItems(id:Int, aisle: String, image: String, name: String, amount: Double, unit: String) {
//        let newItem = Cart(id: id, aisle: aisle, image: image, name: name, amount: amount, unit: unit)
//        if cart.contains(newItem){
//            ItemIncrease(newItem)
//        }else{
//            modelContext.insert(newItem)
//        }
//    }
    func addItems(id:Int, aisle: String, image: String, name: String, amount: Double, unit: String) {

        if let existingItemIndex = cart.firstIndex(where: { $0.id == id }) {
            // Found existing item, prepare to show alert
            showAlert = true
            itemToUpdate = cart[existingItemIndex]
            return
        }
        let newItem = Cart(id: id, aisle: aisle, image: image, name: name, amount: amount, unit: unit)
        modelContext.insert(newItem)
    }
    
//    func ItemIncrease(_ item: Cart?) {
//        //if item is not nil continue
//        guard let updatingItem = item else { return }
//        //      cycle through number of items in cart
//        for i in (0..<cart.count){
////            if cart.contains(updatingItem){
//                print("\(cart[i].amount) \(cart.contains(updatingItem))")
//                cart[i].amount += updatingItem.amount
//                
//                print("incresed to \(cart[i].amount) add \(updatingItem.amount) ")
//                modelContext.insert(cart[i])
//                break
////            }
//        }
//        modelContext.insert(updatingItem)
//    }
    
    func ItemIncrease(_ item: Cart?) {
        //unwrap item
        guard let updatingItem = item else { return }
        
        for _ in (0..<cart.count){
            if let index = cart.firstIndex(where: { $0.id == updatingItem.id }) {
                cart[index].amount += updatingItem.amount
                break
            }//if
        }
    }
    
}//END

#Preview {
    RecipeView(rating: 3.6, title: "Temporary title", img: "https://www.howtocook.recipes/wp-content/uploads/2021/05/Ratatouille-recipe.jpg", time: 90, summary: "text", extendedIngredients: [Ingredient(id: 200, aisle: "cheese", image: "eggs", name: "Eggs", amount: 24, unit: "Ounces")])
        .modelContainer(for: Cart.self, inMemory: true)
}
