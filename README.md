Hello: When downloading zip file please delete the RED extra HealthView!!! (there was an issue with Icloud overwritting my changes and did not initally dave the file)

YANIKA T.
ISTE 454 PROJECT: Balance

00.  APP TITLE 
Renamed app to Balance. 
Presentation Link
 APP DEFINITION
Balance is a health app centered on keeping track and providing an overall view of your Overall health and wellness. Featuring three main views, users will be able to view their health stats recorded by wearable devices, search for food recipes and ingredients, and  a mental health journal to keep a history of moods and thoughts. Many competitors separate these functions and can become inconvenient to track on multiple platforms. 
This app will be made to be accessible for all ages 16+ and provide a more holistic view of one's health. These three areas of focus are interconnected and can offer users a comprehensive insight into users overall well-being
FINAl UI


 IMPLEMENTATION (from proposal list)
Fitness View/Unified View: 
Display today's date allows users to toggle between days. Must have
Show a brief summary of today's food intake, workout, and mood at a glance. Must have  
Activity Tracking: Steps, Calories, Distance, Types of workouts Must have
Heart Rate Monitoring: Resting heart rate, Average heart rate Must have
Customization: User profiles (age, weight, gender) Will implement if time allows  
User profiles: Name, Image, Email, and password. SIgn and sign out capabilities
A basic bar graph or pie chart to show workout distribution over a week. Will implement if time allows
	Missed Must Haves: 1

Food Diary/ Meal View:
Calculation of calories Must have
Access to a comprehensive food database for accurate logging (api) Must have
Filters for different dietary preferences (e.g., vegan, keto). Will implement if time allows
Detailed Ingredients List Must have
Step-by-step Instructions Must have
Nutritional Information Must have
Preparation info and Cook Time Will implement if time allows
Skill Level and Difficulty Rating. Must have
Shopping List Integration Must have , export list to Nearby store (Walmart, instacart, target) Will not implement
Save or Bookmark Option Must have
Cuisine and Dietary Labels Must have
Missed Must Haves: 4

Mood and Feeling Tracker:

Mood Selection Must have
Quick Journaling : A space for brief notes about the day or specific events that might have influenced the mood, and or Prompts or questions to help users reflect Must have
Mood Patterns and Insights Will implement if time allows
Daily Quotes or Affirmations, Mood Boosters (API)  Must have
Users can note how they felt after eating (e.g., energized, bloated).  Must have
A basic bar graph or pie chart to show mood over the week  Must have
* User Info stored using Firestore Will implement if time allows 
*User Login stored using firebase ( not throughout app)
	Missed Must Haves: 0

New: Settings 
Login and Sign up capabilities
Store avatar Image on firestore
Sign out and and Delete account capabilities
New: Others 
Using Swift data for local storage and Data persistence (Carts and Notes)
Data persistence

 WISH LIST
Certain tasks were more difficult than others to accomplish during this short time period. Because of this I hope to include any item i missed in previous list: 
Show a brief summary of today's food intake, workout, and mood at a glance. 
A basic bar graph or pie chart to show workout distribution over a week.
Mood Patterns and Insights 

In the newer version I would like to also move away from the Meals view. This view complicated the goal of the app. Trying to tie in calorie tracking into the app may be confusing for the user: 
Remove Meal view

In the newer version I would like to expand upon the mental health portion: 
AI generated prompt for discussion 
Moderated Discussion like post for communities with metal health
Users would be able to create an account and discuss over articles and post created by professional (therapists, and psychiatrist)
Add in a game like component to encourage users to record health metrics and Journaling. For every update users gain xp and customize the mushroom icon. 

SELF EVALUATION AND DOCUMENTATION

I believe that I deserve a A- to A as a grade: 
  ​My app meets the product definition statement created in the proposal list document with a couple of must have missed. 
The Journal section of my app works very well. It uses swift data to store journal entries and displays the current date and Quote of the day using quotes from quotable api (dynamic data). 
I created my app using MVCs (Models and Views). Here are the list of models: 
Cart (SwiftData Model)
Notes (SwiftData Model)
User (Firebase user model)
Health (HealthManager)
Activity (SwiftData Model)
PhotoLibraryManager (Firebase image storage model)
Ingredient, Recipe and RecipeResponse (spoonacular api)
The use of Reusable code is seen throughout my project from views and models
My app uses  a solid UI Pattern throughout the app. Persistent views and colors across all pages 
The app save a couple of states when the user quits. (Cart, Journal entries, and Logged in User) 
Firebase Integration for user login and signout.
My app take advantage of watchOS hardware capabilities in recording HeartBeat using healthkit. 

Describe Classes and Views: 
All views an classes are commented above the “fold) with description. 
Ex: /**
     Determines whether the sign-up form is valid.
     
     The form is considered valid if the email is not empty, contains "@" and the password is not empty and has at least 6 characters. Additionally, the "Confirm Password" field must match the password, and the full name must not be empty.
     
     - Returns: `true` if the form is valid; otherwise, `false`.
     */

 
Document "above and beyond"
Firebase: Profile image is updated and saved using photopicker and stored in firestore.
SwiftData: Using swift data to save all user items on this device. 
HealthKit: 

Third party code: 
For Firebase and authorization code: class AuthViewModel
https://www.youtube.com/watch?v=QJHmhLGv-_0&ab_channel=AppStuff
Used Code By: AppStuff
For base HealthKit data calls: class HealthManager 
Fetch User's Step Data with HealthKit | Fitness App SwiftUI #1
https://www.youtube.com/watch?v=7vOF1kGnsmo&t=418s&ab_channel=JasonDubon
Used partial code by: Jason Dubon
For PhotoPicker: 
Task {
                            if let profilePick,
                               let data = try? await profilePick.loadTransferable(type: Data.self),
                               let image = UIImage(data: data) {
                                avatarImage = image
                                viewModel.uploadProfileImage(image) { result in
                                    switch result {
                                    case .success(let url):
                                        Task {
                                            await viewModel.updateUserProfileImageURL(url)
                                        }
                                    case .failure(let error):
                                        print("Error uploading profile image: \(error.localizedDescription)")
                                    }
                                }
                            }
                        }
https://www.youtube.com/watch?v=jCskmh46L-s&ab_channel=SeanAllen
Used partial code by: Sean Allen
Api calls for quote module and recipe api: 
https://www.youtube.com/watch?v=ERr0GXqILgc&ab_channel=SeanAllen
Used partial code by: Sean Allen
Environment object tutorial: 
https://www.youtube.com/watch?v=lxaEAHNmhY4&ab_channel=PaulHudson
Used partial code By: Paul Hudson
Git Hub APIs: 
https://github.com/lukePeavey/quotable
By : lukePeavey
