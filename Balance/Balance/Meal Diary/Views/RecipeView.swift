//
//  RecipeView.swift
//  Balance
//
//  Created by Yanika Telus on 11/4/23.
//

import SwiftUI


struct RecipeView: View {
    var rating: Double
    var recipes: [Recipe] = mockRecipes
    
    var title: String
    var img: String
    var time: Int
    var summary: String
    
    var extendedIngredients: [Ingredient]
    
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
//                    Image(img)
                    AsyncImage(url: URL(string: img)){ phase in
                        switch phase {
                            case .empty:
                                ProgressView()
                        case .success(let image):
                            image
                                .resizable()
//                                .frame(height: 200)
                                .aspectRatio(contentMode: .fill)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
//                                .frame(height: 100)
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
//                                            .font(.system(size: 15))
                                        .frame(width: 15, height: 15)
                                } else {
                                    Image(systemName: "star.fill")
                                        .resizable()
                                        .foregroundColor(.white.opacity(0.7))
//                                            .font(.system(size: 15))
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
                    .font(Font.custom("Avenir", size: 20))
                    .fontWeight(.heavy)
                    .foregroundStyle(Colors.PURPLE3)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                
                Text(summary)
                    .padding(.horizontal, 12)
                    .font(Font.custom("Avenir", size: 18))
                    .foregroundColor(Colors.GRAY)

                
                Text("Ingrdients")
                    .font(Font.custom("Avenir", size: 20))
                    .fontWeight(.heavy)
                    .foregroundStyle(Colors.PURPLE3)
                    .padding(.horizontal, 12)
                
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
                                //Use this button to add this items to a list
                                print("added \(items)")
                            } label: {
                                HStack{
                                    Text("Add")
                                    Image(systemName: "plus")
                                        .padding(6)
                                        .background(Colors.PURPLE)
                                        .clipShape(RoundedRectangle(cornerRadius: 5))
                                        .frame(width: 24, height: 24)
                                }//HSTACK
                            }
                        }
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            }
        }
    }//BODY
}//END

#Preview {
    RecipeView(rating: 3.6, title: "Temporary title", img: "https://www.howtocook.recipes/wp-content/uploads/2021/05/Ratatouille-recipe.jpg", time: 90, summary: "text", extendedIngredients: [])
}
