//
//  HealthView.swift
//  Balance
//
//  Created by Yanika Telus on 12/11/23.
//

import SwiftUI
import Charts
import SwiftData

struct HealthView: View {
    @EnvironmentObject var manager: HealthManager
    @EnvironmentObject var viewModel: AuthViewModel
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    @Query private var notes: [Notes]
    @Query private var activity: [Activity]//goals
    
    @State private var stepGoal: Int = 1000
    @State private var calorieGoal: Int = 400
    @State private var activeGoal: Int = 400
    
    @State private var isGoalSettingSheetPresented = false
    
    private var caloriePercentage: Double {
        if calorieGoal > 0 {
            return min(Double(manager.todayCaloriesBurned) / Double(calorieGoal), 1.0)
        } else {
            return 0.0
        }
    }
    
    private var stepPercentage: Double {
        if stepGoal > 0 {
            return min((Double(manager.todaySteps) ?? 0) / Double(stepGoal), 1.0)
        } else {
            return 0.0
        }
    }
    
    private var totalPercentage: Double {
        if activeGoal > 0 {
            return min((Double(manager.todaytotalCaloriesBurned) ) / Double(activeGoal), 1.0)
        } else {
            return 0.0
        }
    }
    var body: some View {
        VStack(alignment: .leading) {
            NavigationView{
                VStack{
                    VStack{
                        if let user = viewModel.currentUser {
                            UserGreetingView(username: user.fullname)
                                .padding(.vertical, 12)
                        }else{
                            UserGreetingView(username: "user")
                                .padding(.vertical, 12)
                        }
                    }
                    VStack {
                        Text("\(Text("Today").font(Font.custom("Avenir", size: 18)).fontWeight(.medium)), \n \(formatDateNote(Date()))")
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            .font(
                                Font.custom("Avenir", size: 12)
                                .weight(.medium)
                            )
                            .foregroundColor(Color(red: 0.38, green: 0.38, blue: 0.38))
                        .padding(.bottom, 12)
                    }

                    
                    HStack {
                        Text("Your Daily Stats")
                            .font(Fonts.TITLE3)
                            .fontWeight(.medium)
                        Spacer()
                    }
                        
                    HStack {
                        ZStack {
                            CircularSegmentedProgressBar(Percentage: caloriePercentage, color: Colors.PURPLE3)
                                .frame(width: 100, height: 100)
                                .padding()
                            CircularSegmentedProgressBar(Percentage: stepPercentage, color: Colors.ACTIVE_PURPLE)
                                .frame(width: 80, height: 80)
                                .padding()
                            CircularSegmentedProgressBar(Percentage: totalPercentage, color: Colors.PURPLE2)
                                .frame(width: 60, height: 60)
                                .padding()
                        }//Zstack
                        Spacer()
//                            //crash
//                            if let lastItem = activity.last{
//
//                            }
                            VStack{
                                Image(systemName: "figure.walk")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 20, height: 20)
                                Text("Steps")
                                    .font(
                                        Font.custom("Avenir", size: 16)
                                            .weight(.black)
                                    )
                                Text("\(manager.todaySteps)")
                                    .font(
                                        Font.custom("Avenir", size: 14)
                                            .weight(.bold)
                                    )
                                Text("\(stepGoal)")
                                    .font(
                                        Font.custom("Avenir", size: 14)
                                            .weight(.medium)
                                    )
                                    .foregroundColor(Colors.GRAY)
                            }
                            .foregroundStyle(Colors.PURPLE3)
//                            }
                        
                        VStack{
                            Image(systemName: "flame")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 20, height: 20)
                            Text("Cal")
                                .font(
                                    Font.custom("Avenir", size: 16)
                                        .weight(.black)
                                )
                            Text("\(manager.todayCaloriesBurned)")
                                .font(
                                    Font.custom("Avenir", size: 14)
                                        .weight(.bold)
                                )
                            Text("\(calorieGoal)")
                                .font(
                                    Font.custom("Avenir", size: 14)
                                        .weight(.medium)
                                )
                                .foregroundColor(Colors.GRAY)
                        }
                        .padding()
                        .foregroundStyle(Colors.ACTIVE_PURPLE)
                        
                        VStack{
                            Image(systemName: "flame")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 20, height: 20)
                            Text("Kcal")
                                .font(
                                    Font.custom("Avenir", size: 16)
                                        .weight(.black)
                                )
                            Text("\(manager.todaytotalCaloriesBurned)")
                                .font(
                                    Font.custom("Avenir", size: 14)
                                        .weight(.bold)
                                )
                            Text("\(activeGoal)")
                                .font(
                                    Font.custom("Avenir", size: 14)
                                        .weight(.medium)
                                )
                                .foregroundColor(Colors.GRAY)
                        }
                        .foregroundStyle(Colors.PURPLE2)
                        Spacer()
                    }
                    .padding()
                    .frame(width: .infinity)
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.16), radius: 5, x: 1.5, y: 2)
                        
                        
                    HStack {
                        Spacer()
                        Button {
                                isGoalSettingSheetPresented = true
                            } label: {
                                Text("Set Goals")
                                    .padding(8)
                                    .background(Colors.PURPLE)
                                    .cornerRadius(10, corners: .allCorners)
                            }
                            .buttonStyle(.plain)
                            .sheet(isPresented: $isGoalSettingSheetPresented) {
                                SetGoalsView(
                                    isPresented: $isGoalSettingSheetPresented,
                                    stepGoal: $stepGoal,
                                    calorieGoal: $calorieGoal,
                                    activeGoal: $activeGoal
                                )
                        }
                    }
                    HStack{
                        Text("Your HeartRate in 24hr ")
                            .font(Fonts.TITLE3)
                            .fontWeight(.medium)
                        Spacer()
                    }
                    HStack {
                        Chart {
                            ForEach(manager.heartRateDataArray, id: \.self){ index in
                                LineMark(x: .value("Time", "\(index.timestamp)"),y: .value("Value", index.bpm))
                            }
                        }//chart
                        .foregroundStyle(Colors.PURPLE)
                        .chartLegend(.automatic)
                        
//                        Spacer()
                    }
                    .padding()
                    .frame(width: .infinity)
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.16), radius: 5, x: 1.5, y: 2)
                    Spacer()
                    
                }
                .frame(width: .infinity, height: .infinity)
                .padding(.horizontal, 12)
                
//                Chart
            }//NavigationView
        }//VStack
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .onAppear{
            manager.fetchTodaySteps()
            manager.fetchTodayCaloriesBurned()
            manager.fetchTodayTotalCaloriesBurned()
//            manager.fetchHeartRateData()
            manager.fetchHistoricalHeartRateData()
        }//on appear
        
    }//bodt
}


struct CircularSegmentedProgressBar: View {
    
    var Percentage: Double
    var color: Color

    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: CGFloat(Percentage))
                .stroke(color, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .rotationEffect(.degrees(-90))

            Circle()
                .trim(from: 0, to: 1)
                .stroke(color, lineWidth: 10)
                .rotationEffect(.degrees(-90))
                .opacity(0.1)
        }//ZStack
    }
}

#Preview {
    HealthView()
        .environmentObject(HealthManager())
        .environmentObject(AuthViewModel())
        .modelContainer(for: Notes.self, inMemory: true)
        .modelContainer(for: Activity.self, inMemory: true)
}
