//
//  UserMealView.swift
//  Balance
//
//  Created by Yanika Telus on 10/31/23.
//

import SwiftUI
import SwiftData

struct UserMealView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var cart: [Cart]
    //the following two need to be collected when user logs in and enteres their preferences, name, gender, calorie goal, and dietary foods
    @State private var userName = "User"
    @State private var dietCategories = ["Vegan", "Keto", "Paleo", "Mediterranean"]// Will need to pass these as complexSearch; I will eventually let users select their dietary prefrances
    
    @State private var score: Double = 23
    @State private var aggregateLikes: Int = 1453
    // Convert the score out of 100 to a score out of 5
    
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var recipes: [Recipe] = mockRecipes
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    UserGreetingView(username: userName)
                        .foregroundColor(.black)
//                    Button{
//
//                    }label: {
//                        Image(systemName: "bag.circle.fill")
//                            .resizable()
//                            .frame(width: 44, height: 44)
//                            .foregroundColor(Colors.PURPLE2)
//                    }
                    NavigationLink(destination: {
                        ShoppingCartView()
                    }, label: {
                        Image(systemName: "bag.circle.fill")
                            .resizable()
                            .frame(width: 44, height: 44)
                            .foregroundColor(Colors.PURPLE2)
                    })
                }
                .padding()
                //SEARCH
                
                //SUBTITTLE
                HStack {
                    Text("Categories")
                        .font(Font.custom("Avenir", size: 18))
                        .foregroundColor(.gray)
                        .fontWeight(.heavy)
                    Spacer()
                }
                .padding(.horizontal, 12)
                
                //CATEGORY ScrollView
                ScrollView(.horizontal){
                    CategoryScrollView(dietCategories: dietCategories)
                }
                
                //POPULAR COURSES
                HStack {
                    Text("Popular Courses")
                        .font(Font.custom("Avenir", size: 18))
                        .foregroundColor(.gray)
                        .fontWeight(.heavy)
                    Spacer()
                }
                .padding(.horizontal, 12)


                ScrollView{
                    LazyVGrid(columns: columns, spacing: 14) {
                        ForEach(recipes, id: \.self) { recipe in
                            VStack {
                                var rating: Double { return (Double(recipe.healthScore) / 20.0) }
                                NavigationLink{
                                    RecipeView(rating: rating, title: recipe.title, img: recipe.image, time: recipe.readyInMinutes, summary: recipe.summary, extendedIngredients: recipe.extendedIngredients)
                                }label: {
                                    CourseCard(rating: rating, aggregateLikes: recipe.aggregateLikes, title: recipe.title, img: recipe.image)
                                }
                            } //vstack

                        }//foreach
                    }//lazy
                }//scroll
                .frame(height: 450)
                .padding(12)

                
                
                
            }
        }//vstack
    }//body
}//end

#Preview {
    UserMealView()
}

struct CourseCard: View {
    var rating: Double
    var aggregateLikes: Int
    var title: String
    var img: String
    
    @State private var showMenu = false
    var body: some View {
        ZStack {
            HStack {
                AsyncImage(url: URL(string: img)) { phase in
                    switch phase {
                        case .empty:
                            ProgressView() // Display a progress view while the image is loading
                        case .success(let image):
                            image // This is an Image view now, so you can use the resizable modifier
                                .resizable()
                                .aspectRatio(contentMode: .fill) // Fill the frame while maintaining aspect ratio
                                .frame(width: 170, height: 170)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(radius: 0.8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom))
                                )
                        case .failure(_):
                            Image(systemName: "photo") // Display an image indicating failure
                        @unknown default:
                        Image(systemName: "photo")
                    }
                }
                .frame(width: 170, height: 170)
                
            } //HStack
            VStack(alignment: .leading){
                HStack(){
                    Spacer()
//                    Button(action: {
//                        //open subview that allow you to add recipe to a list or add ingredients to cart
//                        self.showMenu.toggle()
//                    }, label: {
//                        Image(systemName: "plus")
//                            .resizable()
//                            .bold()
//                            .frame(width: 16, height: 16)
//                            .padding(6)
//                            .background(Colors.PURPLE2)
//                            .foregroundColor(.white)
//                            .clipShape(RoundedRectangle(cornerRadius: 5.0))
//                    })
//                    .overlay(
//                        Group {
//                            if showMenu {
//                                // The menu view
//                                VStack(alignment: .trailing) {
//                                    Button() {
//                                        //Get info and save to list
//                                        self.showMenu = false
//                                    }label: {
//                                        Text("Add to Cart")
//                                        Image(systemName: "cart")
//                                    }
//                                    Button("Create New List") {
//                                        // Handle create new list action
//                                        self.showMenu = false
//                                    }
//                                }
//                                .frame(width: 170) // Set the width of the dropdown
//                                .background(Color.white) // Set the background of the dropdown
//                                .cornerRadius(5)
//                                .shadow(radius: 5)
//                                .offset(x: 0, y: 55)
//                            }
//                        },
//                        alignment: .bottomTrailing
//                    )
                } //hstack
                
                Spacer()
                HStack() {
                    Text(title)
                        .font(Font.custom("Avenir", size: 14))
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                }
                
                
                HStack {
                    ForEach(0..<5) { index in
                        if index < Int(rating) {
                            Image(systemName: "carrot.fill")
                                .foregroundColor(.yellow)
                                .font(.system(size: 9))
                                .frame(width: 6)
                        } else {
                            Image(systemName: "carrot.fill")
                                .foregroundColor(.white.opacity(0.7))
                                .font(.system(size: 9))
                                .frame(width: 6)
                        }//if
                    } //foreach
                    Text("\(rating, specifier: "%.1f")")
                        .foregroundColor(.white)
                        .font(.caption)
                        .fontWeight(.medium)
                    Spacer()
                    Text("\(aggregateLikes)")
                        .foregroundColor(.white)
                        .font(.caption)
                        .fontWeight(.medium)
                    
                } //hstack
                .padding(.horizontal, 12)
                
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 8)
        }//zstack
        .frame(width: 165, height: 178)
    }
}

struct CategoryScrollView: View {
    
    var dietCategories: [String]
    var body: some View {
        HStack{
            ForEach(dietCategories, id:\.self) { items in
                Button(action: {
                    //query for categorie of food
                }, label: {
                    HStack {
                        HStack {
                            Text(items)
                                .tint(.black)
                            GeometryReader { geometry in
                                Image("happy")
                                    .resizable()
                                    .frame(width: geometry.size.width/0.5, height: geometry.size.height, alignment: .trailing)
                                    .clipped()
                            }
                            .frame(width: 25, height: 50)
                        }//Hstack
                        .padding(.leading)
                        .padding(.vertical, 8)
                        .background(Color.white) // Background of the HStack
                    }//Hstack 2
                    .clipShape(RoundedRectangle(cornerRadius: 8.0))
                    .shadow(color: Color.black.opacity(0.17), radius: 8)
                    
                })
                
            } //Hstack
            .padding(12)
        }
    }
}
