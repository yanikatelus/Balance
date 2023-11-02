//
//  UserMealView.swift
//  Balance
//
//  Created by Yanika Telus on 10/31/23.
//

import SwiftUI

struct UserMealView: View {
    //the following two need to be ollected when user logs in and enteres their preferences, name, gender, calorie goal, and dietary foods
    @State private var userName = "User"
    @State private var dietCategories = ["Vegan", "Keto", "Paleo", "Mediterranean"]// Will need to pass these as complexSearch; I will eventually let users select their dietary prefrances
    
    @State private var score: Double = 96
    @State private var aggregateLikes: Int = 1453
        
    // Convert the score out of 100 to a score out of 5
    var rating: Double { return (score / 20.0) }
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        VStack{
            HStack{
                UserGreetingView(username: $userName)//will need to pulll this from authentication
                    .foregroundColor(.black)
                Image(systemName: "bag.circle.fill")
                    .resizable()
                    .frame(width: 44, height: 44)
                    .foregroundColor(Colors.PURPLE2)
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
                    ForEach(1...8, id: \.self) { _ in
                        Button(action: {
                            
                        }, label: {
                            CourseCard(rating: rating, aggregateLikes: aggregateLikes)
                        })
                        .buttonStyle(PlainButtonStyle())
                        .shadow(color: Color(red: 0.54, green: 0.58, blue: 0.62).opacity(0.22), radius: 10, x: 0, y: 2)

                    }
                }
            }
            .frame(height: 450)
            .padding(12)

            
            
            
        }//vstack
    }//body
}//end

#Preview {
    UserMealView()
}

struct CourseCard: View {
    var rating: Double
    var aggregateLikes: Int
    
    var body: some View {
        ZStack {
            HStack {
                Image("taco")
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .frame(width: 170, height: 170)
                    .shadow(radius: 0.8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom))
                    )
            }//HStack
            VStack(alignment: .leading){
                HStack(){
                    Spacer()
                    Button(action: {
                        //open subview that allow you to add recipe to a list or add ingredients to cart
                    }, label: {
                        Image(systemName: "plus")
                            .resizable()
                            .bold()
                            .frame(width: 16, height: 16)
                            .padding(6)
                            .background(Colors.PURPLE2)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 5.0))
                    })
                }//hstack
                Spacer()
                HStack() {
                    Text("Chorizo & mozzarella gnocchi bake")
                        .font(Font.custom("Avenir", size: 14))
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
//                    Spacer()
                }
                
                
                HStack {
                    ForEach(0..<5) { index in
                        if index < Int(rating) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .font(.system(size: 9))
                                .frame(width: 6)
                        } else {
                            Image(systemName: "star.fill")
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
